function out_dir = renderSfzLibrary(cfg, opts)
% RENDERSFZLIBRARY  Batch-render a candidate instrument to a playable SFZ.
%
% Given an instrument config (SETINSTRUMENTCONFIG_*), simulate one WAV per
% (MIDI note, velocity layer, pickup) tuple and emit one SFZ file per
% pickup that plays the whole keyboard range in a DAW.
%
% Sample-note selection
% ---------------------
% Within each gauge segment: start at midi_low, step by 3 (minor thirds),
% and ALWAYS include midi_high of the segment.  This guarantees that every
% SFZ region uses the correct gauge -- adjacent regions never straddle a
% gauge boundary.
%
% Key-range mapping
% -----------------
% Adjacent samples in the SAME gauge segment split at their midpoint
% (SFZ hikey/lokey).  Adjacent samples across a gauge boundary split at
% the boundary (hikey = midi_high of lower segment, lokey = midi_low of
% upper segment).  The first and last samples are hard-capped at
% cfg.midi_range.
%
% Velocity layers
% ---------------
% opts.velocities_mps (default [0.7 1.5 2.4]) map 1:1 to MIDI-velocity
% bands given by opts.velocity_midi_bands (default [[1 42];[43 85];[86 127]]).
%
% Normalization
% -------------
% A single amp_ref scalar is computed from the global peak across ALL
% samples (all pickups, notes, velocities) and applied uniformly to every
% WAV.  This preserves inter-sample level relationships so (a) velocity
% layers carry real loudness, (b) bridge vs. tangent pickup balance is
% honest, and (c) A/B comparisons across configs are meaningful when run
% with the same amp_ref target.
%
% Inputs
% ------
%   cfg  : output of SETINSTRUMENTCONFIG_*
%   opts : struct (all fields optional):
%          .out_root              parent folder for output (default: model_sim/sfz_out)
%          .velocities_mps        row vector, strike velocities per layer
%                                 (default [0.7 1.5 2.4])
%          .velocity_midi_bands   Nx2 [lovel hivel] per layer
%                                 (default [1 42; 43 85; 86 127])
%          .out_fs_Hz             WAV sample rate (default 48000)
%          .out_bitdepth          WAV bit depth (default 24)
%          .midi_notes            override sample-note list (default: computed)
%          .target_peak_dBFS      amp_ref target headroom (default -1)
%          .use_parfor            true to parallelize across notes
%                                 (default false; requires Parallel Toolbox)
%          .tag                   appended to output folder name, e.g.
%                                 'smoketest' -> <cfg>_<date>_smoketest
%          .verbose               true for per-note progress (default true)
%
% Output
% ------
%   out_dir : absolute path to the created library folder.
%
% Side effects: writes WAVs into out_dir/samples/, one SFZ per pickup at
% out_dir/<cfg.name>_<pickup>.sfz, and a manifest at out_dir/meta.json.
%
% See also: SETINSTRUMENTCONFIG_V0, DERIVEPERKEYPARAMS, WRITESFZFILE.

% ------------------------------------------------------------------------
% 1.  Option defaults
% ------------------------------------------------------------------------
if nargin < 2, opts = struct(); end
opts = defopt(opts, 'velocities_mps',      [0.7, 1.5, 2.4]);
opts = defopt(opts, 'velocity_midi_bands', [1 42; 43 85; 86 127]);
opts = defopt(opts, 'out_fs_Hz',           48000);
opts = defopt(opts, 'out_bitdepth',        24);
opts = defopt(opts, 'target_peak_dBFS',    -1);
opts = defopt(opts, 'use_parfor',          false);
opts = defopt(opts, 'tag',                 '');
opts = defopt(opts, 'verbose',             true);

here = fileparts(mfilename('fullpath'));
opts = defopt(opts, 'out_root', fullfile(here, 'sfz_out'));

nV = numel(opts.velocities_mps);
if size(opts.velocity_midi_bands, 1) ~= nV
    error('renderSfzLibrary:velMismatch', ...
          'velocities_mps has %d entries but velocity_midi_bands has %d rows.', ...
          nV, size(opts.velocity_midi_bands, 1));
end

% ------------------------------------------------------------------------
% 2.  Sample-note selection
% ------------------------------------------------------------------------
if isfield(opts, 'midi_notes') && ~isempty(opts.midi_notes)
    sample_notes = sort(opts.midi_notes(:).');
    note_segment = zeros(size(sample_notes));  % filled below
    for i = 1:numel(sample_notes)
        note_segment(i) = gaugeSegmentIndex(cfg, sample_notes(i));
    end
else
    sample_notes = [];
    note_segment = [];
    for s = 1:numel(cfg.gauge_segments)
        g = cfg.gauge_segments(s);
        in_seg = g.midi_low : 3 : g.midi_high;
        if in_seg(end) ~= g.midi_high
            in_seg(end+1) = g.midi_high; %#ok<AGROW>
        end
        sample_notes = [sample_notes, in_seg];                  %#ok<AGROW>
        note_segment = [note_segment, s * ones(1, numel(in_seg))]; %#ok<AGROW>
    end
end
N_notes = numel(sample_notes);
if opts.verbose
    fprintf('Sample-note list (%d pitches):\n  %s\n', N_notes, ...
            strjoin(arrayfun(@num2str, sample_notes, 'UniformOutput', false), ' '));
end

% ------------------------------------------------------------------------
% 3.  Key-range (lokey/hikey) assignment
% ------------------------------------------------------------------------
lokey = zeros(1, N_notes);
hikey = zeros(1, N_notes);
for i = 1:N_notes
    if i == 1
        lokey(i) = cfg.midi_range(1);
    elseif note_segment(i) ~= note_segment(i-1)
        % Gauge-boundary split.
        lokey(i) = cfg.gauge_segments(note_segment(i)).midi_low;
    else
        % Same-segment midpoint split, round toward the upper sample.
        lokey(i) = floor((sample_notes(i-1) + sample_notes(i)) / 2) + 1;
    end

    if i == N_notes
        hikey(i) = cfg.midi_range(2);
    elseif note_segment(i) ~= note_segment(i+1)
        hikey(i) = cfg.gauge_segments(note_segment(i)).midi_high;
    else
        hikey(i) = floor((sample_notes(i) + sample_notes(i+1)) / 2);
    end
end

% Sanity: regions must never overlap.  When the caller did NOT override
% midi_notes we additionally require that the full cfg.midi_range is
% covered; a user-supplied note list is allowed to be sparse (useful for
% smoke tests and partial-range experiments).
cover = zeros(1, cfg.midi_range(2) - cfg.midi_range(1) + 1);
for i = 1:N_notes
    idx = (lokey(i):hikey(i)) - cfg.midi_range(1) + 1;
    idx = idx(idx >= 1 & idx <= numel(cover));
    cover(idx) = cover(idx) + 1;
end
if any(cover > 1)
    bad = find(cover > 1) + cfg.midi_range(1) - 1;
    error('renderSfzLibrary:overlap', ...
          'Region overlap at MIDI notes: %s', num2str(bad));
end
user_supplied_notes = isfield(opts, 'midi_notes') && ~isempty(opts.midi_notes);
if ~user_supplied_notes && any(cover == 0)
    bad = find(cover == 0) + cfg.midi_range(1) - 1;
    error('renderSfzLibrary:gap', ...
          'Keyboard gap at MIDI notes: %s', num2str(bad));
end

% ------------------------------------------------------------------------
% 4.  Output folder
% ------------------------------------------------------------------------
date_tag = datestr(now, 'yyyymmdd_HHMMSS');
folder_name = sprintf('%s_%s', cfg.name, date_tag);
if ~isempty(opts.tag)
    folder_name = sprintf('%s_%s', folder_name, opts.tag);
end
out_dir     = fullfile(opts.out_root, folder_name);
samples_dir = fullfile(out_dir, 'samples');
if ~exist(samples_dir, 'dir')
    mkdir(samples_dir);
end
if opts.verbose
    fprintf('Output folder: %s\n', out_dir);
end

% ------------------------------------------------------------------------
% 5.  Simulate every (note, velocity) pair, collect raw resampled WAVs
% ------------------------------------------------------------------------
% Storage: N_notes x nV cell, each cell is [Np x Nout_samples].
nP = numel(cfg.pickups);
raw_wavs = cell(N_notes, nV);
cfl_all  = zeros(N_notes, nV);
peak_all = zeros(N_notes, nV, nP);

if opts.use_parfor
    parfor ni = 1:N_notes
        [raw_row, cfl_row, peak_row] = simulateOneNote( ...
            cfg, sample_notes(ni), opts.velocities_mps, opts.out_fs_Hz, nP);
        raw_wavs(ni, :)    = raw_row;
        cfl_all(ni, :)     = cfl_row;
        peak_all(ni, :, :) = peak_row;
    end
else
    for ni = 1:N_notes
        [raw_row, cfl_row, peak_row] = simulateOneNote( ...
            cfg, sample_notes(ni), opts.velocities_mps, opts.out_fs_Hz, nP);
        raw_wavs(ni, :)    = raw_row;
        cfl_all(ni, :)     = cfl_row;
        peak_all(ni, :, :) = peak_row;
        if opts.verbose
            fprintf('  midi %3d: cfl %.2f, peak [%.3g %.3g]\n', ...
                    sample_notes(ni), cfl_all(ni, 1), ...
                    max(peak_all(ni, :, 1)), max(peak_all(ni, :, 2)));
        end
    end
end

% ------------------------------------------------------------------------
% 6.  Global normalization
% ------------------------------------------------------------------------
global_peak = 0;
for ni = 1:N_notes
    for vi = 1:nV
        m = max(abs(raw_wavs{ni, vi}(:)));
        if m > global_peak, global_peak = m; end
    end
end
if global_peak <= 0
    error('renderSfzLibrary:silentLibrary', ...
          'All samples have zero peak -- simulator output is empty?');
end
target_lin = 10^(opts.target_peak_dBFS / 20);
amp_ref    = target_lin / global_peak;

if opts.verbose
    fprintf('\nGlobal peak across all WAVs: %.6g  (amp_ref = %.6g)\n', ...
            global_peak, amp_ref);
end

% ------------------------------------------------------------------------
% 7.  Write WAVs and build per-pickup region manifests
% ------------------------------------------------------------------------
% Pre-allocate a 0x0 struct array with the correct field set on each side
% so that the first append doesn't have to infer the schema.
empty_region = struct( ...
    'sample_rel',      {}, ...
    'pitch_keycenter', {}, ...
    'lokey',           {}, ...
    'hikey',           {}, ...
    'lovel',           {}, ...
    'hivel',           {});
regions_per_pickup = cell(nP, 1);
for p = 1:nP, regions_per_pickup{p} = empty_region; end

for ni = 1:N_notes
    for vi = 1:nV
        y = raw_wavs{ni, vi} * amp_ref;     % [nP x Nout]
        for p = 1:nP
            fname = sprintf('%s_midi%03d_vel%d.wav', ...
                            cfg.pickups(p).name, sample_notes(ni), vi);
            fpath = fullfile(samples_dir, fname);
            audiowrite(fpath, y(p, :).', opts.out_fs_Hz, ...
                       'BitsPerSample', opts.out_bitdepth);
            k = numel(regions_per_pickup{p}) + 1;
            regions_per_pickup{p}(k).sample_rel      = fullfile('samples', fname);
            regions_per_pickup{p}(k).pitch_keycenter = sample_notes(ni);
            regions_per_pickup{p}(k).lokey           = lokey(ni);
            regions_per_pickup{p}(k).hikey           = hikey(ni);
            regions_per_pickup{p}(k).lovel           = opts.velocity_midi_bands(vi, 1);
            regions_per_pickup{p}(k).hivel           = opts.velocity_midi_bands(vi, 2);
        end
    end
end

% ------------------------------------------------------------------------
% 8.  Write one SFZ per pickup
% ------------------------------------------------------------------------
header = struct( ...
    'cfg_name',    cfg.name, ...
    'render_date', datestr(now, 'yyyy-mm-dd HH:MM'), ...
    'git_commit',  tryGetGitCommit(here), ...
    'sim_fs_Hz',   cfg.sim.fs_Hz, ...
    'out_fs_Hz',   opts.out_fs_Hz, ...
    'duration_s',  cfg.sim.duration_s, ...
    'v_peak_mps',  opts.velocities_mps(:), ...
    'amp_ref_rms', amp_ref);

sfz_paths = cell(nP, 1);
for p = 1:nP
    header.pickup_name = cfg.pickups(p).name;
    sfz_paths{p} = fullfile(out_dir, ...
        sprintf('%s_%s.sfz', cfg.name, cfg.pickups(p).name));
    writeSfzFile(sfz_paths{p}, header, regions_per_pickup{p});
    if opts.verbose
        fprintf('Wrote %s\n', sfz_paths{p});
    end
end

% ------------------------------------------------------------------------
% 9.  Meta manifest
% ------------------------------------------------------------------------
meta = struct();
meta.cfg_name        = cfg.name;
meta.cfg_midi_range  = cfg.midi_range;
meta.sample_notes    = sample_notes;
meta.lokey           = lokey;
meta.hikey           = hikey;
meta.velocities_mps  = opts.velocities_mps;
meta.velocity_bands  = opts.velocity_midi_bands;
meta.out_fs_Hz       = opts.out_fs_Hz;
meta.sim_fs_Hz       = cfg.sim.fs_Hz;
meta.duration_s      = cfg.sim.duration_s;
meta.amp_ref         = amp_ref;
meta.global_peak     = global_peak;
meta.target_peak_dBFS = opts.target_peak_dBFS;
meta.pickups         = cfg.pickups;
meta.cfl_min         = min(cfl_all(:));
meta.render_date     = datestr(now, 'yyyy-mm-dd HH:MM:SS');
meta.git_commit      = tryGetGitCommit(here);
meta.sfz_files       = sfz_paths;

meta_path = fullfile(out_dir, 'meta.json');
saveMetaJson(meta_path, meta);

if opts.verbose
    fprintf('\nDone. Library root: %s\n', out_dir);
end

end  % renderSfzLibrary


% ========================================================================
% Helpers
% ========================================================================

function opts = defopt(opts, name, val)
if ~isfield(opts, name) || isempty(opts.(name))
    opts.(name) = val;
end
end

function s_idx = gaugeSegmentIndex(cfg, midi)
s_idx = 0;
for s = 1:numel(cfg.gauge_segments)
    g = cfg.gauge_segments(s);
    if midi >= g.midi_low && midi <= g.midi_high
        s_idx = s; return;
    end
end
if s_idx == 0
    error('renderSfzLibrary:noSegment', ...
          'MIDI %d is not covered by any gauge segment in cfg.', midi);
end
end

function [raw_row, cfl_row, peak_row] = simulateOneNote( ...
            cfg, midi, vels, out_fs_Hz, nP)
nV = numel(vels);
raw_row  = cell(1, nV);
cfl_row  = zeros(1, nV);
peak_row = zeros(1, nV, nP);
for vi = 1:nV
    params = derivePerKeyParams(cfg, midi, vels(vi));
    params = resolveParams(params);
    sim    = buildSimulator(params);
    [~, sig, diag] = simulateNote(params, sim);
    y = zeros(nP, round(params.sim.duration_s * out_fs_Hz));
    for p = 1:nP
        yp = resample(sig(p, :), out_fs_Hz, params.sim.fs_Hz);
        % resample can return a slightly different length than predicted;
        % trim/pad to a fixed duration so all WAVs are the same length.
        if numel(yp) >= size(y, 2)
            y(p, :) = yp(1:size(y, 2));
        else
            y(p, 1:numel(yp)) = yp;
        end
    end
    raw_row{vi}        = y;
    cfl_row(vi)        = diag.cfl_check;
    peak_row(1, vi, :) = max(abs(y), [], 2).';
end
end

function commit = tryGetGitCommit(here)
try
    [status, out] = system(sprintf('cd "%s" && git rev-parse --short HEAD', here));
    if status == 0
        commit = strtrim(out);
    else
        commit = '(unavailable)';
    end
catch
    commit = '(unavailable)';
end
end

function saveMetaJson(meta_path, meta)
% Small JSON writer that avoids toolbox dependency issues.
try
    txt = jsonencode(meta, 'PrettyPrint', true);
catch
    txt = jsonencode(meta);   % older MATLAB: no PrettyPrint
end
fid = fopen(meta_path, 'w');
if fid < 0
    warning('renderSfzLibrary:metaWrite', ...
            'Could not write meta.json to %s', meta_path);
    return;
end
fwrite(fid, txt);
fclose(fid);
end

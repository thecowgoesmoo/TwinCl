function [t, pickup_signals, params] = loadRecordedClips(options)
% LOADRECORDEDCLIPS  Load a matched pair of recorded C4 clips (bridge +
%                    tangent) and format them so they can be fed straight
%                    into ANALYZEOUTPUT / COMPARERUNS, exactly the way
%                    simulation output is.
%
% Expected clip naming (from the TC-002 segmentation pass):
%
%   <audio_dir>/TwinCl_TC-002_C4_bridge_<NN>.wav
%   <audio_dir>/TwinCl_TC-002_C4_tangent_<NN>.wav
%
% Both clips are 2 s, mono, 32-bit float, 44.1 kHz, with ~50 ms of pre-roll
% before the strike onset. Because each segmented clip shares the same
% pre-roll convention, bridge_NN and tangent_MM are approximately aligned
% on their attack transient even though they come from different strikes.
%
% Inputs:
%   options : (optional) struct with fields
%     .audio_dir       folder containing the WAV clips
%                      (default: '<repo>/prototypes/TC-002/media/audio')
%     .bridge_index    which bridge clip to load (default 4 -- mid ramp)
%     .tangent_index   which tangent clip to load (default 4 -- mid ramp)
%     .normalize       'none' | 'peak' | 'rms'   (default 'peak')
%                        'peak' -> divide each channel by max(abs(ch))
%                        'rms'  -> divide each channel by rms(ch) * sqrt(2)
%     .trim_preroll    true  -> crop both channels so the first sample
%                               is at the detected onset (default true)
%     .onset_thresh_dB relative-to-peak threshold for onset detection
%                      when trim_preroll is true (default -40 dB)
%     .note_label      string passed through to params.pitch.note
%                      (default 'C4')
%     .name            run label attached to params (default auto)
%
% Outputs:
%   t              : [1 x Nt] time vector (s), starts at 0
%   pickup_signals : [2 x Nt] row 1 = bridge, row 2 = tangent
%   params         : lightweight struct with just enough fields for
%                    ANALYZEOUTPUT / COMPARERUNS plot titles to work:
%                      .pitch.note
%                      .pitch.freq_Hz  (nominal, 261.63 Hz for C4)
%                      .pickups(1).name = 'bridge'
%                      .pickups(2).name = 'tangent'
%                      .recording.bridge_file
%                      .recording.tangent_file
%                      .recording.fs_Hz
%
% Typical usage:
%
%   [t, sig, p] = loadRecordedClips();
%   ana_meas = analyzeOutput(t, sig, p);
%
%   % Overlay a measured clip against a simulation run:
%   runs = {
%     struct('name','measured',  'params', p,  'analysis', ana_meas), ...
%     struct('name','simulated', 'params', p0, 'analysis', ana_sim)
%   };
%   compareRuns(runs, struct('pickup', 1));

%--- Defaults ------------------------------------------------------------
if nargin < 1, options = struct(); end

here = fileparts(mfilename('fullpath'));
default_audio = fullfile(here, '..', 'prototypes', 'TC-002', 'media', 'audio');

if ~isfield(options, 'audio_dir'),       options.audio_dir       = default_audio; end
if ~isfield(options, 'bridge_index'),    options.bridge_index    = 4;             end
if ~isfield(options, 'tangent_index'),   options.tangent_index   = 4;             end
if ~isfield(options, 'normalize'),       options.normalize       = 'peak';        end
if ~isfield(options, 'trim_preroll'),    options.trim_preroll    = true;          end
if ~isfield(options, 'onset_thresh_dB'), options.onset_thresh_dB = -40;           end
if ~isfield(options, 'note_label'),      options.note_label      = 'C4';          end

%--- Resolve filenames ---------------------------------------------------
bridge_file  = fullfile(options.audio_dir, ...
    sprintf('TwinCl_TC-002_%s_bridge_%02d.wav', options.note_label, options.bridge_index));
tangent_file = fullfile(options.audio_dir, ...
    sprintf('TwinCl_TC-002_%s_tangent_%02d.wav', options.note_label, options.tangent_index));

if ~isfile(bridge_file)
    error('loadRecordedClips:missingBridge', ...
          'Bridge clip not found: %s', bridge_file);
end
if ~isfile(tangent_file)
    error('loadRecordedClips:missingTangent', ...
          'Tangent clip not found: %s', tangent_file);
end

%--- Read audio ----------------------------------------------------------
[b_raw, fs_b] = audioread(bridge_file);
[g_raw, fs_t] = audioread(tangent_file);

if fs_b ~= fs_t
    error('loadRecordedClips:sampleRateMismatch', ...
          'Bridge fs=%g and tangent fs=%g differ.', fs_b, fs_t);
end
fs = fs_b;

% Collapse any incidental stereo to mono (these clips are recorded mono,
% but guard against tools that re-save with two identical channels).
b = mean(b_raw, 2);
g = mean(g_raw, 2);

%--- Optional normalization ---------------------------------------------
b = applyNormalization(b, options.normalize);
g = applyNormalization(g, options.normalize);

%--- Optional onset trim -------------------------------------------------
if options.trim_preroll
    b_onset = findOnset(b, fs, options.onset_thresh_dB);
    g_onset = findOnset(g, fs, options.onset_thresh_dB);
    b = b(b_onset:end);
    g = g(g_onset:end);
end

%--- Length-match (truncate to shared length) ---------------------------
Nt = min(numel(b), numel(g));
b = b(1:Nt);
g = g(1:Nt);

pickup_signals      = zeros(2, Nt);
pickup_signals(1,:) = b(:).';      % row 1: bridge
pickup_signals(2,:) = g(:).';      % row 2: tangent

t = (0:Nt-1) / fs;

%--- Build minimal params struct ----------------------------------------
params = struct();
params.pitch.note     = options.note_label;
params.pitch.freq_Hz  = nominalFreq(options.note_label);
params.pickups(1).name = 'bridge';
params.pickups(2).name = 'tangent';
params.recording.bridge_file  = bridge_file;
params.recording.tangent_file = tangent_file;
params.recording.fs_Hz        = fs;
params.recording.Nt           = Nt;
params.recording.duration_s   = Nt / fs;

end


% ======================================================================
function y = applyNormalization(x, mode)
switch lower(mode)
    case 'none'
        y = x;
    case 'peak'
        pk = max(abs(x));
        if pk > 0
            y = x / pk;
        else
            y = x;
        end
    case 'rms'
        r = sqrt(mean(x.^2));
        if r > 0
            y = x / (r * sqrt(2));      % sqrt(2) so sinusoids peak near 1
        else
            y = x;
        end
    otherwise
        error('loadRecordedClips:badNormalize', ...
              'Unknown normalize mode: %s', mode);
end
end


% ======================================================================
function idx = findOnset(x, fs, thresh_dB)
% Simple energy-based onset detector.  Returns the first sample whose
% short-window RMS exceeds (peak_rms + thresh_dB).  Because thresh_dB is
% negative, this fires shortly before the loud part begins.

win = max(8, round(0.002 * fs));            % 2 ms window
env = sqrt(movmean(x(:).^2, win));
peak_env = max(env);
if peak_env == 0
    idx = 1;
    return;
end
thr = peak_env * 10^(thresh_dB/20);
idx = find(env >= thr, 1, 'first');
if isempty(idx), idx = 1; end

% Back off a couple of ms so we keep a sliver of pre-attack context; this
% avoids chopping into the very first cycle of the transient.
idx = max(1, idx - round(0.003 * fs));
end


% ======================================================================
function f = nominalFreq(note_label)
% Minimal note -> frequency table for labels used in this project.
switch upper(note_label)
    case 'C4', f = 261.6256;
    case 'D6', f = 1174.659;
    otherwise
        % Fall back: parse "<letter><accidental?><octave>" via equal temp.
        f = parseNote(note_label);
end
end


function f = parseNote(note_label)
% Tiny fallback parser so this helper stays useful if we point it at
% clips for other notes later.  Accepts things like 'A4', 'Bb3', 'F#5'.
tokens = regexp(note_label, '^([A-Ga-g])([#bB]?)(-?\d+)$', 'tokens', 'once');
if isempty(tokens)
    warning('loadRecordedClips:unknownNote', ...
            'Could not parse note "%s"; using 0 Hz.', note_label);
    f = 0;
    return;
end
letter = upper(tokens{1});
accid  = tokens{2};
octave = str2double(tokens{3});

semis = containers.Map( ...
    {'C','D','E','F','G','A','B'}, ...
    {  0,   2,   4,   5,   7,   9,  11});
n = semis(letter);
if strcmpi(accid, '#'), n = n + 1; end
if strcmpi(accid, 'b'), n = n - 1; end
midi = 12 * (octave + 1) + n;
f = 440 * 2^((midi - 69)/12);
end

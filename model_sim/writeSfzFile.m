function writeSfzFile(sfz_path, header, regions)
% WRITESFZFILE  Emit a plain-text SFZ definition file.
%
% Inputs:
%   sfz_path : absolute or relative path to write
%   header   : struct with metadata fields used in the file header comment
%              .cfg_name        (string)
%              .pickup_name     (string, e.g. 'bridge' or 'tangent')
%              .render_date     (string, e.g. '2026-04-19 21:15')
%              .git_commit      (string, short hash or '(unavailable)')
%              .sim_fs_Hz       (scalar)
%              .out_fs_Hz       (scalar)
%              .duration_s      (scalar)
%              .v_peak_mps      ([N x 1] velocity layer strike velocities)
%              .amp_ref_rms     (scalar, global amplitude scale used on WAVs)
%   regions  : struct array, one element per SFZ <region>, with fields
%              .sample_rel      (string, path relative to sfz_path)
%              .pitch_keycenter (int MIDI of the sample's native pitch)
%              .lokey           (int MIDI, inclusive)
%              .hikey           (int MIDI, inclusive)
%              .lovel           (int MIDI velocity, inclusive)
%              .hivel           (int MIDI velocity, inclusive)
%
% The emitted SFZ uses <global> to set no-loop playback (so key-off
% triggers the amp-EG release properly -- 'one_shot' ignores release in
% most players), a moderate release fade, and amp_veltrack=0 so
% velocity-layer dynamics come from the simulated WAV amplitudes rather
% than from SFZ velocity scaling.
%
% See also: RENDERSFZLIBRARY.

fid = fopen(sfz_path, 'w');
if fid < 0
    error('writeSfzFile:cannotOpen', 'Could not open %s for writing.', sfz_path);
end
c = onCleanup(@() fclose(fid));

% --- Header comment block ----------------------------------------------
fprintf(fid, '// ====================================================================\n');
fprintf(fid, '// TwinCl simulated sample library\n');
fprintf(fid, '//   config   : %s\n',        header.cfg_name);
fprintf(fid, '//   pickup   : %s\n',        header.pickup_name);
fprintf(fid, '//   rendered : %s\n',        header.render_date);
fprintf(fid, '//   git      : %s\n',        header.git_commit);
fprintf(fid, '//   sim fs   : %g Hz  (downsampled to %g Hz for WAV)\n', ...
             header.sim_fs_Hz, header.out_fs_Hz);
fprintf(fid, '//   length   : %.2f s per note\n', header.duration_s);
fprintf(fid, '//   velocities: strike v_peak_mps = [%s] m/s\n', ...
             strjoin(arrayfun(@(x) sprintf('%.2f', x), header.v_peak_mps, ...
                              'UniformOutput', false), ', '));
fprintf(fid, '//   amp_ref_rms applied to every WAV: %.6g\n', header.amp_ref_rms);
fprintf(fid, '// --------------------------------------------------------------------\n');
fprintf(fid, '// Release: simulator has no physical damper model yet, so key-off\n');
fprintf(fid, '// triggers a short linear amp-EG fade as a stand-in.  loop_mode is\n');
fprintf(fid, '// no_loop (not one_shot) so that release actually fires.\n');
fprintf(fid, '// amp_veltrack=0: velocity dynamics live in the rendered WAVs.\n');
fprintf(fid, '// ====================================================================\n\n');

% --- Global block -------------------------------------------------------
fprintf(fid, '<global>\n');
fprintf(fid, 'loop_mode=no_loop\n');
fprintf(fid, 'ampeg_release=0.100\n');
fprintf(fid, 'amp_veltrack=0\n');
fprintf(fid, '\n');

% --- Regions, emitted in (pitch_keycenter, lovel) order for readability -
[~, order] = sortrows([[regions.pitch_keycenter].', [regions.lovel].']);
for k = order.'
    r = regions(k);
    fprintf(fid, '<region>\n');
    fprintf(fid, 'sample=%s\n',          strrep(r.sample_rel, filesep, '/'));
    fprintf(fid, 'pitch_keycenter=%d\n', r.pitch_keycenter);
    fprintf(fid, 'lokey=%d\n',           r.lokey);
    fprintf(fid, 'hikey=%d\n',           r.hikey);
    fprintf(fid, 'lovel=%d\n',           r.lovel);
    fprintf(fid, 'hivel=%d\n',           r.hivel);
    fprintf(fid, '\n');
end

end

function params = derivePerKeyParams(cfg, midi_note, v_peak_mps)
% DERIVEPERKEYPARAMS  Specialize an instrument config to a single MIDI note.
%
% Inputs:
%   cfg         : struct from SETINSTRUMENTCONFIG_*  (keyboard-wide config)
%   midi_note   : integer in cfg.midi_range          (e.g. 60 for C4)
%   v_peak_mps  : scalar initial-rotation peak velocity for this velocity
%                 layer (e.g. 0.7 / 1.5 / 2.4 m/s)
%
% Output:
%   params : struct in the schema expected by RESOLVEPARAMS -> BUILDSIMULATOR
%            -> SIMULATENOTE.  Identical shape to setParametersC4_TC002's
%            return, so downstream code needs no changes.
%
% This helper is the only place that translates "keyboard config +
% MIDI note" into the per-note params struct.  Keep the mapping rules
% explicit here rather than sprinkling them into the renderer.
%
% See also: SETINSTRUMENTCONFIG_V0, RENDERSFZLIBRARY.

% --- Validate inputs ----------------------------------------------------
if ~isscalar(midi_note) || midi_note ~= round(midi_note)
    error('derivePerKeyParams:badMidi', 'midi_note must be an integer scalar.');
end
if midi_note < cfg.midi_range(1) || midi_note > cfg.midi_range(2)
    error('derivePerKeyParams:outOfRange', ...
          'midi_note %d is outside cfg.midi_range [%d %d].', ...
          midi_note, cfg.midi_range(1), cfg.midi_range(2));
end
if ~isscalar(v_peak_mps) || ~(v_peak_mps > 0)
    error('derivePerKeyParams:badVel', 'v_peak_mps must be a positive scalar.');
end

% --- Pitch --------------------------------------------------------------
% Equal-tempered, A4 (MIDI 69) = 440 Hz.
freq_Hz = 440 * 2^((midi_note - 69) / 12);

params.pitch.note     = midiToName(midi_note);
params.pitch.freq_Hz  = freq_Hz;
params.pitch.midi     = midi_note;

% --- String length (linear-in-semitone interpolation) -------------------
L_mm = cfg.length_mm_at_F1 + cfg.length_mm_slope * (midi_note - 29);
if L_mm <= 0
    error('derivePerKeyParams:badLength', ...
          'Computed L = %.2f mm for MIDI %d -- check cfg.length_mm_* values.', ...
          L_mm, midi_note);
end

% --- Gauge lookup -------------------------------------------------------
d_mm = [];
for i = 1:numel(cfg.gauge_segments)
    g = cfg.gauge_segments(i);
    if midi_note >= g.midi_low && midi_note <= g.midi_high
        d_mm = g.d_mm;
        break;
    end
end
if isempty(d_mm)
    error('derivePerKeyParams:noGauge', ...
          'MIDI %d is not covered by any gauge segment in cfg.', midi_note);
end

% --- Assemble params struct in the shape resolveParams expects ----------
params.string.L_m        = 1e-3 * L_mm;
params.string.d_m        = 1e-3 * d_mm;
params.string.rho_kgm3   = cfg.string_material.rho_kgm3;
params.string.E_Pa       = cfg.string_material.E_Pa;
params.string.sigma0_Hz  = cfg.string_damping.sigma0_Hz;
params.string.sigma1_s   = cfg.string_damping.sigma1_s;

params.yarn    = cfg.yarn;
params.tangent = cfg.tangent;
params.bridge  = cfg.bridge;

params.pickups = cfg.pickups;

% Safety: make sure no pickup sits beyond the (short) string length.
for i = 1:numel(params.pickups)
    if params.pickups(i).x_m >= params.string.L_m
        error('derivePerKeyParams:pickupOffString', ...
              ['Pickup "%s" at x_m = %.4f m is >= string length %.4f m ' ...
               'at MIDI %d.  Either shorten pickup x_m in the config or ' ...
               'cap the keyboard range above MIDI %d.'], ...
              params.pickups(i).name, params.pickups(i).x_m, ...
              params.string.L_m, midi_note, midi_note - 1);
    end
end

params.excite.type       = cfg.excite.type;
params.excite.v_peak_mps = v_peak_mps;

params.sim = cfg.sim;

end


% ========================================================================
function name = midiToName(m)
% Conversational MIDI-to-name for logging ("C4", "F#3", etc.).
names = {'C','C#','D','D#','E','F','F#','G','G#','A','A#','B'};
octave = floor(m/12) - 1;
name   = sprintf('%s%d', names{mod(m,12)+1}, octave);
end

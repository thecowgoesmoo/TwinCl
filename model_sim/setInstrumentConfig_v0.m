function cfg = setInstrumentConfig_v0()
% SETINSTRUMENTCONFIG_V0  Keyboard-wide instrument configuration for the
%                         "v0 design" TwinCl build.
%
% This is the single config file you edit to define a *candidate instrument*
% for batch SFZ rendering.  It describes the geometry and material choices
% that vary across the keyboard (string length, gauge) plus the instrument-
% level knobs that are constant across notes (pickup positions, damping,
% excitation, sim controls).
%
% Source of numbers
% -----------------
%   * String lengths and gauges: StringLengths_v0.xlsx  (the design scale,
%     linear F1..E6 at ~13.28 mm/semitone; six wound/plain gauge segments).
%   * Pickup positions, damping, excitation: snapshot of the TC-002 C4 fit
%     as of the author's last parameter update (see setParametersC4_TC002.m).
%     Update the pickup_x_m fields here when the fit re-converges.
%
% Keyboard range
% --------------
%   F1 (MIDI 29) to E6 (MIDI 88), 60 keys, standard clavinet range.
%
% Returned struct layout
% ----------------------
%   cfg.name                : tag used in output folder names
%   cfg.midi_range          : [lo hi]
%   cfg.length_mm_slope     : mm shortening per +1 semitone
%   cfg.length_mm_at_F1     : L at MIDI 29 (longest string)
%   cfg.gauge_segments      : struct array, fields midi_low, midi_high, d_mm
%   cfg.pickups             : struct array matching setParameters* schema
%                             (x_m from bridge end, aperture_m)
%   cfg.string_material     : rho_kgm3, E_Pa
%   cfg.string_damping      : sigma0_Hz, sigma1_s  (copied to each rendered note)
%   cfg.bridge              : model, g0, fc_Hz
%   cfg.yarn                : L_m, sigma0_Hz  (not yet in the sim; carried through)
%   cfg.tangent             : mass_kg, k_N_per_m, alpha  (not yet in the sim)
%   cfg.excite              : type (scalar v_peak_mps is set per-velocity by
%                             the renderer)
%   cfg.sim                 : fs_Hz, duration_s, scheme, grid_safety
%
% See also: DERIVEPERKEYPARAMS, RENDERSFZLIBRARY.

cfg.name       = 'v0';
cfg.midi_range = [29, 88];        % F1 .. E6

%--- String-length schedule (linear in MIDI note) ------------------------
% From StringLengths_v0.xlsx: L(F1) = 0.977 m, L(E6) = 0.193 m,
% slope = (193 - 977) / (88 - 29) = -13.288 mm / semitone.
cfg.length_mm_at_F1 = 977.0;
cfg.length_mm_slope = -13.288;    % mm per semitone (negative = shorter going up)

%--- Gauge schedule ------------------------------------------------------
% Columns: midi_low, midi_high, d_mm.  Taken directly from v0 spreadsheet.
% Wound-vs-plain distinction is not yet modeled; we treat all as solid
% circular cross-section (d_mm is the overall diameter).  Rev this when
% a wound-string model lands.
gs(1) = struct('midi_low', 29, 'midi_high', 34, 'd_mm', 1.2954);  % F1..A#1
gs(2) = struct('midi_low', 35, 'midi_high', 39, 'd_mm', 1.0922);  % B1..D#2
gs(3) = struct('midi_low', 40, 'midi_high', 48, 'd_mm', 0.8890);  % E2..C3
gs(4) = struct('midi_low', 49, 'midi_high', 56, 'd_mm', 0.6096);  % C#3..G#3
gs(5) = struct('midi_low', 57, 'midi_high', 64, 'd_mm', 0.4572);  % A3..E4
gs(6) = struct('midi_low', 65, 'midi_high', 76, 'd_mm', 0.3556);  % F4..E5
gs(7) = struct('midi_low', 77, 'midi_high', 88, 'd_mm', 0.2540);  % F5..E6
cfg.gauge_segments = gs;

%--- Pickups (fixed absolute x_m from bridge, same for every note) -------
% Snapshot of the TC-002 C4 fit.  A typical note at the top of the range
% (E6, L = 193 mm) puts the bridge pickup at ~22% of the string and the
% tangent pickup at ~83% -- that tonal shift is a real consequence of
% fixed-geometry pickups, kept deliberately.
cfg.pickups(1).name       = 'bridge';
cfg.pickups(1).x_m        = 0.0426;
cfg.pickups(1).aperture_m = 0.030;
cfg.pickups(2).name       = 'tangent';
cfg.pickups(2).x_m        = 0.1607;
cfg.pickups(2).aperture_m = 0.030;

%--- String material (plain music-wire steel) ----------------------------
cfg.string_material.rho_kgm3 = 7850;
cfg.string_material.E_Pa     = 2.00e11;

%--- String damping (fit-derived, applied uniformly for now) -------------
% TODO: revisit once the fit produces a per-pitch damping schedule.
cfg.string_damping.sigma0_Hz = 0.3;
cfg.string_damping.sigma1_s  = 3e-3;

%--- Bridge termination (Phase 1 pinned) ---------------------------------
cfg.bridge.model = 'pinned';
cfg.bridge.g0    = 0.999;
cfg.bridge.fc_Hz = 8000;

%--- Yarn-damped back segment (carried through, not modeled yet) ---------
cfg.yarn.L_m       = 0.100;
cfg.yarn.sigma0_Hz = 200;

%--- Tangent / hammer (carried through, not modeled yet) -----------------
cfg.tangent.mass_kg   = 2e-3;
cfg.tangent.k_N_per_m = 1e8;
cfg.tangent.alpha     = 2.0;

%--- Excitation ----------------------------------------------------------
% Only .type is stored here; v_peak_mps is chosen per-velocity-layer by
% renderSfzLibrary (0.7 / 1.5 / 2.4 m/s by default).
cfg.excite.type = 'rigid_rotation';

%--- Simulation controls -------------------------------------------------
cfg.sim.fs_Hz       = 88200;
cfg.sim.duration_s  = 2.0;
cfg.sim.scheme      = 'semi_implicit';
cfg.sim.grid_safety = 1.05;

end

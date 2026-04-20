function params = setParametersC4_D6()
% SETPARAMETERSC4_D6  Clavinet model parameters for C4 on a Hohner D6.
%
% All units SI (meters, seconds, Hz, Pa, N, kg).
% Values marked "% tune" are first-guess placeholders to be calibrated
% against bench measurements on the TC-002 prototype.
%
% See RESOLVEPARAMS for how derived quantities (tension, grid spacing,
% time step, etc.) are computed from these primary parameters.
%
% Phase 1 scope: single-segment string, pinned-pinned boundaries, no
% tangent contact model (excitation is a prescribed initial velocity
% pulse), no bridge loss model (pinned termination), no pickup
% electrical response. Fields for later phases are populated so the
% same struct can carry through without schema changes.

%--- Target pitch ---------------------------------------------------------
params.pitch.note        = 'C4';
params.pitch.freq_Hz     = 261.63;

%--- String (plain music-wire steel) --------------------------------------
params.string.L_m        = 0.600;        % speaking length (anvil -> bridge)
params.string.d_m        = 0.229e-3;     % diameter (0.009")
params.string.rho_kgm3   = 7850;         % mass density, steel
params.string.E_Pa       = 2.00e11;      % Young's modulus, steel
params.string.sigma0_Hz  = 1.0;          % freq-indep. damping        % tune
params.string.sigma1_s   = 5e-5;         % freq-dep. damping          % tune

%--- Damped back segment (yarn-wrapped, not yet in the model) -------------
params.yarn.L_m          = 0.100;        % string back length (estimate)
params.yarn.sigma0_Hz    = 200;          % heavy damping              % tune

%--- Tangent / hammer (not yet in the model) ------------------------------
params.tangent.mass_kg      = 2e-3;      % effective striker mass     % tune
params.tangent.k_N_per_m    = 1e8;       % Hertzian stiffness         % tune
params.tangent.alpha        = 2.0;       % Hertzian exponent (rubber)
params.tangent.v_strike_mps = 1.0;       % strike velocity (input)

%--- Bridge termination (Phase 1: pinned; later: lossy low-pass) ----------
params.bridge.model      = 'pinned';     % Phase 1
params.bridge.g0         = 0.999;        %                             tune
params.bridge.fc_Hz      = 8000;         %                             tune

%--- Pickups --------------------------------------------------------------
% Positions measured from the bridge end (x = 0).
params.pickups(1).name        = 'bridge';
params.pickups(1).x_m         = 0.040;
params.pickups(1).aperture_m  = 0.020;
params.pickups(2).name        = 'tangent';
params.pickups(2).x_m         = 0.120;
params.pickups(2).aperture_m  = 0.020;

%--- Excitation (tangent strike: rigid-body rotation initial condition) ----
% The tangent simultaneously excites the string and becomes the nut at
% x = L_m.  Initial condition: v(x,0) = v_peak * x/L_m, u(x,0) = 0.
% See BUILDSIMULATOR for the implementation.
params.excite.type           = 'rigid_rotation';
params.excite.v_peak_mps     = 1.0;      % peak initial velocity       % tune

%--- Simulation controls --------------------------------------------------
params.sim.fs_Hz         = 88200;        % 2x audio, dispersion headroom
params.sim.duration_s    = 2.0;
params.sim.scheme        = 'semi_implicit';   % see BUILDSIMULATOR
params.sim.grid_safety   = 1.05;         % h margin above stability limit

end

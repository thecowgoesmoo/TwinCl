function params = resolveParams(params)
% RESOLVEPARAMS  Compute derived quantities from primary parameters.
%
% Input:
%   params : struct as returned by SETPARAMETERS*  (primary fields set)
%
% Output:
%   params : same struct with the following fields populated --
%     string.A_m2, string.mu, string.c, string.T_N,
%     string.I_m4, string.kappa2
%     sim.dt, sim.h, sim.N, sim.Nt, sim.t, sim.x
%
% Stability (pinned-pinned stiff damped string, Bilbao 2009):
%     h^2 >= ( c^2 k^2 + sqrt( c^4 k^4 + 16 kappa^2 k^2 ) ) / 2
% where kappa^2 = E I / mu and k = dt.

%--- String geometry & material ------------------------------------------
s = params.string;
s.A_m2   = pi * (s.d_m/2)^2;
s.mu     = s.rho_kgm3 * s.A_m2;
s.c      = 2 * params.pitch.freq_Hz * s.L_m;
s.T_N    = s.mu * s.c^2;
s.I_m4   = pi * s.d_m^4 / 64;
s.kappa2 = s.E_Pa * s.I_m4 / s.mu;
params.string = s;

%--- Time step ------------------------------------------------------------
params.sim.dt = 1 / params.sim.fs_Hz;
k  = params.sim.dt;
c  = s.c;
k2 = s.kappa2;

%--- Stability-constrained grid spacing -----------------------------------
h_min = sqrt( ( c^2*k^2 + sqrt( c^4*k^4 + 16*k2*k^2 ) ) / 2 );
h_use = h_min * params.sim.grid_safety;

% Integer number of intervals so boundaries sit on nodes.
N_int = floor(s.L_m / h_use);
if N_int < 4
    error(['resolveParams: grid too coarse (N_int = %d). ' ...
           'Either raise fs_Hz or lower grid_safety.'], N_int);
end
params.sim.h  = s.L_m / N_int;
params.sim.N  = N_int + 1;

%--- Time and space vectors ----------------------------------------------
params.sim.Nt = round(params.sim.duration_s / k);
params.sim.t  = (0:params.sim.Nt-1) * k;
params.sim.x  = linspace(0, s.L_m, params.sim.N);

%--- Record a small summary for sanity-checking ---------------------------
params.derived.f_target_Hz    = params.pitch.freq_Hz;
params.derived.wavespeed_mps  = c;
params.derived.tension_N      = s.T_N;
params.derived.inharmonicity_B = pi^2 * s.E_Pa * s.I_m4 / (s.T_N * s.L_m^2);
params.derived.h_min_mm       = 1e3 * h_min;
params.derived.h_used_mm      = 1e3 * params.sim.h;
params.derived.N_points       = params.sim.N;
params.derived.N_timesteps    = params.sim.Nt;

end

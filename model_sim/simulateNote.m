function [t, pickup_signals, diagnostics] = simulateNote(params, sim)
% SIMULATENOTE  Time-domain simulation of one struck string, one pluck.
%
% Advances the semi-implicit FD scheme assembled in BUILDSIMULATOR and
% records pickup signals and energy diagnostics.
%
% Inputs:
%   params : struct post-RESOLVEPARAMS
%   sim    : struct from BUILDSIMULATOR
%
% Outputs:
%   t               : [1 x Nt] time vector (s)
%   pickup_signals  : [Np x Nt] pickup velocity-integral signals
%                     (arbitrary units proportional to induced voltage)
%   diagnostics     : struct with fields
%                       .energy_proxy  (unitless scalar per step)
%                       .peak_disp_m   (max |u| over the run)
%                       .cfl_check     (scalar, should be >= 1)
%                       .params_copy   (snapshot of params)

Ni = sim.Ni;
Nt = params.sim.Nt;
k  = params.sim.dt;
Np = numel(params.pickups);

% --- Initialization -----------------------------------------------------
% Start from rest; impart the velocity pulse by setting state at t = k.
% Physical picture: at t = 0 the string is at rest; over the first dt
% the excitation acts to give a displacement k*v0 at t = k.
Upast = zeros(Ni, 1);         % U at t = 0
Ucur  = k * sim.v0(:);        % U at t = k  (first-order consistent IC)

pickup_signals = zeros(Np, Nt);
energy_proxy   = zeros(1, Nt);
peak_disp      = 0;

B  = sim.B;
C  = sim.C;
dA = sim.dA;
W  = sim.pickup_w;            % interior x Np
h  = sim.pickup_h;

% --- Main loop ----------------------------------------------------------
for n = 1:Nt
    % Advance one step
    rhs  = B * Ucur + C * Upast;
    Unew = dA \ rhs;

    % Sample velocity at the CURRENT time index via centered diff
    vel  = (Unew - Upast) / (2 * k);

    % Pickup output: spatially-weighted integral of velocity
    pickup_signals(:, n) = (vel.' * W * h).';

    % Energy proxy: kinetic (mu * v^2 / 2) summed over grid
    energy_proxy(n) = 0.5 * params.string.mu * sum(vel.^2) * h;

    % Diagnostic: largest displacement seen so far
    peak_disp = max(peak_disp, max(abs(Unew)));

    % Shift state
    Upast = Ucur;
    Ucur  = Unew;
end

t = (0:Nt-1) * k;

% --- Diagnostics --------------------------------------------------------
% CFL-like margin check: dimensionless.  Should be >= 1 for stability.
cfl_check = sim.pickup_h / (params.string.c * k);

diagnostics.energy_proxy = energy_proxy;
diagnostics.peak_disp_m  = peak_disp;
diagnostics.cfl_check    = cfl_check;
diagnostics.params_copy  = params;

end

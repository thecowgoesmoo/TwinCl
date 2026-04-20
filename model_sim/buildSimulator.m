function sim = buildSimulator(params)
% BUILDSIMULATOR  Precompute operators, weights, and initial conditions.
%
% Input:
%   params : struct post-RESOLVEPARAMS
%
% Output:
%   sim : struct carrying everything SIMULATENOTE needs --
%     Dxx, Dxxxx    sparse spatial difference operators (interior only)
%     A, B, C       sparse matrices for the semi-implicit step
%     dA            factorization of A for repeated solves
%     Ni, N         interior count and total count
%     pickup_w      pickup spatial weights (interior x Npickups)
%     pickup_h      grid spacing (for dot-product integration)
%     v0            initial velocity vector (interior nodes)
%
% Time step (linear stiff damped string, pinned-pinned):
%     A U^{n+1} = B U^n + C U^{n-1}
% with
%     A = (1 + s0 k) I - s1 k Dxx
%     B = 2 I + k^2 ( c^2 Dxx - kappa^2 Dxxxx )
%     C = (s0 k - 1) I - s1 k Dxx
%
% Boundary conditions: simply-supported (pinned).
%   u = 0 and u_xx = 0 at both ends.
%   Only interior nodes are advanced; ghost points handled via stencil
%   modification at the first and last interior rows of Dxxxx.

N   = params.sim.N;
h   = params.sim.h;
k   = params.sim.dt;
c   = params.string.c;
k2  = params.string.kappa2;
s0  = params.string.sigma0_Hz;
s1  = params.string.sigma1_s;

Ni = N - 2;      % number of interior nodes
e  = ones(Ni, 1);

%--- Second-difference operator (Dirichlet BCs implicit) ------------------
Dxx = spdiags([e, -2*e, e], [-1, 0, 1], Ni, Ni) / h^2;

%--- Fourth-difference operator with simply-supported ghost correction ----
% Standard interior stencil: [1 -4 6 -4 1] / h^4.
% SS BC gives u_{-1} = -u_1, which changes the main diagonal at the first
% interior row from 6 to 5. Same for the last interior row.
main = 6*e;
main([1 end]) = 5;
Dxxxx = spdiags([e, -4*e, main, -4*e, e], [-2, -1, 0, 1, 2], Ni, Ni) / h^4;

%--- Time-step matrices ---------------------------------------------------
I = speye(Ni);
A = (1 + s0*k) * I - s1*k * Dxx;
B = 2*I + k^2 * (c^2 * Dxx - k2 * Dxxxx);
C = (s0*k - 1) * I - s1*k * Dxx;

% Precompute factorization of A (symmetric positive definite)
dA = decomposition(A, 'chol');

sim.Dxx    = Dxx;
sim.Dxxxx  = Dxxxx;
sim.A      = A;
sim.B      = B;
sim.C      = C;
sim.dA     = dA;
sim.Ni     = Ni;
sim.N      = N;

%--- Pickup spatial weights ----------------------------------------------
% Each pickup senses a Gaussian-weighted spatial average of string velocity.
% Aperture is interpreted as FWHM of the Gaussian sensitivity.
Np = numel(params.pickups);
x  = params.sim.x(:);
pw_full = zeros(N, Np);
for p = 1:Np
    xp    = params.pickups(p).x_m;
    sigma = params.pickups(p).aperture_m / 2.355;   % FWHM -> Gaussian sigma
    w     = exp(-0.5 * ((x - xp)/sigma).^2);
    % Normalize so spatial integral (trapezoidal) equals 1
    w     = w / (sum(w) * h);
    pw_full(:, p) = w;
end
sim.pickup_w_full = pw_full;
sim.pickup_w      = pw_full(2:end-1, :);   % interior slice
sim.pickup_h      = h;

%--- Initial-velocity excitation (linear gradient / rigid-body rotation) --
% Physical model: the tangent simultaneously strikes and becomes the nut at
% x = L_m.  The string undergoes rigid-body rotation about the bridge
% (x = 0), giving a linear initial velocity gradient:
%   v(x, 0) = v_peak * x / L_m
% from 0 at the bridge to v_peak just inside the nut end.
% Boundary nodes (pinned) are held at zero.
vpk     = params.excite.v_peak_mps;
v0_full = vpk * (x / params.string.L_m);
v0_full([1 end]) = 0;    % enforce pinned BCs
sim.v0_full = v0_full;
sim.v0      = v0_full(2:end-1);

end

function [cost, details] = fitObjective(x, paths, transforms, xlb, xub, ...
                                         p_base, ana_meas, weights)
% FITOBJECTIVE  Scalar cost comparing a simulation to a measured analysis.
%
% Inputs:
%   x          : parameter vector in the transformed (fit) space
%   paths      : cellstr of dotted paths into the params struct, e.g.
%                {'string.sigma0_Hz', 'pickups(1).x_m', ...}
%   transforms : cellstr, one per path.  'lin' -> x is the value,
%                                       'log' -> value = 10.^x.
%   xlb, xub   : vectors of lower/upper bounds in the transformed space
%                (clamped softly so fminsearch can't wander off a cliff).
%   p_base     : base params struct (RESOLVEPARAMS-ready).  Fields named in
%                `paths` are overwritten from x; everything else is inherited.
%   ana_meas   : measured analysis struct (from ANALYZEOUTPUT on the
%                measured pickup signals).
%   weights    : (optional) struct with fields
%                  .spectral  (default 1.0) -- weight on log-PSD distance
%                  .decay     (default 0.5) -- weight on RMS-envelope slope
%                  .band_Hz   (default [40 8000]) -- spectral band
%                  .env_window_s (default 0.020) -- RMS envelope window
%
% Outputs:
%   cost    : scalar >= 0
%   details : (optional) struct with fields
%                .ana_sim     -- analysis from the trial simulation
%                .params      -- the trial params struct (post-resolve)
%                .component   -- per-term cost breakdown

if nargin < 8, weights = struct(); end
if ~isfield(weights, 'spectral'),     weights.spectral     = 1.0;      end
if ~isfield(weights, 'decay'),        weights.decay        = 0.5;      end
if ~isfield(weights, 'band_Hz'),      weights.band_Hz      = [40 8000]; end
if ~isfield(weights, 'env_window_s'), weights.env_window_s = 0.020;    end
if ~isfield(weights, 'smooth_Hz'),    weights.smooth_Hz    = 150;       end

%--- 1) Apply fit vector to base params ---------------------------------
x = min(max(x(:).', xlb(:).'), xub(:).');      % soft clamp
p = p_base;
for i = 1:numel(paths)
    if strcmp(transforms{i}, 'log')
        v = 10^x(i);
    else
        v = x(i);
    end
    eval(sprintf('p.%s = v;', paths{i}));
end

%--- 2) Run sim ----------------------------------------------------------
try
    p   = resolveParams(p);
    sim = buildSimulator(p);
    [t, sig, ~] = simulateNote(p, sim);
    ana = analyzeOutput(t, sig, p, struct('plot', false));
catch err
    cost    = 1e6;
    details = struct('error', err.message);
    return;
end

%--- 3) Cost components --------------------------------------------------
c_spec  = spectralLogDistance(ana_meas, ana, weights.band_Hz, weights.smooth_Hz);
c_decay = envelopeDecayDistance(ana_meas, ana, weights.env_window_s);

cost = weights.spectral * c_spec + weights.decay * c_decay;

if nargout > 1
    details = struct('ana_sim',   ana, ...
                     'params',    p, ...
                     'component', struct('spectral', c_spec, ...
                                         'decay',    c_decay));
end
end


% ======================================================================
function c = spectralLogDistance(ana_m, ana_s, band_Hz, smooth_Hz)
% RMS distance between smoothed log-magnitude PSDs, mean-subtracted so the
% optimizer cannot win by matching overall gain.
%
% Smoothing (movmean over ~smooth_Hz bandwidth) collapses the narrow
% harmonic peaks into a spectral envelope before comparison.  Without it,
% the cost is dominated by exact harmonic-bin alignment rather than
% spectral shape — a tiny fundamental-frequency offset shifts every
% harmonic and inflates the cost by tens of dB² even when the envelope
% matches well.
if nargin < 4 || isempty(smooth_Hz), smooth_Hz = 150; end

Np  = size(ana_m.psd_w, 2);
f_m = ana_m.f(:);
df  = mean(diff(f_m));
N_sm = max(1, round(smooth_Hz / df));   % window width in bins

band = f_m >= band_Hz(1) & f_m <= min(band_Hz(2), ana_m.fs/2);

c = 0;
for p = 1:Np
    % Smooth the linear-scale PSD, then take log.
    psd_m_sm = movmean(ana_m.psd_w(:, p), N_sm);
    lm = 10*log10(psd_m_sm + eps);

    if numel(ana_s.f) == numel(f_m) && all(ana_s.f(:) == f_m)
        psd_s = ana_s.psd_w(:, p);
    else
        psd_s = interp1(ana_s.f, ana_s.psd_w(:, p), f_m, 'linear', 'extrap');
        psd_s = max(psd_s, 0);
    end
    psd_s_sm = movmean(psd_s, N_sm);
    ls = 10*log10(psd_s_sm + eps);

    lm_b = lm(band); lm_b = lm_b - mean(lm_b);
    ls_b = ls(band); ls_b = ls_b - mean(ls_b);
    c = c + mean((lm_b - ls_b).^2);
end
c = c / Np;
end


% ======================================================================
function c = envelopeDecayDistance(ana_m, ana_s, env_window_s)
% Fit a single exponential to the short-window RMS envelope (in dB) over
% the usable decay region of each signal, and penalize the slope mismatch.
Np = size(ana_m.signals, 1);
c  = 0;
for p = 1:Np
    [~, slope_m] = envelopeSlope(ana_m.signals(p, :), ana_m.fs, env_window_s);
    [~, slope_s] = envelopeSlope(ana_s.signals(p, :), ana_s.fs, env_window_s);
    % Slope units: dB/s.  Normalize by a typical clavinet decay scale
    % (~20 dB/s) so the penalty is O(1) for O(1) relative error.
    c = c + ((slope_s - slope_m) / 20).^2;
end
c = c / Np;
end


function [env_dB, slope_dB_s] = envelopeSlope(sig, fs, window_s)
nw  = max(2, round(window_s * fs));
env = sqrt(movmean(sig(:).^2, nw));
env_dB = 20*log10(env + eps);
ts  = (0:numel(env)-1) / fs;

% Use the portion from just after attack to most of the tail.
[pk, i_pk] = max(env_dB);
t_start = ts(i_pk) + 0.030;                    % skip the attack lobe
t_end   = min(ts(end), t_start + 1.0);          % up to 1 s of decay
%mask = ts >= t_start & ts <= t_end & env_dB > pk - 50;   % ignore noise floor
mask = ts' >= t_start & ts' <= t_end & env_dB > pk - 50;   % ignore noise floor
if nnz(mask) < 50
    slope_dB_s = 0;
    return;
end
%try
    pfit = polyfit(ts(mask), env_dB(mask)', 1);
%catch
%    keyboard;
%end
slope_dB_s = pfit(1);
end

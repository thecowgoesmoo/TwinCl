% FITPARAMETERSTC002  Overnight-friendly parameter fit for the C4 / TC-002
%                     string model.
%
% Pipeline:
%   1. Load a measured pair (bridge + tangent) via LOADRECORDEDCLIPS.
%   2. Use SETPARAMETERSC4_TC002 as the physical baseline (things actually
%      measured on the prototype stay fixed).
%   3. Pick a handful of weakly-known knobs (damping, excitation, pickup
%      positions) and let an optimizer minimize the distance between the
%      simulation's weighted PSD and the measurement's.  Amplitude scale
%      is removed before comparison so the optimizer cannot win by just
%      matching loudness.
%   4. Run N_SEEDS random restarts of Nelder-Mead (fminsearch), keep the
%      best, and plot the measured vs fitted curves with the same
%      peak-trace overlay that COMPAREPUNS uses elsewhere.
%
% All the fit-configuration knobs live in the block below.  Edit it, then
% run the script; no other edits should be needed for an overnight pass.
%
% Persistence: a .mat file is written after every seed so a crash or kill
% at 3am still leaves you with whatever runs completed.

clear; clc; close all;

%==========================================================================
%  CONFIGURATION
%==========================================================================

% --- Which measured clips to fit against --------------------------------
clip_opts = struct( ...
    'bridge_index',  4, ...        % mid-ramp: bridge_03 or bridge_04 are sensible
    'tangent_index', 4, ...        % mid-ramp: tangent_04 or tangent_05
    'normalize',    'peak', ...
    'trim_preroll', true);

% --- Fit specification ---------------------------------------------------
% Columns:  name, dotted path into params, lower bound, upper bound, 'lin'|'log'
% The initial value is pulled from p_base (setParametersC4_TC002), so keep
% that file updated with your current best hand-tune and the optimizer
% will start there.
fit_spec = {
%    name           dotted path                  lb         ub        transform
    'sigma0',       'string.sigma0_Hz',          0.05,      0.7,      'lin';%3.0,      'lin';%'log';
    'sigma1',       'string.sigma1_s',           0.001,    0.01,     'lin';%'log';%1e-5,      3e-2,     'log';
    'x_excite',     'excite.x_m',                0.485,     0.494,    'lin';
    'w_excite',     'excite.width_m',            0.005,     0.100,    'lin';
    'v_excite',     'excite.v_peak_mps',         0.2,       3.0,      'lin';%'log';
    'x_bridge',     'pickups(1).x_m',            0.020,     0.060,    'lin';
    'x_tangent',    'pickups(2).x_m',            0.140,     0.170,    'lin';
};

% --- Cost weighting ------------------------------------------------------
cost_weights = struct( ...
    'spectral',     1.0, ...       % log-PSD RMS distance (dominant)
    'decay',        0.5, ...       % RMS-envelope slope matching
    'band_Hz',      [40 8000], ... % spectral band of interest
    'env_window_s', 0.020);

% --- Optimizer settings --------------------------------------------------
n_seeds    = 100;%100;%8;            % set 1 for a single (fast) pass; 8-16 for overnight
max_iter   = 300;%300;          % per-seed iteration cap
rand_seed  = 1;            % reproducibility for multi-start perturbation

%==========================================================================
%  SETUP
%==========================================================================

here = fileparts(mfilename('fullpath'));
log_tag  = datestr(now, 'yyyymmdd_HHMMSS');
log_path = fullfile(here, sprintf('fit_TC002_%s.mat', log_tag));

fprintf('Fit output will be saved to:\n  %s\n\n', log_path);

% --- Load measurement ---------------------------------------------------
fprintf('Loading measured clips...\n');
[tm, sigm, pm] = loadRecordedClips(clip_opts);
%sigm = sigm./10; %rkmoore: Kludge to try to match scales, but not needed
%for successful parameter fitting.  
ana_meas       = analyzeOutput(tm, sigm, pm, struct('plot', false));

% --- Load baseline ------------------------------------------------------
p_base = setParametersC4_TC002();

% --- Pull init values from p_base and pack transforms -------------------
names      = fit_spec(:, 1);
paths      = fit_spec(:, 2);
lbs        = cell2mat(fit_spec(:, 3));
ubs        = cell2mat(fit_spec(:, 4));
transforms = fit_spec(:, 5);

% Validate every path resolves against p_base BEFORE we do any heavy work.
inits = zeros(numel(paths), 1);
for i = 1:numel(paths)
    try
        inits(i) = eval(sprintf('p_base.%s', paths{i}));
    catch err
        error('fitParametersTC002:badPath', ...
              ['Could not read fit_spec path "%s" from p_base.\n' ...
               '  Reason: %s\n' ...
               '  Check that setParametersC4_TC002 actually has this field.'], ...
              paths{i}, err.message);
    end
    if ~isnumeric(inits(i)) || ~isscalar(inits(i))
        error('fitParametersTC002:nonScalarInit', ...
              'Path "%s" did not resolve to a scalar number.', paths{i});
    end
end

% Map linear-space values to fit-space (log or lin).
x0  = zeros(size(inits));
xlb = zeros(size(inits));
xub = zeros(size(inits));
for i = 1:numel(inits)
    if strcmp(transforms{i}, 'log')
        x0(i)  = log10(inits(i));
        xlb(i) = log10(lbs(i));
        xub(i) = log10(ubs(i));
    else
        x0(i)  = inits(i);
        xlb(i) = lbs(i);
        xub(i) = ubs(i);
    end
end

objfun = @(x) fitObjective(x, paths, transforms, xlb, xub, ...
                           p_base, ana_meas, cost_weights);

fprintf('Fit variables (%d):\n', numel(paths));
for i = 1:numel(paths)
    fprintf('  %-10s  init = %12.5g   bounds = [%9.4g .. %9.4g]   (%s)\n', ...
            names{i}, inits(i), lbs(i), ubs(i), transforms{i});
end
fprintf('Measured signal: %.2f s at fs = %g Hz per pickup\n\n', ...
        size(ana_meas.signals, 2) / ana_meas.fs, ana_meas.fs);

%==========================================================================
%  MULTI-START NELDER-MEAD
%==========================================================================

rng(rand_seed);
seeds = zeros(n_seeds, numel(x0));
seeds(1, :) = x0(:)';
for s = 2:n_seeds
    seeds(s, :) = xlb(:).' + (xub(:).' - xlb(:).') .* rand(1,numel(x0));%rand(1, numel(x0));
end

results = cell(n_seeds, 1);
baseline_cost = objfun(x0);
fprintf('Baseline cost (hand-tuned starting point): %.5f\n\n', baseline_cost);

for s = 1:n_seeds
    fprintf('=== Seed %d/%d =============================================\n', s, n_seeds);
    fprintf('  start:'); fprintf(' %+.3f', seeds(s, :)); fprintf('\n');

    opts = optimset( ...
        'Display',     'iter', ...
        'MaxIter',     max_iter, ...
        'MaxFunEvals', 8 * max_iter, ...
        'TolX',        1e-4, ...
        'TolFun',      1e-3);

    t_seed = tic;
    [x_best, cost_best, flag, out] = fminsearch(objfun, seeds(s, :), opts);
    elapsed = toc(t_seed);

    results{s} = struct( ...
        'seed_index', s, ...
        'x_start',    seeds(s, :), ...
        'x_best',     x_best, ...
        'cost_best',  cost_best, ...
        'exitflag',   flag, ...
        'iterations', out.iterations, ...
        'elapsed_s',  elapsed);

    fprintf('  done: cost = %.5f  (%.1f min, %d iter, flag=%d)\n\n', ...
            cost_best, elapsed/60, out.iterations, flag);

    % Persist after every seed.
    save(log_path, 'results', 'fit_spec', 'cost_weights', 'clip_opts', ...
                   'p_base', 'ana_meas', 'baseline_cost', '-v7.3');
end

%==========================================================================
%  PICK BEST, REPORT, PLOT
%==========================================================================

costs = cellfun(@(r) r.cost_best, results);
[~, i_best] = min(costs);
x_final     = results{i_best}.x_best;

% Clamp x_final to bounds before applying — fminsearch stores the raw
% (unclamped) vector; fitObjective clamped it internally, so the best
% *simulated* point is the clamped version.
x_final = min(max(x_final(:).', xlb(:).'), xub(:).');

fprintf('\n=== Best fit across %d seeds ================================\n', n_seeds);
fprintf('  baseline cost : %.5f\n', baseline_cost);
fprintf('  best cost     : %.5f   (improvement %.2f dB)\n\n', ...
        costs(i_best), 10*log10(baseline_cost / max(costs(i_best), eps)));

% Apply best fit to base params and re-simulate for the diagnostic plot.
p_fit = p_base;
for i = 1:numel(paths)
    if strcmp(transforms{i}, 'log'), v = 10^x_final(i); else, v = x_final(i); end
    eval(sprintf('p_fit.%s = v;', paths{i}));
    fprintf('  %-10s  %12.5g   (was %.5g, [%.4g .. %.4g])\n', ...
            names{i}, v, inits(i), lbs(i), ubs(i));
end

p_fit   = resolveParams(p_fit);
sim_fit = buildSimulator(p_fit);
[tf, sigf, diagf] = simulateNote(p_fit, sim_fit);
ana_fit = analyzeOutput(tf, sigf, p_fit, struct('plot', false));

fprintf('\nPeak displacement (fitted sim): %.3e m\n', diagf.peak_disp_m);
fprintf('CFL margin (>= 1)            : %.3f\n\n',   diagf.cfl_check);

% Final comparison plot using the same peak-trace overlay we use elsewhere.
runs = {
    struct('name', 'measured', 'params', pm,    'analysis', ana_meas), ...
    struct('name', 'fit',      'params', p_fit, 'analysis', ana_fit)
};
compareRuns(runs, struct('pickup', 1));
set(gcf, 'Name', 'TC-002 fit: bridge pickup');
compareRuns(runs, struct('pickup', 2));
set(gcf, 'Name', 'TC-002 fit: tangent pickup');

% Save the final params snapshot too for easy re-use.
save(log_path, 'p_fit', 'x_final', 'ana_fit', '-append');

fprintf('Results saved to:\n  %s\n', log_path);



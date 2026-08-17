function [f0, B, diagOut] = fitHCTparams(aa, Fs, varargin)
%fitHCTparams  Estimate fundamental frequency and inharmonicity from HCT matrix.
%
%   [f0, B] = fitHCTparams(aa, Fs)
%   [f0, B] = fitHCTparams(aa, Fs, 'f0Range', [flo fhi], ...)
%   [f0, B, diagOut] = fitHCTparams(...)   % also returns diagnostic struct
%
%   WHAT THIS DOES
%   --------------
%   For a vibrating string, the nth partial (overtone) sits not at exactly
%   n*f0, but at:
%
%       f_n = n * f0 * sqrt(1 + B * n^2)                       (1)
%
%   where B is the inharmonicity coefficient (related to string stiffness).
%   B=0 recovers the ideal harmonic series; larger B stretches higher
%   partials progressively sharp.
%
%   In the HCT matrix, the column for candidate fundamental bin k0 and the
%   row for harmonic number n together index FFT bin (n*k0).  Under
%   inharmonicity, the bright cell for partial n actually lies at column:
%
%       k_n = k0 * sqrt(1 + B * n^2)                           (2)
%
%   rather than k0.  This traces a "snail trail" curving rightward through
%   the HCT matrix as n increases.
%
%   The algorithm scores every (f0, B) candidate by summing the (filtered)
%   HCT magnitude along the trail predicted by equation (2), then returns
%   the pair with the highest mean per-harmonic score.  A two-stage
%   coarse-then-fine search keeps the computation tractable.
%
%   CONNECTION TO VITERBI / DYNAMIC PROGRAMMING
%   -------------------------------------------
%   If the trail model (eq. 2) were unknown, one would instead search for
%   the brightest *connected path* through the HCT matrix, allowing the
%   column to shift by at most a few bins between successive harmonic rows.
%   That is exactly the Viterbi algorithm: row = time step, column = state,
%   HCT magnitude = emission score, column continuity = transition cost.
%   Here we have a parametric model, so the path is determined by just two
%   numbers (f0, B), which reduces the search to a 2-D grid rather than a
%   full DP over all possible paths.
%
%   INPUTS
%     aa          HCT matrix returned by HCT.m
%                 Rows = harmonic index (1..max_harm)
%                 Cols = candidate fundamental bin (1..max_col)
%     Fs          Sample rate of the original audio (Hz)
%
%   NAME-VALUE OPTIONS
%     'f0Range'     [flo fhi]   f0 search band in Hz       (default [50 2000])
%     'BRange'      [Blo Bhi]   inharmonicity search band  (default [0 2e-3])
%     'NB'          integer     # B candidates (log-spaced)(default 60)
%     'NHarmonics'  integer     # harmonics to score       (default 24)
%     'MedKernel'   integer     rows in pre-filter kernel  (default 5)
%
%   OUTPUTS
%     f0      Estimated fundamental frequency (Hz)
%     B       Estimated inharmonicity coefficient (dimensionless)
%     diagOut Struct with fields: scoreGrid, k0Vec (bins), BVec, aa_filt

    %% --- parse inputs ----------------------------------------------------
    p = inputParser;
    addRequired(p, 'aa');
    addRequired(p, 'Fs');
    addParameter(p, 'f0Range',    [50 2000], @(x) isnumeric(x) && numel(x)==2);
    addParameter(p, 'BRange',     [0 2e-3],  @(x) isnumeric(x) && numel(x)==2);
    addParameter(p, 'NB',         60,        @(x) isnumeric(x) && isscalar(x));
    addParameter(p, 'NHarmonics', 24,        @(x) isnumeric(x) && isscalar(x));
    addParameter(p, 'MedKernel',  5,         @(x) isnumeric(x) && isscalar(x));
    parse(p, aa, Fs, varargin{:});
    opt = p.Results;

    %% --- geometry --------------------------------------------------------
    % HCT builds clim = round(N_fft/8) rows and cols, so N_fft ~ 8*max_col.
    [max_harm, max_col] = size(aa);
    N_fft = max_col * 8;            % approximate — matches HCT construction
    df    = Fs / N_fft;             % Hz per FFT bin

    N_harm = min(opt.NHarmonics, max_harm);
    n_vec  = (1:N_harm)';           % harmonic index column vector

    %% --- morphological pre-filter ----------------------------------------
    % Median filter along the harmonic (row) axis for each candidate
    % fundamental column independently.  Suppresses spectral peaks that
    % lack neighbouring harmonics of comparable amplitude — these are most
    % likely body resonances, noise, or pickup coloration rather than
    % string partials.
    aa_f = medfilt2(aa, [opt.MedKernel, 1]);

    % Row-normalise: divide each row by its across-column median so the
    % score measures "how much brighter than background is this column?"
    % rather than absolute FFT magnitude.  Without this, the FFT noise
    % floor is similar everywhere and all (k0,B) candidates score nearly
    % identically, flattening the score landscape.
    row_med = median(aa_f, 2);
    row_med(row_med == 0) = 1;                      % avoid divide-by-zero
    aa_f = aa_f ./ row_med;

    %% --- candidate grids (coarse) ----------------------------------------
    k0_lo  = max(1,       round(opt.f0Range(1) / df));
    k0_hi  = min(max_col, round(opt.f0Range(2) / df));
    k0_vec = k0_lo : k0_hi;

    % B=0 (pure harmonic) is always included; remaining slots are log-spaced
    % so the search is denser at small B where most strings live.
    if opt.BRange(1) == 0
        B_vec = [0, logspace(-6, log10(max(opt.BRange(2), 1e-6)), opt.NB-1)];
    else
        B_vec = logspace(log10(opt.BRange(1)), log10(opt.BRange(2)), opt.NB);
    end

    %% --- coarse grid search ----------------------------------------------
    % For each (k0, B) candidate, predict the HCT column for every harmonic
    % row using eq. (2), read the filtered magnitude at that position, and
    % accumulate a mean score.  Normalising by the number of valid (in-range)
    % harmonics prevents low-f0 candidates from winning simply by having
    % more harmonics within the matrix bounds.

    score_grid = zeros(numel(k0_vec), numel(B_vec));

    for ib = 1:numel(B_vec)
        B_cur   = B_vec(ib);
        stretch = sqrt(1 + B_cur .* n_vec.^2);  % inharmonic stretch per row

        for ik = 1:numel(k0_vec)
            k0  = k0_vec(ik);
            k_n = round(k0 .* stretch);          % predicted column, each row

            valid = (k_n >= 1) & (k_n <= max_col);
            if ~any(valid), continue; end

            nv  = n_vec(valid);
            knv = k_n(valid);
            % column-major linear index: row nv, column knv
            lin = (knv - 1) .* max_harm + nv;
            score_grid(ik, ib) = mean(aa_f(lin));
        end
    end

    %% --- locate coarse optimum ------------------------------------------
    [~, idx]      = max(score_grid(:));
    [ik_c, ib_c]  = ind2sub(size(score_grid), idx);
    k0_coarse     = k0_vec(ik_c);
    B_coarse      = B_vec(ib_c);

    %% --- fine grid search ------------------------------------------------
    % Zoom in to a narrow window around the coarse solution.  Use sub-bin
    % k0 steps and linear interpolation between HCT columns so the score
    % surface is smooth enough for the maximum to be well-located.

    k0_fine = (k0_coarse - 3) : 0.25 : (k0_coarse + 3);
    k0_fine = k0_fine(k0_fine >= k0_lo & k0_fine <= k0_hi);

    if B_coarse == 0
        B_fine = [0, logspace(-6, -4, 30)];
    else
        B_fine = logspace(log10(B_coarse / 8), log10(B_coarse * 8), 50);
        B_fine = [0, B_fine(B_fine > 0 & B_fine <= opt.BRange(2))];
    end

    score_fine = zeros(numel(k0_fine), numel(B_fine));

    for ib = 1:numel(B_fine)
        B_cur   = B_fine(ib);
        stretch = sqrt(1 + B_cur .* n_vec.^2);

        for ik = 1:numel(k0_fine)
            k0    = k0_fine(ik);
            k_n_r = k0 .* stretch;               % real-valued column positions

            valid = (k_n_r >= 1) & (k_n_r <= max_col);
            if ~any(valid), continue; end

            nv    = n_vec(valid);
            knv_r = k_n_r(valid);

            % linear interpolation between adjacent integer columns
            k_lo  = floor(knv_r);
            k_hi  = k_lo + 1;
            frac  = knv_r - k_lo;
            k_hi(k_hi > max_col) = max_col;

            lin_lo = (k_lo - 1) .* max_harm + nv;
            lin_hi = (k_hi - 1) .* max_harm + nv;
            vals   = aa_f(lin_lo) .* (1 - frac) + aa_f(lin_hi) .* frac;
            score_fine(ik, ib) = mean(vals);
        end
    end

    %% --- fine optimum ---------------------------------------------------
    [~, idx2]     = max(score_fine(:));
    [ik_f, ib_f]  = ind2sub(size(score_fine), idx2);

    f0 = k0_fine(ik_f) * df;
    B  = B_fine(ib_f);

    %% --- diagnostics -----------------------------------------------------
    if nargout > 2
        diagOut.scoreGrid = score_grid;
        diagOut.k0Vec     = k0_vec;
        diagOut.BVec      = B_vec;
        diagOut.aa_filt   = aa_f;
        diagOut.df        = df;
    end

end

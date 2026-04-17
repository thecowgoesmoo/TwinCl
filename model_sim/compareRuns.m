function compareRuns(runs, options)
% COMPARERUNS  Overlay PSDs and RMS envelopes from a set of parameter-sweep
%              runs to visualize perceptible differences.
%
% Inputs:
%   runs : cell array of structs with fields
%            .name       descriptive label
%            .params     post-RESOLVEPARAMS struct
%            .analysis   struct from ANALYZEOUTPUT
%   options : (optional) struct with fields
%            .pickup           which pickup index to compare (default 1)
%            .db_range         y-axis range relative to peak (default [-80 5])
%            .env_window       RMS envelope window, seconds (default 0.020)
%            .show_peak_trace  overlay peak markers/line per run (default true)
%            .dim_raw_psd      draw the raw PSD thin when peaks are shown
%                              (default true)
%
% Produces one figure with two panels:
%   left  : weighted PSDs overlaid; when .show_peak_trace is true, peak
%           traces are drawn in matching colors on top of the (optionally
%           dimmed) raw PSDs.
%   right : short-window RMS envelopes (dB) overlaid

if nargin < 2, options = struct(); end
if ~isfield(options, 'pickup'),          options.pickup          = 1;        end
if ~isfield(options, 'db_range'),        options.db_range        = [-80 5];  end
if ~isfield(options, 'env_window'),      options.env_window      = 0.020;    end
if ~isfield(options, 'show_peak_trace'), options.show_peak_trace = true;     end
if ~isfield(options, 'dim_raw_psd'),     options.dim_raw_psd     = true;     end

nRuns = numel(runs);
if nRuns == 0
    warning('compareRuns: no runs provided.');
    return;
end

colors = lines(max(nRuns, 3));
pidx   = options.pickup;

% Line-weight choices: when the peak trace is overlaid we let the peak
% trace be the dominant visual and (optionally) thin out the raw PSD.
if options.show_peak_trace && options.dim_raw_psd
    raw_lw  = 0.6;
    peak_lw = 1.6;
else
    raw_lw  = 1.2;
    peak_lw = 1.2;
end

figure('Name', 'Clavinet model comparison', ...
       'Position', [150 150 1100 480], 'Color', 'w');

% --- PSD overlay --------------------------------------------------------
subplot(1, 2, 1); hold on;
peak_db = -inf;
h_legend = gobjects(nRuns, 1);
for r = 1:nRuns
    ana  = runs{r}.analysis;
    p_dB = 10*log10(ana.psd_w(:, pidx) + eps);
    peak_db = max(peak_db, max(p_dB));

    h_raw = semilogx(ana.f, p_dB, 'Color', colors(r,:), ...
                     'LineWidth', raw_lw, 'HandleVisibility', 'off');

    if options.show_peak_trace && isfield(ana, 'partial_peaks') ...
            && numel(ana.partial_peaks) >= pidx ...
            && ~isempty(ana.partial_peaks{pidx}.f_Hz)
        pk = ana.partial_peaks{pidx};
        h_pk = semilogx(pk.f_Hz, pk.psd_dB, '-o', ...
                        'Color',           colors(r,:), ...
                        'MarkerFaceColor', colors(r,:), ...
                        'MarkerSize',      4, ...
                        'LineWidth',       peak_lw, ...
                        'DisplayName',     runs{r}.name);
        h_legend(r) = h_pk;
    else
        % No peak trace; promote the raw line to the legend
        set(h_raw, 'HandleVisibility', 'on', 'DisplayName', runs{r}.name);
        h_legend(r) = h_raw;
    end
end
hold off; grid on;
set(gca, 'XScale', 'log');
xlabel('Hz'); ylabel('dB');
xlim([20 min(20000, runs{1}.analysis.fs/2)]);
ylim(peak_db + options.db_range);
legend(h_legend, 'Location', 'southwest');
if options.show_peak_trace
    ttl_suffix = '  (peak trace overlay)';
else
    ttl_suffix = '';
end
title(sprintf('%s-weighted PSD  -  %s pickup%s', ...
      runs{1}.analysis.weighting, ...
      runs{1}.params.pickups(pidx).name, ttl_suffix));

% --- RMS envelope overlay -----------------------------------------------
subplot(1, 2, 2); hold on;
for r = 1:nRuns
    ana = runs{r}.analysis;
    fs  = ana.fs;
    nw  = max(2, round(options.env_window * fs));
    sig = ana.signals(pidx, :);
    env = sqrt(movmean(sig.^2, nw));
    ts  = (0:numel(env)-1) / fs;
    plot(ts, 20*log10(env + eps), 'Color', colors(r,:), ...
         'LineWidth', 1.2, 'DisplayName', runs{r}.name);
end
hold off; grid on;
xlabel('time (s)'); ylabel('dB RMS');
legend('Location', 'northeast');
title(sprintf('RMS envelope  -  %s pickup  (window %.0f ms)', ...
      runs{1}.params.pickups(pidx).name, 1e3 * options.env_window));

end

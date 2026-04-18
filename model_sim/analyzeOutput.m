function analysis = analyzeOutput(t, pickup_signals, params, options)
% ANALYZEOUTPUT  Compute PSD, spectrogram, and summary stats from pickup
%                signals.  Optionally produces diagnostic plots.
%
% Inputs:
%   t              : [1 x Nt] time vector (s) as returned by SIMULATENOTE
%   pickup_signals : [Np x Nt] pickup outputs (arbitrary voltage units)
%   params         : parameter struct post-RESOLVEPARAMS
%   options        : (optional) struct with fields
%                    .fs_audio            output sample rate (default 44100)
%                    .plot                true to show figure (default true)
%                    .weighting           'A' | 'none'   (default 'A')
%                    .peak_prominence_dB  findpeaks threshold (default 10)
%                    .peak_max_count      max peaks to keep (default 40)
%                    .show_peak_trace     overlay peak trace (default true)
%
% Output:
%   analysis : struct with fields
%     .fs, .signals           : decimated audio-rate signals
%     .f, .psd, .psd_w        : Welch PSD and weighted version
%     .spec{p}                : per-pickup spectrogram {S, f, t}
%     .partial_peaks{p}       : struct .f_Hz, .psd_dB for each pickup,
%                               peaks detected on the *weighted* PSD so
%                               markers line up with the plotted curve
%     .partials_Hz{p}         : convenience alias of .partial_peaks{p}.f_Hz
%     .weighting              : echo of the option
%
% Requires the Signal Processing Toolbox (pwelch, spectrogram, resample,
% findpeaks).

if nargin < 4, options = struct(); end
if ~isfield(options, 'fs_audio'),           options.fs_audio           = 44100;  end
if ~isfield(options, 'plot'),               options.plot               = true;   end
if ~isfield(options, 'weighting'),          options.weighting          = 'A';    end
if ~isfield(options, 'peak_prominence_dB'), options.peak_prominence_dB = 10;     end
if ~isfield(options, 'peak_max_count'),     options.peak_max_count     = 40;     end
if ~isfield(options, 'show_peak_trace'),    options.show_peak_trace    = true;   end

fs_sim = 1 / (t(2) - t(1));
[Np, ~] = size(pickup_signals);

% --- Decimate to audio sample rate --------------------------------------
if abs(fs_sim - options.fs_audio) > 1
    [P, Q] = rat(options.fs_audio / fs_sim, 1e-6);
    sig_audio = [];
    for p = 1:Np
        s_p = resample(pickup_signals(p, :), P, Q);
        if isempty(sig_audio), sig_audio = zeros(Np, numel(s_p)); end
        sig_audio(p, :) = s_p;
    end
else
    sig_audio = pickup_signals;
end
fs = options.fs_audio;
Na = size(sig_audio, 2);

% --- Welch PSD ----------------------------------------------------------
nfft = 2^nextpow2(round(fs * 0.1));
if nfft > Na, nfft = 2^nextpow2(Na/2); end
psd  = zeros(nfft/2 + 1, Np);
for p = 1:Np
    [psd(:, p), f] = pwelch(sig_audio(p, :), nfft, nfft/2, nfft, fs);
end

% --- Weighting (computed BEFORE peak-picking so peaks align with plot) --
switch lower(options.weighting)
    case 'a'
        Aw    = aweight_magnitude(f);
        psd_w = psd .* (Aw.^2);
    case 'none'
        psd_w = psd;
    otherwise
        error('Unknown weighting: %s', options.weighting);
end

% --- Spectrogram --------------------------------------------------------
nwin = 2048;
nov  = 1536;
spec = cell(Np, 1);
for p = 1:Np
    [S, sf, st] = spectrogram(sig_audio(p, :), nwin, nov, nwin, fs);
    spec{p} = struct('S', S, 'f', sf, 't', st);
end

% --- Partial detection on the weighted PSD ------------------------------
% Peaks are detected on the *displayed* curve so the markers lie exactly
% on the plotted line.  Detection happens in dB so the prominence
% threshold is in the same units the user sees on the axis.
partial_peaks = cell(Np, 1);
partials_Hz   = cell(Np, 1);
for p = 1:Np
    psd_w_dB = 10*log10(psd_w(:, p) + eps);
    [pk_dB, pk_idx] = findpeaks(psd_w_dB, ...
                                'MinPeakProminence', options.peak_prominence_dB, ...
                                'SortStr',           'descend', ...
                                'NPeaks',            options.peak_max_count);
    [f_sorted, ord] = sort(f(pk_idx));
    partial_peaks{p} = struct('f_Hz',   f_sorted, ...
                              'psd_dB', pk_dB(ord));
    partials_Hz{p}   = f_sorted;
end

% --- Assemble output -----------------------------------------------------
analysis.fs              = fs;
analysis.signals         = sig_audio;
analysis.f               = f;
analysis.psd             = psd;
analysis.psd_w           = psd_w;
analysis.spec            = spec;
analysis.partial_peaks   = partial_peaks;
analysis.partials_Hz     = partials_Hz;
analysis.weighting       = options.weighting;

if options.plot
    plotAnalysis(analysis, params, options);
end

end


% ======================================================================
function plotAnalysis(a, params, options)
Np = numel(params.pickups);
figure('Name', sprintf('Clavinet model: %s', params.pitch.note), ...
       'Position', [100 100 1000 700], 'Color', 'w');

for p = 1:Np
    name   = params.pickups(p).name;
    sig    = a.signals(p, :);
    t_sig  = (0:numel(sig)-1) / a.fs;

    % --- Time-domain waveform ------------------------------------------
    subplot(3, Np, p);
    plot(t_sig, sig); grid on;
    title(sprintf('%s pickup  -  waveform', name));
    xlabel('time (s)'); ylabel('v (a.u.)');
    xlim([0 min(0.1, t_sig(end))]);

    % --- PSD with optional peak overlay --------------------------------
    ax = subplot(3, Np, Np + p);
    psd_dB = 10*log10(a.psd_w(:, p) + eps);
    semilogx(a.f, psd_dB, 'LineWidth', 0.9); grid on; hold on;

    if options.show_peak_trace
        pk = a.partial_peaks{p};
        if ~isempty(pk.f_Hz)
            semilogx(pk.f_Hz, pk.psd_dB, '-o', ...
                     'Color',           [0.85 0.10 0.10], ...
                     'MarkerFaceColor', [0.85 0.10 0.10], ...
                     'MarkerSize',      4, ...
                     'LineWidth',       1.3);
        end
    end
    hold off;
    title(sprintf('%s pickup  -  PSD (%s-weighted)', name, a.weighting));
    xlabel('Hz'); ylabel('dB');
    xlim([20 min(20000, a.fs/2)]);

    % --- Spectrogram ---------------------------------------------------
    subplot(3, Np, 2*Np + p);
    S = a.spec{p}.S;
    sf = a.spec{p}.f;
    st = a.spec{p}.t;
    imagesc(st, sf, 20*log10(abs(S) + eps)); axis xy;
    %set(gca, 'YScale', 'log'); ylim([20 min(20000, a.fs/2)]);
    hi = max(20*log10(abs(S(:)) + eps));
    caxis([hi-60, hi]);
    title(sprintf('%s pickup  -  spectrogram', name));
    xlabel('time (s)'); ylabel('Hz'); colorbar;
end
end


% ======================================================================
function A = aweight_magnitude(f)
% A-weighting filter magnitude response, normalized to peak 1.
f  = f(:);
Ra = (12200^2 * f.^4) ./ ( ...
     (f.^2 + 20.6^2) .* ...
     sqrt((f.^2 + 107.7^2) .* (f.^2 + 737.9^2)) .* ...
     (f.^2 + 12200^2) );
A = Ra / max(Ra);
end

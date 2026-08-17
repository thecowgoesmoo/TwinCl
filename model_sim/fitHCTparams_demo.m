% fitHCTparams_demo.m
addpath('/Users/rkmoore/Documents/openscad/TwinCl/model_sim');

[y, Fs] = audioread('/Users/rkmoore/Documents/openscad/TwinCl/prototypes/TC-002/media/audio/TwinCl_TC-002_C4_jbassPUsFull.wav');
y0 = y(round([14:(1./Fs):17.7].*Fs), 1)';

fprintf('Computing HCT...\n');
aa = HCT(y0, Fs);

fprintf('Fitting f0 and B...\n');
[f0, B, diagOut] = fitHCTparams(aa, Fs);
fprintf('f0 = %.2f Hz,  B = %.2e\n', f0, B);

% Diagnostics: actual score range
sg = diagOut.scoreGrid;
fprintf('Score grid range: [%.4f, %.4f]\n', min(sg(:)), max(sg(:)));
[sg_max, idx_max] = max(sg(:));
[ik_max, ib_max] = ind2sub(size(sg), idx_max);
fprintf('Peak at f0=%.2f Hz, B=%.2e, score=%.4f\n', ...
    diagOut.k0Vec(ik_max)*diagOut.df, diagOut.BVec(ib_max), sg_max);

% 1-D profile: best score vs f0 (max over B)
fig0 = figure('Visible','off');
f0_axis = diagOut.k0Vec * diagOut.df;
plot(f0_axis, max(sg, [], 2));
xlabel('f0 candidate (Hz)'); ylabel('Score (max over B)');
title('HCT score profile vs f0');
xline(f0, 'r--', sprintf('%.1f Hz', f0));
saveas(fig0, '/Users/rkmoore/Documents/openscad/TwinCl/model_sim/fitHCTparams_demo_profile.png');

% 2-D score landscape — normalise to [0,1] to show relative structure
Bvec = diagOut.BVec;
pos  = Bvec > 0;
sg_pos = sg(:, pos);
sg_norm = (sg_pos - min(sg_pos(:))) / (max(sg_pos(:)) - min(sg_pos(:)) + eps);
fig = figure('Visible','off');
imagesc(Bvec(pos), f0_axis, sg_norm);
xlabel('B (inharmonicity)'); ylabel('f0 candidate (Hz)');
title(sprintf('HCT fit score — coarse grid (normalised)\nBest: f0=%.2f Hz, B=%.2e', f0, B));
set(gca, 'XScale', 'log', 'YDir', 'normal');
colorbar;
saveas(fig, '/Users/rkmoore/Documents/openscad/TwinCl/model_sim/fitHCTparams_demo_score.png');

% Also show the filtered HCT around the best fundamental
f0_bin = round(f0 / diagOut.df);
fig2 = figure('Visible','off');
imagesc(log10(diagOut.aa_filt(1:30, max(1,f0_bin-200):min(end,f0_bin+200)) + eps));
xlabel('HCT column (candidate f0 bin, offset)'); ylabel('Harmonic number');
title(sprintf('Filtered HCT near f0=%.2f Hz', f0));
colorbar;
saveas(fig2, '/Users/rkmoore/Documents/openscad/TwinCl/model_sim/fitHCTparams_demo_hct.png');

fprintf('Plots saved.\n');

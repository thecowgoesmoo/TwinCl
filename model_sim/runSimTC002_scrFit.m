% RUNDEMO  End-to-end Phase 1 demo for the clavinet string model.
%
% This script wires together the six-file scaffold so you can sanity-check
% the whole pipeline in one run:
%     setParametersC4_D6 -> resolveParams -> buildSimulator ->
%     simulateNote       -> analyzeOutput -> compareRuns
%
% It also prints analytic vs. numerical fundamental/partial frequencies
% as a first numerical validation.

clear; clc; close all;

%--- Baseline run ---------------------------------------------------------
p0 = setParametersC4_TC002_scrFit();%D6();
p0 = resolveParams(p0);

fprintf('\n--- Derived parameter summary (baseline) ---\n');
disp(p0.derived);

sim0 = buildSimulator(p0);
[t0, sig0, diag0] = simulateNote(p0, sim0);

fprintf('Peak displacement  : %.3e m\n', diag0.peak_disp_m);
fprintf('CFL margin (>= 1)  : %.3f\n',    diag0.cfl_check);

% Compare numerical partial frequencies to analytic stiff-string modes.
ana0 = analyzeOutput(t0, sig0, p0);
f1_hat = p0.pitch.freq_Hz;
B      = p0.derived.inharmonicity_B;
fprintf('\n--- Partial frequencies (analytic vs numeric) ---\n');
fprintf('  n |  analytic Hz |  numeric Hz  |  err %%\n');
for n = 1:min(8, numel(ana0.partials_Hz{1}))
    f_an  = n * f1_hat * sqrt(1 + B * n^2);    % stiff-string formula
    f_num = ana0.partials_Hz{1}(n);
    fprintf('%3d | %11.2f  | %11.2f  | %+6.2f\n', ...
            n, f_an, f_num, 100*(f_num - f_an)/f_an);
end

% %--- Parameter sweep: vary bridge-pickup position ------------------------
% % A small sweep to exercise compareRuns.
% positions_mm = [0.033];%[25, 40, 80];
% runs = cell(numel(positions_mm), 1);
% for i = 1:numel(positions_mm)
%     p = setParametersC4_D6();
%     p.pickups(1).x_m = 1e-3 * positions_mm(i);
%     p = resolveParams(p);
%     s = buildSimulator(p);
%     [ti, sigi, ~] = simulateNote(p, s);
%     ai = analyzeOutput(ti, sigi, p, struct('plot', false));
%     runs{i} = struct('name',     sprintf('bridge pkp = %d mm', positions_mm(i)), ...
%                      'params',   p, ...
%                      'analysis', ai);
% end
% 
% compareRuns(runs, struct('pickup', 1));
% 
% fprintf('\nDone.\n');
ana_sim = ana0;

[t, sig, p]  = loadRecordedClips();          % measured
gFact = 30;
sig = sig./gFact;
ana_meas     = analyzeOutput(t, sig, p);
ana_sim = ana0;
% and the overlay-against-sim pattern just works:
runs = {
struct('name','measured',  'params', p,  'analysis', ana_meas), ...
struct('name','simulated', 'params', p0, 'analysis', ana_sim)
};
compareRuns(runs, struct('pickup', 1));

allDiffs = abs(ana_meas.partials_Hz{1}-ana_sim.partials_Hz{1}');
[~,minInds1] = min(allDiffs,[],1);
figure,plot(ana_sim.partials_Hz{1},ana_sim.partial_peaks{1}.psd_dB+0,'o-',ana_meas.partials_Hz{1}(minInds1),ana_meas.partial_peaks{1}.psd_dB(minInds1),'o-');

allDiffs = abs(ana_meas.partials_Hz{2}-ana_sim.partials_Hz{2}');
[~,minInds2] = min(allDiffs,[],1);
figure,plot(ana_sim.partials_Hz{2},ana_sim.partial_peaks{2}.psd_dB+0,'o-',ana_meas.partials_Hz{2}(minInds2),ana_meas.partial_peaks{2}.psd_dB(minInds2),'o-');

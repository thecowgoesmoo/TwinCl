%HCT_nlinfilt_demo

%Read in an audio vector (using TwinCl TC-002 recording):
[y, Fs] = audioread('/Users/rkmoore/Documents/openscad/TwinCl/prototypes/TC-002/media/audio/TwinCl_TC-002_C4_jbassPUsFull.wav');

%Just a little chunk of it to avoid an ungainly HCT matrix:
y0 = y(round([14:(1./Fs):17.7].*Fs),1)';

%Compute the Harmonic Continuity Transform, which is the Fourier magnitude
%spectrum augmented to arrange coefficients by different candidate
%fundamental frequencies
aa = HCT(y0,Fs);

%Median filter along frequency at each step scale to filter out isolated 
% %components that aren't part of a harmonic series of non-trivial amplitudes.
aa2 = medfilt2(aa,[7 1]);

figure,imagesc(log10(aa2(1:2000,1:2000)));
xlim([850 1150]);
ylim([0 25]);
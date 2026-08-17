function aa = HCT(y0,Fs)

%The Harmonic Continuity Transform (HCT) is an augmenting reorganization of
%the Fourier transform intended to imbue signals with integer multiple
%harmonic components to be geometrically adjacent.  Morphological
%filtering can then be used to remove components that lack adjacent
%harmonic components.  

%[y, Fs] = audioread('/Users/rkmoore/Documents/openscad/TwinCl/prototypes/TC-002/media/audio/TwinCl_TC-002_C4_jbassPUsFull.wav');
%y0 = y(round([14:(1./Fs):17.7].*Fs),1)';
Y0 = abs(fft(y0));
clim = round(numel(Y0)/8);

for k = 1:clim 
	newOne = Y0(1+[k:k:clim])';
	aa(1:numel(newOne),k) = newOne; 
end

%figure,imagesc(log10(aa(1:2000,1:2000)));
%xlim([850 1150]);
%ylim([0 25]);

end
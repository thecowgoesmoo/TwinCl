function xout = remove60cycHarms(xin,Fs)

fo = 60;
[b,a] = iircomb(Fs/fo,0.1,'notch');
xout = filter(b,a,xin);

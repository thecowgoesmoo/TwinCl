function [C, T, q_ms] = cepstrogram(y, Fs, nfft, hop)
  %cepstrogram  Short-time real cepstrum, waterfall-ready.
  %
  %   [C, T, q_ms] = cepstrogram(y, Fs, nfft, hop)
  %
  %   C       cepstrum matrix (nfft x nFrames) — rows are quefrency bins
  %   T       time vector (s), one entry per frame
  %   q_ms    quefrency axis (ms) — peak at 1/f0 identifies pitch
  %
  %   For C4 (262 Hz) expect a bright horizontal streak at q_ms = 3.8 ms.

      if nargin < 3, nfft = 2048; end
      if nargin < 4, hop  = 256;  end

      y    = y(:)';                           % ensure row vector
      win  = hann(nfft)';

      nFrames = floor((numel(y) - nfft) / hop) + 1;
      C       = zeros(nfft, nFrames);

      for k = 1:nFrames
          frame    = y((1:nfft) + (k-1)*hop) .* win;
          C(:, k)  = real(ifft(log(abs(fft(frame, nfft)) + eps)));
      end

      T    = (0:nFrames-1) * hop / Fs;
      q_ms = (0:nfft-1) / Fs * 1000;         % quefrency in ms
  end

  % Usage and plot:
  % 
  % [y, Fs] = audioread('TwinCl_TC-002_C4_jbassPUsFull.wav');
  % [C, T, q_ms] = cepstrogram(y(:,1), Fs, 2048, 256);
  % 
  % % Show only the low-quefrency half (pitch range 50–2000 Hz = 0.5–20 ms)
  % q_range = q_ms >= 0.5 & q_ms <= 20;
  % 
  % figure;
  % imagesc(T, q_ms(q_range), C(q_range, :));
  % axis xy;
  % xlabel('Time (s)');  ylabel('Quefrency (ms)');
  % title('Cepstrogram — peak at 1/f_0 reveals pitch');
  % yline(1000/262, 'r--', 'C4 (3.8 ms)');
  % colorbar;
   
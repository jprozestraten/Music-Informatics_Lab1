function [P_X,f] = fft2ss(X)
% FFT2PSD
%    Enter an fft of a a signal, the output is a single sided amplitude 
%    spectrum and a normalized frequency.
L = size(X,1);
c = 1/L;

% Divide by the amount of samples to normalize the fft
P_X = abs(X)*c;

% Range is to get the single sided spectrum
range = 1:(floor(L/2)+1);
P_X = P_X(range);

% Double all frequencies except the zero-frequency and the
% Nyquist-frequency
P_X(2:floor(L/2)) = P_X(2:floor(L/2))*2;

% Normalized frequency vector
f = (0:floor(L/2))*c;

end


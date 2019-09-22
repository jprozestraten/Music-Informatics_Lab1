function [P_X,f] = fft2psd(X)
L = size(X,1);
c = 1/L;
P_X = abs(X)*c;
range = 1:(floor(L/2)+1);
P_X = P_X(range);
P_X(2:floor(L/2)) = P_X(2:floor(L/2))*2;

f = (0:floor(L/2))*c;

end


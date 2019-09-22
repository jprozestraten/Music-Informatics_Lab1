function nCrossings = zerocrossings(x,frameSize)

nFrames = floor(length(x)/frameSize);
x = x(1:(frameSize*nFrames));
x = reshape(x,frameSize,nFrames);

x = sign(x(1:end-1,:)) .* sign(x(2:end,:));
x = x == -1;

% x = sign(x);
% x = x(1:end-1,:) ~= x(2:end,:);

nCrossings = sum(x);
end
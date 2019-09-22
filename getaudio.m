function [y,Fs] = getaudio(filename,range,channel)
%GETAUDIO Summary of this function goes here
%   Detailed explanation goes here

% Parse input arguments:
if nargin > 0
    filename = convertStringsToChars(filename);
end

if nargin > 1
    range = convertStringsToChars(range);
end

if nargin > 2
    channel = convertStringsToChars(channel);
end

narginchk(1, 3);

if nargin < 2
    range = [1 inf];
    channel = 'left';
elseif nargin < 3 && ischar(range)
    channel = range;
    range = [1 inf];
elseif nargin < 3
    channel = 'left';
end

[y,Fs] = audioread(filename,range);

nChannels = size(y);
nChannels = nChannels(2);

switch channel
    case 'left'
        y = y(:,1);
    case 'right'
        y = y(:,nChannels);
    case 'mono'
        y = mean(y,2);
end

end


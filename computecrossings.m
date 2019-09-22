function nCrossings = computecrossings(songs,tFrameSize)
nSongs = size(songs,2);
nCrossings = cell(1,nSongs);
nFrameSize = floor(tFrameSize*[songs{2,:}]);
for i = 1:nSongs
    nCrossings{i} = zerocrossings(songs{1,i},nFrameSize(i));
end
end
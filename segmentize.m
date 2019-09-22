function nCrossings = segmentize(songs,tFrameSize,segmentSize)
nCrossings = computecrossings(songs,tFrameSize);
nSongs = size(songs,2);

for i = 1:nSongs
    nSegments = floor(length(nCrossings{i})/segmentSize);
    nCrossings{i} = nCrossings{i}(1:segmentSize*nSegments);
    
    nCrossings{i} = reshape(nCrossings{i},segmentSize,nSegments);
end
end


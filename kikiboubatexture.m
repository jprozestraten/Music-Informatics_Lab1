%% Load data and store zero-crossings
frameSize = 0.1;
tSegmentSize = 1;
nSegmentSize = floor(tSegmentSize/frameSize);

nCrossings = cell(1,2);

genre = 'kiki';
datasubset = 'train';
songs = loadkikibouba(genre,datasubset);
nCrossings{1} = cell2mat(segmentize(songs,frameSize,nSegmentSize));

genre = 'bouba';
datasubset = 'train';
songs = loadkikibouba(genre,datasubset);
nCrossings{2} = cell2mat(segmentize(songs,frameSize,nSegmentSize));

%% Compute mean and standard deviation
meanKiki = mean(nCrossings{1});
meanBouba = mean(nCrossings{2});
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
stdKiki = sqrt(var(nCrossings{1}));
stdBouba = sqrt(var(nCrossings{2}));

figure(2)
s1 = scatter(meanKiki,stdKiki,[],'x');
hold on
s2 = scatter(meanBouba,stdBouba);

grid on
hold off

%% Train classifier on features
Mdl = compact(fitcsvm([meanKiki',stdKiki';meanBouba',stdBouba'],...
    [repmat({'kiki'},length(meanKiki),1);repmat({'bouba'},length(meanBouba),1)],...
    'CacheSize','maximal','Verbose',1,'Prior','uniform','BoxConstraint',1e-1,'IterationLimit',1e7...
    ));

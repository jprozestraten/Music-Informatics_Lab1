%% Load model
load('cmodel.mat');

frameSize = 0.1;
tSegmentSize = 1;
nSegmentSize = floor(tSegmentSize/frameSize);

%% Predict genre training dataset
genre = 'kiki';
datasubset = 'train';
songs = loadkikibouba(genre,datasubset);
nCrossings{1} = cell2mat(segmentize(songs,frameSize,nSegmentSize));

genre = 'bouba';
datasubset = 'train';
songs = loadkikibouba(genre,datasubset);
nCrossings{2} = cell2mat(segmentize(songs,frameSize,nSegmentSize));

meanKiki = mean(nCrossings{1});
meanBouba = mean(nCrossings{2});
stdKiki = sqrt(var(nCrossings{1}));
stdBouba = sqrt(var(nCrossings{2}));

predKiki = predict(Mdl,[meanKiki',stdKiki']);
predBouba = predict(Mdl,[meanBouba',stdBouba']);

contingencyTrain = [sum(strcmp(predKiki,'kiki')),sum(strcmp(predKiki,'bouba'));...
                   sum(strcmp(predBouba,'kiki')),sum(strcmp(predBouba,'bouba'))];
tableTrain = array2table(contingencyTrain,...
             'VariableNames',{'KikiPredicted','BoubaPredicted'},...
             'RowNames',{'Kiki True','Bouba True'})

%% Predict genre testing dataset
genre = 'kiki';
datasubset = 'train';
songs = loadkikibouba(genre,datasubset);
nCrossings{1} = cell2mat(segmentize(songs,frameSize,nSegmentSize));

genre = 'bouba';
datasubset = 'train';
songs = loadkikibouba(genre,datasubset);
nCrossings{2} = cell2mat(segmentize(songs,frameSize,nSegmentSize));

meanKiki = mean(nCrossings{1});
meanBouba = mean(nCrossings{2});
stdKiki = sqrt(var(nCrossings{1}));
stdBouba = sqrt(var(nCrossings{2}));

predKiki = predict(Mdl,[meanKiki',stdKiki']);
predBouba = predict(Mdl,[meanBouba',stdBouba']);

contingencyTest = [sum(strcmp(predKiki,'kiki')),sum(strcmp(predKiki,'bouba'));...
                   sum(strcmp(predBouba,'kiki')),sum(strcmp(predBouba,'bouba'))];
tableTest = array2table(contingencyTest,...
             'VariableNames',{'KikiPredicted','BoubaPredicted'},...
             'RowNames',{'Kiki True','Bouba True'})

%% Predict genre training dataset
tableCombined = array2table(contingencyTrain + contingencyTest,...
             'VariableNames',{'KikiPredicted','BoubaPredicted'},...
             'RowNames',{'Kiki True','Bouba True'})

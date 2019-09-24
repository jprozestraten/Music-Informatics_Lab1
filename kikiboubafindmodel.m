%% Load variables
frameSize = 0.1;

songs = cell(1,4);
songs{1} = loadkikibouba('kiki','train');
songs{2} = loadkikibouba('bouba','train');
songs{3} = loadkikibouba('kiki','test');
songs{4} = loadkikibouba('bouba','test');

%% Loop
nCrossings = cell(1,4);

maxIt = 250;
condition = true;
nSegmentSize = 3
while condition
    nCrossings{1} = cell2mat(segmentize(songs{1},frameSize,nSegmentSize));
    nCrossings{2} = cell2mat(segmentize(songs{2},frameSize,nSegmentSize));
    nCrossings{3} = cell2mat(segmentize(songs{3},frameSize,nSegmentSize));
    nCrossings{4} = cell2mat(segmentize(songs{4},frameSize,nSegmentSize));
    
    means = cell(1,4);
    stds = cell(1,4);
    means = cellfun(@transpose,cellfun(@mean,nCrossings,'UniformOutput',false),'UniformOutput',false);
    stds = cellfun(@sqrt,cellfun(@transpose,cellfun(@mean,nCrossings,'UniformOutput',false),'UniformOutput',false),'UniformOutput',false);
    
    Mdl = compact(fitcsvm([means{1},stds{1};means{2},stds{2}],...
        [repmat({'kiki'},length(means{1}),1);repmat({'bouba'},length(means{2}),1)],...
        'CacheSize','maximal','Verbose',1,'Prior','uniform','BoxConstraint',1e-2,'IterationLimit',1e6...
        ));
    
    predictions{1} = predict(Mdl,[means{3},stds{3}]);
    predictions{2} = predict(Mdl,[means{4},stds{4}]);
    
    contingency = [sum(strcmp(predictions{1},'kiki')),sum(strcmp(predictions{1},'bouba'));...
                   sum(strcmp(predictions{2},'kiki')),sum(strcmp(predictions{2},'bouba'))]
               
    contingency_p = contingency./sum(contingency,2)*100
    
    nSegmentSize = nSegmentSize + 1
    condition = (nSegmentSize <= maxIt) && ...
        (contingency_p(1,1) < 99 || contingency_p(2,2) < 99);
end
function song = kikiboubasongclassifier(songfile,cmodel,frameSize,nSegmentSize)
[song{1,1},song{2,1}] = audioread(songfile,'native');

nCrossings = cell2mat(segmentize(song,frameSize,nSegmentSize));

means = mean(nCrossings)';
stds = sqrt(var(nCrossings))';

predictions = predict(cmodel,[means,stds]);
predictions = strcmp(predictions,'kiki');

song = mean(predictions);
if song >= 0.5
    song = 'kiki';
else
    song = 'bouba';
end

end
%% Initialization
load('cmodel.mat')

frameSize = 0.1;
nSegmentSize = 10;

predictions = cell(1,2);

%% Compute song genre
genre = 'kiki';datasubset = 'test';
folder = strcat('kikibouba_',datasubset,'\',genre,'\');
wavs = dir(strcat(folder,'*.m4a'));
for i = 1:numel(wavs)
    predictions{1}{i} = kikiboubasongclassifier(strcat(folder,wavs(i).name),Mdl,frameSize,nSegmentSize);
end
%%
genre = 'bouba';datasubset = 'test';
folder = strcat('kikibouba_',datasubset,'\',genre,'\');
wavs = dir(strcat(folder,'*.m4a'));
for i = 1:numel(wavs)
    predictions{2}{i} = kikiboubasongclassifier(strcat(folder,wavs(i).name),Mdl,frameSize,nSegmentSize);
end

%% Calculate contingency table
contingency = [sum(strcmp(predictions{1},'kiki')),sum(strcmp(predictions{1},'bouba'));...
               sum(strcmp(predictions{2},'kiki')),sum(strcmp(predictions{2},'bouba'))]

contingency_p = contingency./sum(contingency,2)*100
%% Load data and store zero-crossings of training set
frameSize = 0.1;

nCrossings = cell(1,2);

genre = 'kiki';
datasubset = 'train';
songs = loadkikibouba(genre,datasubset);
nCrossings{1} = cell2mat(computecrossings(songs,frameSize));

genre = 'bouba';
datasubset = 'train';
songs = loadkikibouba(genre,datasubset);
nCrossings{2} = cell2mat(computecrossings(songs,frameSize));

clear songs

%% Plot zero-crossings
figure(1)
s1 = scatter(nCrossings{1},2*ones(1,length(nCrossings{1})),[],'x');
hold on
s2 = scatter(nCrossings{2},1*ones(1,length(nCrossings{2})),[],'filled');

kikiNormal = fitdist(nCrossings{1}','Normal');
boubaNormal = fitdist(nCrossings{2}','Normal');

nKiki = linspace(0,max(nCrossings{1}),1000);
nBouba = linspace(0,max(nCrossings{2}),1000);
pdfKiki = pdf(kikiNormal,nKiki);
pdfBouba = pdf(boubaNormal,nBouba);

set(gca,'ColorOrderIndex',1)
plot(nKiki,200*pdfKiki+1,'LineWidth',1.5)
plot(nBouba,200*pdfBouba+1,'LineWidth',1.5)

eb = errorbar([kikiNormal.mu boubaNormal.mu],[2 1],[kikiNormal.sigma boubaNormal.sigma],...
    'horizontal','s','MarkerSize',8,'LineWidth',2.5,'CapSize',10);
set(eb, 'MarkerFaceColor', get(eb,'Color')); 

legend([s1,s2],{'kiki','bouba'},'AutoUpdate','off')
yticks([])
ylim([0.8 2.4])

hold off

%% Optimal decision boundary
a = -1/kikiNormal.sigma^2 +1/boubaNormal.sigma^2;
b = 2 * (-boubaNormal.mu/boubaNormal.sigma^2+kikiNormal.mu/kikiNormal.sigma^2);
c = boubaNormal.mu^2/boubaNormal.sigma^2-kikiNormal.mu^2/kikiNormal.sigma^2+log(boubaNormal.sigma^2/kikiNormal.sigma^2);

z = roots([a b c]);
threshold = max(z);
figure(1)
hold on
xline(threshold);
set(gca, 'XTick', unique([floor(threshold), get(gca, 'XTick')]));
hold off

%% Calculate contingency tables

genre = 'kiki';
datasubset = 'train';
songs = loadkikibouba(genre,datasubset);
nCrossings{1} = cell2mat(computecrossings(songs,frameSize));

genre = 'bouba';
datasubset = 'train';
songs = loadkikibouba(genre,datasubset);
nCrossings{2} = cell2mat(computecrossings(songs,frameSize));

contingencyTrain = [sum(nCrossings{1} > threshold),sum(nCrossings{1} < threshold);
                    sum(nCrossings{2} > threshold),sum(nCrossings{2} < threshold)];

tableTrain = array2table(contingencyTrain,...
             'VariableNames',{'KikiPredicted','BoubaPredicted'},...
             'RowNames',{'Kiki True','Bouba True'})

genre = 'kiki';
datasubset = 'test';
songs = loadkikibouba(genre,datasubset);
nCrossings{1} = cell2mat(computecrossings(songs,frameSize));

genre = 'bouba';
datasubset = 'test';
songs = loadkikibouba(genre,datasubset);
nCrossings{2} = cell2mat(computecrossings(songs,frameSize));

contingencyTest = [sum(nCrossings{1} > threshold),sum(nCrossings{1} < threshold);
                    sum(nCrossings{2} > threshold),sum(nCrossings{2} < threshold)];

tableTest = array2table(contingencyTest,...
             'VariableNames',{'KikiPredicted','BoubaPredicted'},...
             'RowNames',{'Kiki True','Bouba True'})

tableCombined = array2table(contingencyTrain + contingencyTest,...
             'VariableNames',{'KikiPredicted','BoubaPredicted'},...
             'RowNames',{'Kiki True','Bouba True'})

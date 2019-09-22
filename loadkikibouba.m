function songs = loadkikibouba(genre,datasubset)
tic
if exist(strcat(genre,datasubset,'.mat'),'file')
    fprintf('Loading from ''%s''\n',strcat(genre,datasubset,'.mat'));
    load(strcat(genre,datasubset,'.mat'),'songs');
else
    fprintf('Reading from ''%s''\n',strcat('kikibouba_',datasubset,'\',genre,'\'));
    songs = readkikibouba;
end
toc

    function songs = readkikibouba
        folder = strcat('kikibouba_',datasubset,'\',genre,'\');
        
        wavs = dir(strcat(folder,'*.m4a'));
        nFiles = length(wavs);
        
        if nFiles <= 200
            songs = cell(2,nFiles);
            for i = 1:nFiles
                fprintf('Loading %d of %d files\n',i,nFiles)
                [songs{1,i},songs{2,i}] = audioread(strcat(folder,wavs(i).name),'native');
            end
        else
            error('Too many files: %d .m4a files found in %s\n',nFiles,folder)
        end
    end
end
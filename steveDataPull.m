%% Pulls steves data and exports to workspace

% chris4Colonscopy = csvread('../steve_data_readable/chris 4 colonoscopy.csv');

fileID = fopen('../steve_data_readable/chris 4 colonoscopy.txt');
C = textscan(fileID,'%f %f %f %f %f');
fclose(fileID);
celldisp(C)
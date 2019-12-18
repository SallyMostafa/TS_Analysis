function [ParasiteData, Labels] = Prepare_phenotype_data()
addpath('/MATLAB Drive/example_dataset/');
% Load data set.
load('example_data.mat')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example of how to load a time series given a timeseries ID (tsid).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Each tsid represents a parasite over the course of a video.
% all_tsids = unique(P(1,:));
%tsid = 78;  
%tsid_labels{tsid}
% Format: date-compound-concentration-day:parasite
% Example: 041911-atorvastatin-10-3:20
k = 6
series_ids = unique(P(1,:));
randomsample = datasample(series_ids,k)
randomsample = [1097 1219 162 1229 858 125];
[n m] = size(randomsample)
%disp(randomsample);
%series_length = size(series_ids);
%series_length = 6;
for i = 1:m
    tsid = randomsample(1,i);
    label_abbreviation = tsid_labels{tsid};
    label_abbreviation = strrep(label_abbreviation,'control','ctr');
    label_abbreviation = strrep(label_abbreviation,'praziquantel','pzq');     
    label_abbreviation = strrep(label_abbreviation,'simvastatin','simv');    
    label_abbreviation = strrep(label_abbreviation,'hycanthone','hyc');   
    label_abbreviation = strrep(label_abbreviation,'atorvastatin','ator');
    Labels{i} = label_abbreviation;% tsid_labels{tsid}; num2str(tsid);
    % Identify colums in the data matrix representing the selected parasite.
    ts_columns = find(P(1,:)==tsid);
    % Select timeseries of a given descriptor 11 is the area:
    ts_area_smooth = P_smooth(11, ts_columns); % smoothed version of the same data.  1x200 array 
    ParasiteData{i} = [ts_area_smooth]'; 
    %figure; hold on;
    %plot(ts_area_smooth);
    %title(Labels{i});
    %filename =  strcat ( 'plot', num2str(i) );
    %saveas(gcf,strcat ( filename, '.png' ));
    %length(ts_area_smooth);
end
%disp(ParasiteData);
%disp(length(ParasiteData));
%disp(Labels)
end
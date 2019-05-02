function [SCI_subjects, Healthy_18,Healthy_19, csv_files_FLOAT_NO_CRUTCHES,csv_files_NO_FLOAT_CRUTCHES] = load_data()
% This function is used to load the data from both the .csv and .mat files.
%
% INPUT: //
%
% OUTPUT: - SCI_subjects = structure containing all the data regarding the
%                          SCI subjects.
%         - Healthy = structure containing all the data regarding the
%                     Healthy subjects.
%         - csv_files_FLOAT_NO_CRUTCHES = table containing the data about the events detected
%                                         for the SCI subjects in the condition of FLOAT_NO_CRUTCHES.
%                                         This table will be  used to split in gait cycles.
%         - csv_files_NO_FLOAT_CRUTCHES = table containing the data about the events detected
%                                         for the SCI subjects in the condition of NO_FLOAT_CRUTCHES.
%                                         This table will be  used to split in gait cycles.

% Names of fields for building structures:
conditions_healthy = {'FLOAT','NO_FLOAT'};
conditions_SCI = {'FLOAT_NO_CRUTCHES','NO_FLOAT_CRUTCHES'};

%% SCI Subjects

% Select the folder containing the data for the SCI patients
msgbox('Select the folder containing data for SCI patients');
pause(1.5);
FolderName = uigetdir('select the directory with the data');

% We load all the csv files. A structure with size 6X1 is going to be created
% Pay attention that the 3 first files make reference to the GAIT FILES
% related to the FLOAT_NO_CRUTCHES and the 3 last to the GAIT FILES related
% to the NO_FLOAT_CRUTCHES.
csv_files = dir([FolderName filesep '**/*.csv']);

for i = 1:length(csv_files)
    if i <= 3
        csv_files_FLOAT_NO_CRUTCHES{i} = readtable(csv_files(i).name);
    else
        csv_files_NO_FLOAT_CRUTCHES{i-3} = readtable(csv_files(i).name);
    end
end

% Loading the MATLAB files for the SCI subjects
mat_files_SCI = dir([FolderName filesep '**/*.mat']);

for i = 1:length(mat_files_SCI)
    temporary_file = load(mat_files_SCI(i).name);
    temporary_struct = temporary_file.(conditions_SCI{i});
    SCI_subjects.(conditions_healthy{i}) = temporary_struct;
end
%% Healthy Subjects

% Same thing but for the healthy subjects
msgbox('Select the folder containing data for Healthy patients');
pause(1.5);
FolderName = uigetdir('select the directory with the data');
% Loading the two MATLAB structures for the Healthy Subjects
mat_files_H = dir([FolderName filesep '**/*.mat']);
nbr_files = length(mat_files_H);

% Since we have two files for each subject: with and without FLOAT
idx_subjects = 1:2:nbr_files;

for condition = 1:length(conditions_healthy)
    for s = 1:length(idx_subjects)
        
        if s<4
            if strcmp(conditions_healthy{condition},'FLOAT')
                temporary_value_1 = load(mat_files_H(idx_subjects(s)).name);
                Healthy_19.(['S_' num2str(s)]).(conditions_healthy{condition}) = temporary_value_1.(['S' num2str(s) '_' conditions_healthy{condition}]);
            elseif strcmp(conditions_healthy{condition},'NO_FLOAT')
                temporary_value_2 = load(mat_files_H(idx_subjects(s)+1).name);
                Healthy_19.(['S_' num2str(s)]).(conditions_healthy{condition}) = temporary_value_2.(['S' num2str(s) '_' conditions_healthy{condition}]);
            end
        end
        
        if s == 4
            if strcmp(conditions_healthy{condition},'FLOAT')
                temporary_value_1 = load(mat_files_H(idx_subjects(s)).name);
                Healthy_18.(['S_' num2str(s)]).(conditions_healthy{condition}) = temporary_value_1.(['S' num2str(s) '_' conditions_healthy{condition}]);
            elseif strcmp(conditions_healthy{condition},'NO_FLOAT')
                temporary_value_2 = load(mat_files_H(idx_subjects(s)+1).name);
                Healthy_18.(['S_' num2str(s)]).(conditions_healthy{condition}) = temporary_value_2.(['S' num2str(s) '_' conditions_healthy{condition}]);
            end
        end
        
    end
end
end



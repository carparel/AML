function [SCI_subjects, Healthy, csv_files_FLOAT_NO_CRUTCHES,csv_files_NO_FLOAT_CRUTCHES] = load_data()
% To load the data

% Select the folder containing the data for the SCI patients 
FolderName = uigetdir('select the directory with the data');

% We load all the csv files. A structure with size 6X1 is going to be created
% Pay attention that the 3 first files make reference to the GAIT FILES
% related to the FLOAT_NO_CRUTCHES and the 3 last to the GAIT FILES related
% to the NO_FLOAT_CRUTCHES
csv_files = dir([FolderName filesep '**/*.csv']);

for i = 1:length(csv_files)
    if i <= 3
        csv_files_FLOAT_NO_CRUTCHES{i} = readtable(csv_files(i).name);
    else 
        csv_files_NO_FLOAT_CRUTCHES{i-3} = readtable(csv_files(i).name);
    end
end

mat_files_SCI = dir([FolderName filesep '**/*.mat']);
% Loading the two MATLAB structures for the SCI 

mat_files_FLOAT_NO_CRUTCHES_SCI = load(mat_files_SCI(1).name);
mat_files_NO_FLOAT_CRUTCHES_SCI =load(mat_files_SCI(2).name);

my_struct1 = mat_files_FLOAT_NO_CRUTCHES_SCI.FLOAT_NO_CRUTCHES;
my_struct2 = mat_files_NO_FLOAT_CRUTCHES_SCI.NO_FLOAT_CRUTCHES;

SCI_subjects.FLOAT_NO_CRUTCHES = my_struct1;
SCI_subjects.NO_FLOAT_CRUTCHES = my_struct2;

% Same thing but fot the healthy subjects
FolderName = uigetdir('select the directory with the data');

mat_files_H = dir([FolderName filesep '**/*.mat']);
% Loading the two MATLAB structures for the SCI 

nbr_files = length(mat_files_H);

% since we have two files for each subject: with and without FLOAT
idx_subjects = 1:2:nbr_files;

for s = 1:length(idx_subjects)
    mat_files_FLOAT_NO_CRUTCHES_H{s} = load(mat_files_H(idx_subjects(s)).name);
    mat_files_NO_FLOAT_CRUTCHES_H{s} =load(mat_files_H(idx_subjects(s)+1).name);
end

Healthy.NO_FLOAT =  mat_files_NO_FLOAT_CRUTCHES_H;
Healthy.FLOAT = mat_files_FLOAT_NO_CRUTCHES_H;

end


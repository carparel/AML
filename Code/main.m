% AML-Project 2 - Courtine part
%
% Group Members : - Giovanna Aiello
%                 - Gaia Carparelli 
%                 - Marion Claudet
%                 - Martina Morea 
%                 - Leonardo Pollina

clear;
clc;
addpath('Data');
addpath('Code');

%% Loading the data for the SCI and creating the new useful structure

% Loading the two MATLAB structures for the SCI 
load('FLOAT_NO_CRUTCHES.mat');
load('NO_FLOAT_CRUTCHES.mat');

% Select the folder containing all the data for the project
FolderName = uigetdir('select the directory with the data');

% We load all the csv files. A structure with size 6X1 is going to be created
% Pay attention that the 3 first files make reference to the GAIT FILES
% related to the FLOAT_NO_CRUTCHES and the 3 last to the GAIT FILES related
% to the NO_FLOAT_CRUTCHES
csv_files = dir([FolderName filesep '**/*.csv']);

for i = 1:6
    if i <= 3
        csv_files_FLOAT_NO_CRUTCHES{i} = readtable(csv_files(i).name);
    else 
        csv_files_NO_FLOAT_CRUTCHES{i-3} = readtable(csv_files(i).name);
    end
end


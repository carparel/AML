% AML-Project 2 - Courtine part
%
% Group Members : - Giovanna Aiello
%                 - Gaia Carparelli 
%                 - Marion Claudet
%                 - Martina Morea 
%                 - Leonardo Pollina

clear;
clc;
addpath('Data/SCI');
addpath('Data/Healthy');
addpath('Code');
%% Loading the data for the SCI and creating the new useful structure

% ATTENTION: the first time the window will pop up select the folder
% containing the data of the SCI subjects. The second time select the
% folder containing the data of the Healthy subects.
[SCI_subjects, Healthy, csv_files_FLOAT_NO_CRUTCHES,csv_files_NO_FLOAT_CRUTCHES] = load_data();

% To stock the sampling frequency for the EMG
Fs_EMG = SCI_subjects.FLOAT_NO_CRUTCHES.T_01.fsEMG;
% To stock the sampling frequency for the Kinetics
Fs_KIN = SCI_subjects.FLOAT_NO_CRUTCHES.T_01.fsKIN;
%% Structuring the data
SCI_EMG = create_EMG_struct(SCI_subjects,'SCI');
Healthy_EMG = create_EMG_struct(Healthy,'Healthy');

%% Computing the mean EMG signal and filtering
SCI_EMG_NO_FLOAT_CRUTCHES = compute_mean_EMG_signal(SCI_EMG.NO_FLOAT_CRUTCHES);
figure(1)
filter_and_plot_EMG(SCI_EMG_NO_FLOAT_CRUTCHES,Fs_EMG,false);

SCI_EMG_FLOAT_NO_CRUTCHES = compute_mean_EMG_signal(SCI_EMG.FLOAT_NO_CRUTCHES);
figure(2)
filter_and_plot_EMG(SCI_EMG_FLOAT_NO_CRUTCHES,Fs_EMG,true);



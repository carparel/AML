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
[SCI_subjects, Healthy_subjects, csv_files_FLOAT_NO_CRUTCHES,csv_files_NO_FLOAT_CRUTCHES] = load_data();

% To stock the sampling frequency for the EMG
Fs_EMG = SCI_subjects.FLOAT.T_01.fsEMG;
% To stock the sampling frequency for the Kinetics
Fs_KIN = SCI_subjects.FLOAT.T_01.fsKIN;
%% Structuring the data
SCI_EMG = create_EMG_struct(SCI_subjects,'SCI');
Healthy_EMG = create_EMG_struct(Healthy,'Healthy');
%% Plotting the filtered signal together with the raw
filtered_EMG_envelope = create_EMG_struct_filtered(SCI_EMG,Fs_EMG,true);
filtered_EMG_no_envelope = create_EMG_struct_filtered(SCI_EMG,Fs_EMG,false);

filtered_EMG_envelope_healthy = create_EMG_struct_filtered(Healthy_EMG,Fs_EMG,true);
filtered_EMG_no_envelope_healthy = create_EMG_struct_filtered(Healthy_EMG,Fs_EMG,false);

% int this plot we have the EMG signal for SCI subjects for the four
% muscles of interest
% you have to give to the function the struct.chosen_trial

figure(1)
plot_EMG(filtered_EMG_envelope.NO_FLOAT.T01,filtered_EMG_no_envelope.NO_FLOAT.T01,Fs_EMG);

% int this plot we have the EMG signal for healthy subjects for the four
% muscles of interest
% you have to give to the function the struct.chosen_trial

figure(2)
plot_EMG(filtered_EMG_envelope_healthy.NO_FLOAT.T01,filtered_EMG_no_envelope_healthy.NO_FLOAT.T01,Fs_EMG);



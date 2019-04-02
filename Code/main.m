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
Fs_Kin = SCI_subjects.FLOAT.T_01.fsKIN;
%% Structuring the EMG data
% Choose your subject
index_subject = 4;
subject = ['S_' num2str(index_subject)];

SCI_EMG = create_EMG_struct(SCI_subjects);
Healthy_EMG = create_EMG_struct(Healthy_subjects.(subject));
%% Plotting the filtered signal together with the raw
filtered_EMG_envelope = create_EMG_struct_filtered(SCI_EMG,Fs_EMG,true);
filtered_EMG_no_envelope = create_EMG_struct_filtered(SCI_EMG,Fs_EMG,false);

filtered_EMG_envelope_healthy = create_EMG_struct_filtered(Healthy_EMG,Fs_EMG,true);
filtered_EMG_no_envelope_healthy = create_EMG_struct_filtered(Healthy_EMG,Fs_EMG,false);

% int this plot we have the EMG signal for SCI subjects for the four
% muscles of interest
% you have to give to the function the struct.chosen_trial

figure(1)
plot_EMG(filtered_EMG_envelope.NO_FLOAT.T_01,filtered_EMG_no_envelope.NO_FLOAT.T_01,Fs_EMG);

% int this plot we have the EMG signal for healthy subjects for the four
% muscles of interest
% you have to give to the function the struct.chosen_trial

figure(2)
plot_EMG(filtered_EMG_envelope_healthy.NO_FLOAT.T_01,filtered_EMG_no_envelope_healthy.NO_FLOAT.T_01,Fs_EMG);

%% Structuring the Kin data

% Choose your subject
index_subject = 4;
subject = ['S_' num2str(index_subject)];

SCI_Kin = create_Kin_struct(SCI_subjects,'SCI');
Healthy_Kin = create_Kin_struct(Healthy_subjects.(subject),'Healthy');

%% Filtering the Kin data

SCI_Kin_filtered = create_Kin_struct_filtered(SCI_Kin,Fs_Kin,'SCI');
Healthy_Kin_filtered = create_Kin_struct_filtered(Healthy_Kin,Fs_Kin,'Healthy');

%% Plot kin signals

% Choose what to plot
condition = 'FLOAT';
trial = 'T_01';

% ATTENTION: Do not indicate the position R/L of the marker.
% If you want to plot the hip signal, you have to indicate ASI for SCI
% subjects and HIP for Healthy subjects

marker_SCI = 'TOE';
marker_Healthy = 'TOE';

to_plot_SCI = SCI_Kin.(condition).(trial);
to_plot_Healthy = Healthy_Kin.(condition).(trial);

figure(1);
plot_Kin(to_plot_SCI,to_plot_Healthy,marker_SCI,marker_Healthy,Fs_Kin);
hold on;

marker_SCI = 'ANK';
marker_Healthy = 'ANK';

to_plot_SCI = SCI_Kin.(condition).(trial);
to_plot_Healthy = Healthy_Kin.(condition).(trial);

figure(2);
plot_Kin(to_plot_SCI,to_plot_Healthy,marker_SCI,marker_Healthy,Fs_Kin);
%% Detect gait events by visual inspection
% 
% Probably you should use Toe and Ankle graphs, which seem to be useful for
% such detection! These are the two plots created just above. 
% Knee and Hip look more like straight lines. 
% 
%
%% Automatised gait event algorithm
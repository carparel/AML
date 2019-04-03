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

[Healthy_subjects,SCI_subjects] = structureEMG(Healthy_subjects,SCI_subjects,Fs_EMG);

%% Plotting the filtered signal together with the raw
% Choose the subject, the trial and the condition you want
subject = 'S_4';
condition = 'NO_FLOAT';
trial = 'T_01';

figure(1)
plot_EMG(SCI_subjects.(condition).(trial).Filtered.EMG.envelope,SCI_subjects.(condition).(trial).Filtered.EMG.noenvelope,Fs_EMG);

% int this plot we have the EMG signal for healthy subjects for the four
% muscles of interest
% you have to give to the function the struct.chosen_trial

figure(2)
plot_EMG(Healthy_subjects.(subject).(condition).(trial).Filtered.EMG.envelope,Healthy_subjects.(subject).(condition).(trial).Filtered.EMG.noenvelope,Fs_EMG);

%% Structuring the Kin data

[Healthy_subjects,SCI_subjects] = structureKin(Healthy_subjects,SCI_subjects,Fs_Kin);

%% Plot kin signals

% Choose what to plot
condition = 'FLOAT';
trial = 'T_01';
subject = 'S_4';

% ATTENTION: Do not indicate the position R/L of the marker.
% If you want to plot the hip signal, you have to indicate ASI for SCI
% subjects and HIP for Healthy subjects

marker_SCI = 'TOE';
marker_Healthy = 'TOE';

to_plot_SCI = SCI_subjects.(condition).(trial).Filtered.Kin;
to_plot_Healthy = Healthy_subjects.(subject).(condition).(trial).Filtered.Kin;

figure(1);
plot_Kin(to_plot_SCI,to_plot_Healthy,marker_SCI,marker_Healthy,Fs_Kin);
hold on;

marker_SCI = 'ANK';
marker_Healthy = 'ANK';

to_plot_SCI = SCI_subjects.(condition).(trial).Filtered.Kin;
to_plot_Healthy = Healthy_subjects.(subject).(condition).(trial).Filtered.Kin;

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
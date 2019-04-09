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
%% Global variables
% To choose the healthy subject
subject = 'S_4';
% To stock the sampling frequency for the EMG
Fs_EMG = SCI_subjects.FLOAT.T_01.fsEMG;
% To stock the sampling frequency for the Kinetics
Fs_Kin = SCI_subjects.FLOAT.T_01.fsKIN;

%% Clean data
markers = {'RHIP','RKNE','RTOE','RANK','LHIP','LKNE','LTOE','LANK'};
muscles = {'RMG','RTA','LMG','LTA'};
coeff = Fs_EMG/Fs_Kin;
for marker = 1: length(markers)
    temporary_Kin = Healthy_subjects.(subject).NO_FLOAT.T_01.Raw.Kin.(markers{marker});
    Healthy_subjects.(subject).NO_FLOAT.T_01.Raw.Kin.(markers{marker}) = temporary_Kin(100:end,:);
end
for muscle = 1: length(muscles)
    temporary_EMG = Healthy_subjects.(subject).NO_FLOAT.T_01.Raw.EMG.(muscles{muscle});
    Healthy_subjects.(subject).NO_FLOAT.T_01.Raw.EMG.(muscles{muscle}) = temporary_EMG(100*coeff:end);
end
%% Structuring the EMG data

[Healthy_subjects,SCI_subjects] = structureEMG(Healthy_subjects,SCI_subjects,Fs_EMG);
%% Structuring the Kin data

[Healthy_subjects,SCI_subjects] = structureKin(Healthy_subjects,SCI_subjects,Fs_Kin);

%% Plotting the filtered signal together with the raw
% Choose the subject, the trial and the condition you want to plot
% subject = 'S_4';
condition = 'FLOAT';
trial = 'T_03';

% 
figure(1)
plot_EMG(SCI_subjects.(condition).(trial).Normalized.EMG.envelope,SCI_subjects.(condition).(trial).Normalized.EMG.noenvelope,Fs_EMG);

% int this plot we have the EMG signal for healthy subjects for the four
% muscles of interest
% you have to give to the function the struct.chosen_trial
% 
% figure(2)
% plot_EMG(Healthy_subjects.(subject).(condition).(trial).Normalized.EMG.envelope,Healthy_subjects.(subject).(condition).(trial).Normalized.EMG.noenvelope,Fs_EMG);

%% Plot kin signals
% 
% % Choose what to plot
% subject = 'S_4';
% condition = 'NO_FLOAT';
% trial = 'T_01';
% 
% % ATTENTION: Do not indicate the position R/L of the marker.
% % If you want to plot the hip signal, you have to indicate ASI for SCI
% % subjects and HIP for Healthy subjects
% 
% marker_SCI = 'TOE';
% marker_Healthy = 'TOE';
% 
% figure(1);
% plot_Kin(SCI_subjects.(condition).(trial).Filtered.Kin, ...
%     Healthy_subjects.(subject).(condition).(trial).Filtered.Kin,marker_SCI,marker_Healthy,Fs_Kin);
% hold on;
% 
% marker_SCI = 'ANK';
% marker_Healthy = 'ANK';
% 
% figure(2);
% plot_Kin(SCI_subjects.(condition).(trial).Filtered.Kin, ...
%     Healthy_subjects.(subject).(condition).(trial).Filtered.Kin,marker_SCI,marker_Healthy,Fs_Kin);

%% Detect gait events
% In order to detect the gait events we have considered the Y coordinate of
% the markers ANKLE and TOE. The Hill Strike (HS) will correspond to the
% first index of the plateau of the ankle, the Hill Off (HO) to the last
% index of the plateau of the ankle and the same for the Toe (Toe Strike
% and Toe Off).
% We will thus only consider ANKLE and TOE.

% Creation of the threshold structs - We saw that the thresholds must be
% empirically set --
%[struct_threshold] = create_thresholds_struct;
%threshold_to_consider = struct_threshold;

% SCI subjects
[SCI_subjects] = detect_gait_events_SCI(SCI_subjects,csv_files_NO_FLOAT_CRUTCHES,csv_files_FLOAT_NO_CRUTCHES,Fs_Kin,Fs_EMG);

%Split into gaits
[SCI_subjects] = split_into_gaits_SCI(SCI_subjects);

% Healthy
[Healthy_subjects]= append_gait_events(Healthy_subjects,Fs_Kin,Fs_EMG);
[Healthy_subjects]= append_gait_cycles(Healthy_subjects);

%% Let's say we got something for EMG
EMG_feat_table_Healthy = Extract_EMG_features_Healthy(Healthy_subjects.(subject),Fs_EMG);
%% Trying for SCI subjects

EMG_feat_table_SCI = Extract_EMG_features_Healthy(SCI_subjects,Fs_EMG);


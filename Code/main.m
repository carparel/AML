% AML-Project 2 - Courtine part
%
% Group Members : - Giovanna Aiello
%                 - Gaia Carparelli
%                 - Marion Claudet
%                 - Martina Morea
%                 - Leonardo Pollina

clear;
clc;
current_folder = genpath('AML');
addpath(current_folder);

%% Loading the data for the SCI and creating the new useful structure
%
% ATTENTION: the first time the window will pop up select the folder
% containing the data of the SCI subjects. The second time select the
% folder containing the data of the Healthy subects.

[SCI_subjects, Healthy_subjects_18,Healthy_subjects_19, csv_files_FLOAT_NO_CRUTCHES,csv_files_NO_FLOAT_CRUTCHES] = load_data();

%% Global variables
%
% To choose the healthy subject
%subject = 'S_4';

% To stock the sampling frequency for the EMG SCI patients
Fs_EMG_S = SCI_subjects.FLOAT.T_01.fsEMG;
Fs_EMG_H18 = Fs_EMG_S;
Fs_EMG_H19 = Healthy_subjects_19.S_1.FLOAT.T_01.fsEMG;

% To stock the sampling frequency for the Kinetics
Fs_Kin = SCI_subjects.FLOAT.T_01.fsKIN;


%% Change typo in Subject 1 trial 1 NO_FLOAT 2019 Healthy

Healthy_subjects_19.S_1.NO_FLOAT.T_01.Raw.Kin.LKNE = Healthy_subjects_19.S_1.NO_FLOAT.T_01.Raw.Kin.LKNEE;
Healthy_subjects_19.S_1.NO_FLOAT.T_01.Raw.Kin.RKNE = Healthy_subjects_19.S_1.NO_FLOAT.T_01.Raw.Kin.RKNEE;
Healthy_subjects_19.S_1.NO_FLOAT.T_01.Raw.Kin.LKNEE = [];
Healthy_subjects_19.S_1.NO_FLOAT.T_01.Raw.Kin.RKNEE = [];


%% Structuring the EMG data

% We make sure to filter and normalize muscles with respect of max contraction
[Healthy_subjects_18,SCI_subjects] = structureEMG(Healthy_subjects_18,SCI_subjects,Fs_EMG_S,Fs_EMG_H18,'2018');
[Healthy_subjects_19,~] = structureEMG(Healthy_subjects_19,SCI_subjects,Fs_EMG_S,Fs_EMG_H19,'2019');

%% Structuring the Kin data

[Healthy_subjects_18,SCI_subjects] = structureKin(Healthy_subjects_18,SCI_subjects,Fs_Kin,'2018');
[Healthy_subjects_19,~] = structureKin(Healthy_subjects_19,SCI_subjects,Fs_Kin,'2019');

%% Clean data for S_4 Healthy subject 2018

coeff_dilatation_18 = Fs_EMG_H18/Fs_Kin; 
[Healthy_subjects_18] = clean_data(Healthy_subjects_18,coeff_dilatation_18,'2018');

coeff_dilatation_19 = Fs_EMG_H19/Fs_Kin; 
[Healthy_subjects_19] = clean_data(Healthy_subjects_19,coeff_dilatation_19,'2019');
 
%% Plotting the filtered signal together with the raw
% Choose the subject, the trial and the condition you want to plot

% condition = 'FLOAT';
% trial = 'T_03';
%  
% figure(1)
% plot_EMG(SCI_subjects.(condition).(trial).Normalized.EMG.envelope,SCI_subjects.(condition).(trial).Normalized.EMG.noenvelope,Fs_EMG_S);

% int this plot we have the EMG signal for healthy subjects for the four
% muscles of interest
% you have to give to the function the struct.chosen_trial
subject = 'S_3';
condition = 'FLOAT';
trial = 'T_03';
figure(2)
%Remember to give the right frequency.. 
plot_EMG(Healthy_subjects_19.(subject).(condition).(trial).Normalized.EMG.envelope,Healthy_subjects_19.(subject).(condition).(trial).Normalized.EMG.noenvelope,Fs_EMG_H19);

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

%% Visual detection of gait events --> ground truth

% ATTENTION: don't uncomment this lines if you don't want to repeat the visual detection.
% struct_events = visual_detection(Healthy_subjects_18,Healthy_subjects_19);

% TO LOAD the saved structure containing all the ground truth events
% previously detected:
load('Ground_truth.mat');


% To visualize the results of the visual inspection:
%check_ground_truth_events(struct_events,Healthy_subjects_18,Healthy_subjects_19);
%% Detect gait events for SCI subjects
%
% In order to detect the gait events we have considered the Y coordinate of
% the markers ANKLE and TOE. The Heel Strike (HS) will correspond to the
% first index of the plateau of the ankle, the Heel Off (HO) to the last
% index of the plateau of the ankle and the same for the Toe (Toe Strike
% and Toe Off).
% We will thus only consider ANKLE and TOE markers.

% SCI subjects
[SCI_subjects] = detect_gait_events_SCI(SCI_subjects,csv_files_NO_FLOAT_CRUTCHES,csv_files_FLOAT_NO_CRUTCHES,Fs_Kin,Fs_EMG_S);
[SCI_subjects] = cut_events_SCI(SCI_subjects);
%Split into gaits
[SCI_subjects] = split_into_gaits_SCI(SCI_subjects);
%% Healthy subjects

% Healthy 2018 with algorithm
% [Healthy_subjects_18]= append_gait_events(Healthy_subjects_18,Fs_Kin,Fs_EMG_H18,'2018');
% [Healthy_subjects_18] = cut_events(Healthy_subjects_18,'2018');
% [Healthy_subjects_18]= append_gait_cycles(Healthy_subjects_18,'2018');
% Healthy 2019 with algorithm
% [Healthy_subjects_19]= append_gait_events(Healthy_subjects_19,Fs_Kin,Fs_EMG_H19,'2019');
% [Healthy_subjects_19] = cut_events(Healthy_subjects_19,'2019');
% [Healthy_subjects_19]= append_gait_cycles(Healthy_subjects_19,'2019');

% Healthy 2018  with ground truth
[Healthy_subjects_18]= append_gait_events_ground_truth(Healthy_subjects_18,struct_events,Fs_Kin,Fs_EMG_H18,'2018');
[Healthy_subjects_18] = cut_events(Healthy_subjects_18,'2018');
[Healthy_subjects_18]= append_gait_cycles(Healthy_subjects_18,'2018');

% Healthy 2019 with ground truth
[Healthy_subjects_19]= append_gait_events_ground_truth(Healthy_subjects_19,struct_events,Fs_Kin,Fs_EMG_H19,'2019');
[Healthy_subjects_19] = cut_events(Healthy_subjects_19,'2019');
[Healthy_subjects_19]= append_gait_cycles(Healthy_subjects_19,'2019');


%% Check events for muscle 
% figure;
% current_muscle = Healthy_subjects_19.S_2.FLOAT.T_01.Raw.EMG.RMG;
% plot(current_muscle);
% hold on;
% current_event_HS = Healthy_subjects_19.S_1.FLOAT.T_01.Event.Right.HS_emg;
% plot( current_event_HS, current_muscle(current_event_HS),'ro');

%% Extraction of Healthy features 

[struct_features_healthy,struct_labels_healthy] = create_struct_features_healthy(Healthy_subjects_18,Healthy_subjects_19);
[~,healthy_matrix,healthy_labels] = merge_healthy_subjects(struct_features_healthy,struct_labels_healthy);

[SCI_matrix,labels_SCI] = create_struct_features_SCI(SCI_subjects);

%% Merging everything

[whole_table,whole_matrix,whole_labels] = merge_condition_tables(healthy_matrix,healthy_labels,SCI_matrix,labels_SCI);

%This is a bad sample, we remove it 
whole_table(49,:) = [];
whole_matrix(49,:) = [];
whole_labels(49,:) = [];
%% Applying PCA

[PCA_data,features_weights] = apply_PCA(whole_matrix);
find_clusters(PCA_data,whole_labels);

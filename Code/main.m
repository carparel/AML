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

% ATTENTION: the first time the window will pop up select the folder
% containing the data of the SCI subjects. The second time select the
% folder containing the data of the Healthy subects.

[SCI_subjects, Healthy_subjects_18,Healthy_subjects_19, csv_files_FLOAT_NO_CRUTCHES,csv_files_NO_FLOAT_CRUTCHES] = load_data();

%% Global variables
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
% subject = 'S_4';
% condition = 'FLOAT';
% trial = 'T_03';
%  
% figure(1)
% plot_EMG(SCI_subjects.(condition).(trial).Normalized.EMG.envelope,SCI_subjects.(condition).(trial).Normalized.EMG.noenvelope,Fs_EMG_S);

% int this plot we have the EMG signal for healthy subjects for the four
% muscles of interest
% you have to give to the function the struct.chosen_trial
subject = 'S_1';
condition = 'NO_FLOAT';
trial = 'T_01';
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

%% Detect gait events
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

% Healthy 2018
[Healthy_subjects_18]= append_gait_events(Healthy_subjects_18,Fs_Kin,Fs_EMG_H18,'2018');
[Healthy_subjects_18] = cut_events(Healthy_subjects_18,'2018');
[Healthy_subjects_18]= append_gait_cycles(Healthy_subjects_18,'2018');
% Healthy 2019
[Healthy_subjects_19]= append_gait_events(Healthy_subjects_19,Fs_Kin,Fs_EMG_H19,'2019');
[Healthy_subjects_19] = cut_events(Healthy_subjects_19,'2019');
[Healthy_subjects_19]= append_gait_cycles(Healthy_subjects_19,'2019');

%% Extraction of EMG features --> finally done
% For Healthy subjects 2018
subject = 'S_4';
EMG_feat_table_Healthy_18 = Extract_EMG_features(Healthy_subjects_18.(subject),'Healthy',Fs_EMG_H18);
% For Healthy subjects 2019
subject = 'S_1';
EMG_feat_table_Healthy_19 = Extract_EMG_features(Healthy_subjects_19.(subject),'Healthy',Fs_EMG_H19);

% For SCI subjects
EMG_feat_table_SCI = Extract_EMG_features(SCI_subjects,'SCI',Fs_EMG_S);

%% Extraction of Kin features 
% For Healthy subjects 2018
subject = 'S_4';
Kin_feat_table_Healthy_18 = Extract_Kin_features(Healthy_subjects_18.(subject),'Healthy');
% For Healthy subjects 2019
subject = 'S_1';
Kin_feat_table_Healthy_19 = Extract_Kin_features(Healthy_subjects_19.(subject),'Healthy');

% For SCI subjects
Kin_feat_table_SCI = Extract_Kin_features(SCI_subjects,'SCI');

%% Extraction of Temporal features
% For Healthy subjects 2018
subject = 'S_4';
Temporal_feat_table_Healthy_18 = extract_temp_features(Healthy_subjects_18.(subject),Fs_Kin,'Healthy');
% For Healthy subjects 2019
subject = 'S_1';
Temporal_feat_table_Healthy_19 = extract_temp_features(Healthy_subjects_19.(subject),Fs_Kin,'Healthy');

% For SCI subjects
Temporal_feat_table_SCI = extract_temp_features(SCI_subjects,Fs_Kin,'SCI');


%% Extraction of Spatial features
% For Healthy subjects 2018
subject = 'S_4';
Spatial_feat_table_Healthy_18 = extract_space_features(Healthy_subjects_18.(subject),'Healthy');
% For Healthy subjects 2019
subject = 'S_1';
Spatial_feat_table_Healthy_19 = extract_space_features(Healthy_subjects_19.(subject),'Healthy');

% For SCI subjects
Spatial_feat_table_SCI = extract_space_features(SCI_subjects,'SCI');
%% Merging everything

% Merging horizontally the features for each condition
[whole_feat_table_H,whole_feat_matrix_H,labels_H] = merge_feat_tables(EMG_feat_table_Healthy,Kin_feat_table_Healthy,Temporal_feat_table_Healthy,Spatial_feat_table_Healthy);
[whole_feat_table_SCI,whole_feat_matrix_SCI,labels_SCI] = merge_feat_tables(EMG_feat_table_SCI,Kin_feat_table_SCI,Temporal_feat_table_SCI,Spatial_feat_table_SCI);

[whole_table,whole_matrix,whole_labels] = merge_condition_tables(whole_feat_matrix_H,labels_H,whole_feat_matrix_SCI,labels_SCI);
%% Applying PCA
[PCA_data,features_weights] = apply_PCA(whole_matrix);

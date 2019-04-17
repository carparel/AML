% AML-Project - Comparison of gait parameters in SCIand Healthy subjects through PCA
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

%% Loading the data for the SCI and Healthy subjects (2018 and 2019)

[SCI_subjects, Healthy_subjects_18,Healthy_subjects_19, csv_files_FLOAT_NO_CRUTCHES,csv_files_NO_FLOAT_CRUTCHES] = load_data();

%% Global variables

% To stock the sampling frequency for the EMG SCI patients
Fs_EMG_S = SCI_subjects.FLOAT.T_01.fsEMG;

% To stock the sampling frequency for the EMG Healthy 2018 patients
Fs_EMG_H18 = Fs_EMG_S;

% To stock the sampling frequency for the EMG Healthy 2019 patients
Fs_EMG_H19 = Healthy_subjects_19.S_1.FLOAT.T_01.fsEMG;

% To stock the sampling frequency for the Kinematics
Fs_Kin = SCI_subjects.FLOAT.T_01.fsKIN;

% To stock the coefficients of dilation(between EMG and Kinematics 
% frequencies) for 2018 and 2019 Healthy patients
coeff_dilatation_18 = Fs_EMG_H18/Fs_Kin;
coeff_dilatation_19 = Fs_EMG_H19/Fs_Kin; 
%% Change typo in Subject 1 trial 1 NO_FLOAT 2019 Healthy

Healthy_subjects_19 = correct_typo(Healthy_subjects_19);

%% Structuring,filtering and normalizing the EMG data

%To filter and normalize muscles with respect to maximal contraction
[Healthy_subjects_18,SCI_subjects] = structure_EMG(Healthy_subjects_18,SCI_subjects,Fs_EMG_S,Fs_EMG_H18,'2018');
[Healthy_subjects_19,~] = structure_EMG(Healthy_subjects_19,SCI_subjects,Fs_EMG_S,Fs_EMG_H19,'2019');
%% Structuring and filtering the Kin data

%To filter the marker signals
[Healthy_subjects_18,SCI_subjects] = structure_Kin(Healthy_subjects_18,SCI_subjects,Fs_Kin,'2018');
[Healthy_subjects_19,~] = structure_Kin(Healthy_subjects_19,SCI_subjects,Fs_Kin,'2019');

%% Clean data by cutting edges

% Cut edges for both Healthy 2018 and 2019 subjects for specific trials
[Healthy_subjects_18] = clean_data(Healthy_subjects_18,coeff_dilatation_18,'2018');
[Healthy_subjects_19] = clean_data(Healthy_subjects_19,coeff_dilatation_19,'2019');
%% Visual detection of gait events to obtain the ground truth events indices

% ATTENTION: don't uncomment this lines if you don't want to repeat the visual detection.
% struct_events = visual_detection(Healthy_subjects_18,Healthy_subjects_19);

% TO LOAD the saved structure containing all the ground truth events
% previously detected:
load('Ground_truth.mat');

% To visualize the results of the visual inspection:
% check_ground_truth_events(struct_events,Healthy_subjects_18,Healthy_subjects_19);
%% Duplicate Healthy subjects structures 
% To duplicate the structure in order to use it to detect events with the
% algorithm
Healthy_subjects_18_alg = Healthy_subjects_18;
Healthy_subjects_19_alg = Healthy_subjects_19;
%% Detect gait events for SCI subjects

% Using the provided .csv files
[SCI_subjects] = detect_gait_events_SCI(SCI_subjects,csv_files_NO_FLOAT_CRUTCHES,csv_files_FLOAT_NO_CRUTCHES,Fs_Kin,Fs_EMG_S);

% Cutting events in order to have same number of strike and off points for
% right and left leg
[SCI_subjects] = cut_events_SCI(SCI_subjects);

% Split into gaits
[SCI_subjects] = split_into_gaits_SCI(SCI_subjects);
%% Detect gait events for Healthy subjects using ground truth events

% Splitting into gaits for Healthy 2018 subjects with ground truth events
[Healthy_subjects_18]= append_gait_events_ground_truth(Healthy_subjects_18,struct_events,Fs_Kin,Fs_EMG_H18,'2018');

% Cutting events in order to have same number of strike and off points for
% right and left leg
[Healthy_subjects_18] = cut_events_Healthy(Healthy_subjects_18,'2018'); 
[Healthy_subjects_18]= append_gait_cycles(Healthy_subjects_18,'2018');

% Splitting into gaits for Healthy 2019 subjects with ground truth events
[Healthy_subjects_19]= append_gait_events_ground_truth(Healthy_subjects_19,struct_events,Fs_Kin,Fs_EMG_H19,'2019');

% Cutting events in order to have same number of strike and off points for
% right and left leg
[Healthy_subjects_19] = cut_events_Healthy(Healthy_subjects_19,'2019');
[Healthy_subjects_19]= append_gait_cycles(Healthy_subjects_19,'2019');
%% Detect gait events for Healthy subjects using the algorithm

% In order to detect the gait events we have considered the Y coordinate of
% the markers ANKLE and TOE. The Heel Strike (HS) will correspond to the
% first index of the plateau of the ankle, the Heel Off (HO) to the last
% index of the plateau of the ankle and the same for the Toe (Toe Strike
% and Toe Off).
% We will thus only consider ANKLE and TOE markers.

% Splitting into gaits for Healthy 2018 subjects with algorithm
[Healthy_subjects_18_alg]= append_gait_events(Healthy_subjects_18_alg,Fs_Kin,Fs_EMG_H18,'2018');

% Cutting events in order to have same number of strike and off points for
% right and left leg
[Healthy_subjects_18_alg] = cut_events_Healthy(Healthy_subjects_18_alg,'2018');
[Healthy_subjects_18_alg]= append_gait_cycles(Healthy_subjects_18_alg,'2018');

% Splitting into gaits for Healthy 2019 subjects with algorithm
[Healthy_subjects_19_alg]= append_gait_events(Healthy_subjects_19_alg,Fs_Kin,Fs_EMG_H19,'2019');

% Cutting events in order to have same number of strike and off points for
% right and left leg
[Healthy_subjects_19_alg] = cut_events_Healthy(Healthy_subjects_19_alg,'2019');
[Healthy_subjects_19_alg]= append_gait_cycles(Healthy_subjects_19_alg,'2019');

%% Computing Algorithm Accuracy

% In order to compare the ground truth events with the events found with
% the algorithm
 accuracy_18 = compute_accuracy(Healthy_subjects_18_alg,Healthy_subjects_18,'2018');
 accuracy_19 = compute_accuracy(Healthy_subjects_19_alg,Healthy_subjects_19,'2019');
 
 % To take the mean accuracy of the algorithm between the Healthy subjects 
 % 2018 and 2019 
 total_accuracy = mean([accuracy_18,accuracy_19]);

%% Extraction of Healthy features 

% To extract the gait features for both 2018 and 2019 structures for each subject separately
[struct_features_healthy,struct_labels_healthy] = create_struct_features_healthy(Healthy_subjects_18,Healthy_subjects_19);

% To create the final matrix for Healthy subjects (samples x features)
[~,healthy_matrix,healthy_labels] = merge_healthy_subjects(struct_features_healthy,struct_labels_healthy);
%% Extraction of SCI features 

% To extract the gait features for SCI subjects and create the final matrix
% for SCI subjects (samples x features)
[SCI_matrix,labels_SCI] = create_struct_features_SCI(SCI_subjects,Fs_EMG_S,Fs_Kin);

%% Merging everything

% Merging the final matrices for Healthy and for SCI subjects 
[whole_table,whole_matrix,whole_labels] = merge_condition_tables(healthy_matrix,healthy_labels,SCI_matrix,labels_SCI);

%% Applying Principal Component Analysis (PCA)

% PCA for all the kinematic + EMG parameters
[PCA_data,~] = apply_PCA(whole_matrix);
find_clusters(PCA_data,whole_labels);

% PCA only for the EMG parameters
EMG_matrix = whole_matrix(:,1:12);
[PCA_data,~] = apply_PCA(EMG_matrix);
find_clusters(PCA_data,whole_labels);

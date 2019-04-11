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
year = '2018';

[SCI_subjects, Healthy_subjects, csv_files_FLOAT_NO_CRUTCHES,csv_files_NO_FLOAT_CRUTCHES] = load_data(year);

%% Global variables
% To choose the healthy subject
%subject = 'S_4';

% To stock the sampling frequency for the EMG SCI patients
Fs_EMG_S = SCI_subjects.FLOAT.T_01.fsEMG;
if year == '2018'
    Fs_EMG_H = Fs_EMG_S;
else
    % To stock the sampling frequency for the EMG Healthy patients
    Fs_EMG_H = Healthy_subjects.S_1.FLOAT.T_01.fsEMG;
end

% To stock the sampling frequency for the Kinetics
Fs_Kin = SCI_subjects.FLOAT.T_01.fsKIN;

%% Clean data for S_4 Healthy subject 2018
% markers = {'RHIP','RKNE','RTOE','RANK','LHIP','LKNE','LTOE','LANK'};
% muscles = {'RMG','RTA','LMG','LTA'};
% coeff_dilatation = Fs_EMG_S/Fs_Kin;
% 
% for marker = 1: length(markers)
%     temporary_Kin = Healthy_subjects.(subject).NO_FLOAT.T_01.Raw.Kin.(markers{marker});
%     Healthy_subjects.(subject).NO_FLOAT.T_01.Raw.Kin.(markers{marker}) = temporary_Kin(100:end,:);
% end
% for muscle = 1: length(muscles)
%     temporary_EMG = Healthy_subjects.(subject).NO_FLOAT.T_01.Raw.EMG.(muscles{muscle});
%     Healthy_subjects.(subject).NO_FLOAT.T_01.Raw.EMG.(muscles{muscle}) = temporary_EMG(100*coeff_dilatation:end);
% end
%% Structuring the EMG data

[Healthy_subjects,SCI_subjects] = structureEMG(Healthy_subjects,SCI_subjects,Fs_EMG_S,Fs_EMG_H,year);
%% Structuring the Kin data

[Healthy_subjects,SCI_subjects] = structureKin(Healthy_subjects,SCI_subjects,Fs_Kin,year);
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
subject = 'S_4';
condition = 'NO_FLOAT';
trial = 'T_01';
figure(2)
%Remember to give the right frequency.. 
plot_EMG(Healthy_subjects.(subject).(condition).(trial).Normalized.EMG.envelope,Healthy_subjects.(subject).(condition).(trial).Normalized.EMG.noenvelope,Fs_EMG_H);

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

% Healthy
[Healthy_subjects]= append_gait_events(Healthy_subjects,Fs_Kin,Fs_EMG_H,year);
[Healthy_subjects] = cut_events(Healthy_subjects,year);
[Healthy_subjects]= append_gait_cycles(Healthy_subjects,year);

%% Extraction of EMG features --> finally done
subject = 'S_4';
% For Healthy subjects
EMG_feat_table_Healthy = Extract_EMG_features(Healthy_subjects.(subject),'Healthy',Fs_EMG_H);

% For SCI subjects
EMG_feat_table_SCI = Extract_EMG_features(SCI_subjects,'SCI',Fs_EMG_S);

%% Extraction of Kin features 
subject = 'S_4';
Kin_feat_table_Healthy = Extract_Kin_features(Healthy_subjects.(subject),'Healthy');
Kin_feat_table_SCI = Extract_Kin_features(SCI_subjects,'SCI');

%% Extraction of Temporal features
subject = 'S_4';
% For Healthy subjects 
Temporal_feat_table_Healthy = extract_temp_features(Healthy_subjects.(subject),Fs_Kin,'Healthy');

% For SCI subjects
Temporal_feat_table_SCI = extract_temp_features(SCI_subjects,Fs_Kin,'SCI');


%% Extraction of Spatial features
subject = 'S_4';
% For Healthy subjects 
Spatial_feat_table_Healthy = extract_space_features(Healthy_subjects.(subject),'Healthy');

% For SCI subjects
Spatial_feat_table_SCI = extract_space_features(SCI_subjects,'SCI');
%% Merging everything

% Merging horizontally the features for each condition
[whole_feat_table_H,whole_feat_matrix_H,labels_H] = merge_feat_tables(EMG_feat_table_Healthy,Kin_feat_table_Healthy,Temporal_feat_table_Healthy,Spatial_feat_table_Healthy);
[whole_feat_table_SCI,whole_feat_matrix_SCI,labels_SCI] = merge_feat_tables(EMG_feat_table_SCI,Kin_feat_table_SCI,Temporal_feat_table_SCI,Spatial_feat_table_SCI);

[whole_table,whole_matrix,whole_labels] = merge_condition_tables(whole_feat_matrix_H,labels_H,whole_feat_matrix_SCI,labels_SCI);
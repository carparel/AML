function [SCI_matrix,labels_SCI] = create_struct_features_SCI(SCI_subjects,Fs_EMG,Fs_Kin)
% This functions extracts all the features (gait parameters) for each gait
% cycle for the SCI subjects. Then. these different matrices are merged in
% order to have a final matrix representing the feature matrix for SCI
% subjects.
%
% INPUT: - SCI_subjects = structure containing all the data related to SCI
%                         subjects.
%        - fs_Kin = sampling frequency for the markers
%        - fs_EMG = sampling frequency for the EMG
%
% OUTPT: - SCI_matrix = matrix containing all the features for all the gait
%                       cycles extracted from the SCI subjects.
%        - labels_SCI = the vector containing the labels of all the samples
%                       extracted from the SCI subjects. These labels are
%                       useful in order to keep trace of which sample comes
%                       from a SCI subject and from the FLOAT or NO_FLOAT
%                       condition.

% Extract EMG features
EMG_feat_table_SCI = Extract_EMG_features(SCI_subjects,'SCI',Fs_EMG);

% Extract Kinetic features (Range of motion, angles, and angular velocity)
Kin_feat_table_SCI = Extract_Kin_features(SCI_subjects,'SCI');

% Extract temporal kinetic features
Temporal_feat_table_SCI = extract_temp_features(SCI_subjects,Fs_Kin,'SCI');

% Extract spatial kinetic features
Spatial_feat_table_SCI = extract_space_features(SCI_subjects,'SCI');

% Merging the tables for the different features
[~,SCI_matrix,labels_SCI] = merge_feat_tables(EMG_feat_table_SCI,Kin_feat_table_SCI,Temporal_feat_table_SCI,Spatial_feat_table_SCI);

end


function [struct_features_healthy,struct_labels_healthy] = create_struct_features_healthy(Healthy18,Healthy19)
% This function extracts the gait features (the gait parameters we are
% looking for) for both 2018 and 2019 structures for each subject separately.
% Then, the different matrices are merged all together for each subject
% in order to have the final feature matrix for each healthy subject. These
% matrices are thus stocked in a structure, which is given as output.
%
% INPUT: - Healthy18 = structure containing all the data related to healthy
%                      subjects of year 2018.
%        - Healthy19 = structure containing all the data related to healthy
%                      subjects of year 2019.
%
% OUTPUT: - struct_features_healthy = structure containing as fields the
%                                     the vectors of labels of the gait
%                                     cycles (our samples) for each subject.
%         - struct_labels_healthy = structure containing as fields the
%                                     the vectors of labels of the gait
%                                     cycles (our samples) for each subject.

number_subjects = length(fieldnames(Healthy19))+length(fieldnames(Healthy18));
Fs_EMG_H19 = Healthy19.S_1.FLOAT.T_01.fsEMG;
Fs_EMG_H18 = Healthy18.S_4.FLOAT.T_01.fsEMG;
Fs_Kin = Healthy19.S_1.FLOAT.T_01.fsKin;

struct_features_healthy = [];

for i = 1:number_subjects
    
    subject = ['S_' num2str(i)];
    
    if i < number_subjects % It means we're taking into account S1,S2,S3
        
        % Extract EMG features
        EMG_feat_table_Healthy_19 = extract_EMG_features(Healthy19.(subject),'Healthy',Fs_EMG_H19);
        
        % Extract Kinetic features (Range of motion, angles, and angular
        % velocity)
        Kin_feat_table_Healthy_19 = extract_Kin_features(Healthy19.(subject),'Healthy');
        
        % Extract temporal kinetic features
        [Temporal_feat_table_Healthy_19,gait_cycle_duration] = extract_temp_features(Healthy19.(subject),Fs_Kin,'Healthy');
        
        % Extract spatial kinetic features
        [Spatial_feat_table_Healthy_19,stride_length] = extract_space_features(Healthy19.(subject),'Healthy');
        
        % Extract the speed feature
        [Speed_feat_table_19] = extract_speed_feature(Healthy19.(subject),stride_length,gait_cycle_duration,'Healthy');
        
        % Merging the tables for the different features
        [~,struct_features_healthy.(subject),struct_labels_healthy.(subject)] = merge_feat_tables(EMG_feat_table_Healthy_19,Kin_feat_table_Healthy_19,Temporal_feat_table_Healthy_19,Spatial_feat_table_Healthy_19,Speed_feat_table_19);
        
    else
        
        % Extract EMG features
        EMG_feat_table_Healthy_18 = extract_EMG_features(Healthy18.(subject),'Healthy',Fs_EMG_H18);
        
        % Extract Kinetic features (Range of motion, angles, and angular
        % velocity)
        Kin_feat_table_Healthy_18 = extract_Kin_features(Healthy18.(subject),'Healthy');
        
        % Extract temporal kinetic features
        [Temporal_feat_table_Healthy_18,gait_cycle_duration] = extract_temp_features(Healthy18.(subject),Fs_Kin,'Healthy');
        
        % Extract spatial kinetic features
        [Spatial_feat_table_Healthy_18,stride_length] = extract_space_features(Healthy18.(subject),'Healthy');
        
        % Extract the speed feature
        [Speed_feat_table_18] = extract_speed_feature(Healthy18.(subject),stride_length,gait_cycle_duration,'Healthy');
        
        % Merging the tables for the different features
        [~,struct_features_healthy.(subject),struct_labels_healthy.(subject)] = merge_feat_tables(EMG_feat_table_Healthy_18,Kin_feat_table_Healthy_18,Temporal_feat_table_Healthy_18,Spatial_feat_table_Healthy_18,Speed_feat_table_18);
    end
end
% Plot figures in the report
plot_extract_EMG(Healthy19)
end


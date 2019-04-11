function [struct_features_healthy,struct_labels_healthy] = create_struct_features_healthy(Healthy18,Healthy19)

% Ciao

number_subjects = length(fieldnames(Healthy19))+length(fieldnames(Healthy18));
Fs_EMG_H19 = Healthy19.S_1.FLOAT.T_01.fsEMG;
Fs_EMG_H18 = Healthy18.S_4.FLOAT.T_01.fsEMG;
Fs_Kin = Healthy19.S_1.FLOAT.T_01.fsKin;

struct_features_healthy = [];

for i = 1:number_subjects
    
    subject = ['S_' num2str(i)];
    
    if i < number_subjects % Means we're taking into account S1,S2,S3
        
        EMG_feat_table_Healthy_19 = Extract_EMG_features(Healthy19.(subject),'Healthy',Fs_EMG_H19);
        Kin_feat_table_Healthy_19 = Extract_Kin_features(Healthy19.(subject),'Healthy');
        Temporal_feat_table_Healthy_19 = extract_temp_features(Healthy19.(subject),Fs_Kin,'Healthy');
        Spatial_feat_table_Healthy_19 = extract_space_features(Healthy19.(subject),'Healthy');
        [~,struct_features_healthy.(subject),struct_labels_healthy.(subject)] = merge_feat_tables(EMG_feat_table_Healthy_19,Kin_feat_table_Healthy_19,Temporal_feat_table_Healthy_19,Spatial_feat_table_Healthy_19);
        
    else
        
        EMG_feat_table_Healthy_18 = Extract_EMG_features(Healthy18.(subject),'Healthy',Fs_EMG_H18);
        Kin_feat_table_Healthy_18 = Extract_Kin_features(Healthy18.(subject),'Healthy');
        Temporal_feat_table_Healthy_18 = extract_temp_features(Healthy18.(subject),Fs_Kin,'Healthy');
        Spatial_feat_table_Healthy_18 = extract_space_features(Healthy18.(subject),'Healthy');
        [~,struct_features_healthy.(subject),struct_labels_healthy.(subject)] = merge_feat_tables(EMG_feat_table_Healthy_18,Kin_feat_table_Healthy_18,Temporal_feat_table_Healthy_18,Spatial_feat_table_Healthy_18);
    end
end
end


function [SCI_matrix,struct_labels_SCI] = create_struct_features_SCI(SCI_subjects)

% Ciao

Fs_EMG_S = SCI_subjects.FLOAT.T_01.fsEMG;
Fs_Kin = SCI_subjects.FLOAT.T_01.fsKIN;

EMG_feat_table_SCI = Extract_EMG_features(SCI_subjects,'SCI',Fs_EMG_S);
Kin_feat_table_SCI = Extract_Kin_features(SCI_subjects,'SCI');
Temporal_feat_table_SCI = extract_temp_features(SCI_subjects,Fs_Kin,'SCI');
Spatial_feat_table_SCI = extract_space_features(SCI_subjects,'SCI');
[~,SCI_matrix,struct_labels_SCI] = merge_feat_tables(EMG_feat_table_SCI,Kin_feat_table_SCI,Temporal_feat_table_SCI,Spatial_feat_table_SCI);

end


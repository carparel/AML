function [whole_feat_table,whole_feat_matrix,labels] = merge_feat_tables(EMG_table,Kin_table,temp_table,spatial_table,speed_table)
% This function merges the different tables containing the different kinds
% of features
%
% INPUT: - EMG_table = table containing the EMG features.
%        - Kin_table = table containing the Kin features (ROM, angular velocities, etc...)
%        - temp_table = table containing the temporal features (stance
%                       duration, swing duration, etc...)
%        - spatial_table = table containing the spatial features (stride
%                          length, step width, etc...)
%        - speed_table = table containing the speed features
%
% OUTPUT: - whole_feat_table = the table with all the features. The names of
%                             variables are indicated.
%         - whole_feat_matrix = the matrix corresponding to the
%                               whole_feat_table
%         - labels = a vector of 2 dimensions containing the labels
%                    indicating the "condition" of the gait cycle (healthy/SCI and
%                    FLOAT/NO_FLOAT)
%


emg_matrix_labels = table2array(EMG_table);
emg_matrix = emg_matrix_labels(:,3:end);

kin_matrix_labels = table2array(Kin_table);
kin_matrix = kin_matrix_labels(:,3:end);

temp_matrix_labels = table2array(temp_table);
temp_matrix = temp_matrix_labels(:,3:end);

spatial_matrix_labels = table2array(spatial_table);
spatial_matrix = spatial_matrix_labels(:,3:end);

speed_matrix_labels = table2array(speed_table);
speed_matrix = speed_matrix_labels(:,3:end);

labels_ = spatial_matrix_labels(:,1:2);
labels = array2table(labels_,'VariableNames',{'Healthy_Condition','NO_FLOAT_Condition'});

whole_feat_matrix = [emg_matrix,kin_matrix,temp_matrix,spatial_matrix,speed_matrix];

names_variables = {'LMG_duration','LMG_max','LMG_mean','RMG_duration','RMG_max',...
    'RMG_mean','LTA_duration','LTA_max','LTA_mean','RTA_duration','RTA_max','RTA_mean',...
    'ROM_ank_FE_R','ROM_knee_FE_R','ROM_hip_FE_R','ROM_knee_AA_R', 'ROM_hip_AA_R','w_ank_FE_R',...
    'w_knee_FE_R','w_hip_FE_R','w_knee_AA_R','w_hip_AA_R','ROM_ank_FE_L','ROM_knee_FE_L','ROM_hip_FE_L',...
    'ROM_knee_AA_L', 'ROM_hip_AA_L','w_ank_FE_L','w_knee_FE_L','w_hip_FE_L','w_knee_AA_L','w_hip_AA_L',...
    'gait_cycle_duration','cadence','stance_duration_right','swing_duration_right','stance_duration_left',...
    'swing_duration_left','double_stance_duration','stride_length_right_m','stride_length_left_m','swing_length_right_cm',...
    'swing_length_left_cm','step_length_right_cm','step_length_left_cm','step_width_cm','max_heel_clearance_right',...
    'max_heel_clearance_left','max_knee_clearance_right','max_knee_clearance_left','max_toe_clearance_right','max_toe_clearance_left', ...
    'speed_right','speed_left'
    };

whole_feat_table = array2table(whole_feat_matrix,'VariableNames',names_variables);

end


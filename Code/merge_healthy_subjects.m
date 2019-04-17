function [healthy_table,healthy_matrix,healthy_labels] = merge_healthy_subjects(struct_subjects,struct_labels)
% This function merges (vertically) the matrices containing the features 
% for different Healthy subjects.
%
% INPUT: - struct_subjects = structure containing the matrices with all the
%                            features of the different subjects. Thus, the 
%                            fields of this structure are the subjects,
%                            such as 'S_1'.
%        - struct_labels = structure containing the labels for each subject
%                          for each gait cycle (each sample).
%
% OUTPUT: - healthy_table = final table containing all the samples (gait
%                           cycles) from all the healthy subjects. The
%                           columns are labeled.
%         _ healthy_matrix = same as healthy_table, but it is a simple
%                            matrix.
%         - healthy_labels = whole vector of labels for all gait cycles for
%                            healthy subjects.


healthy_matrix = [struct_subjects.S_1;struct_subjects.S_2;struct_subjects.S_3;struct_subjects.S_4];

% Defining the labels to keep trace of the characteristics of each gait
% cycle


struct_labels = [table2array(struct_labels.S_1);table2array(struct_labels.S_2);table2array(struct_labels.S_3);table2array(struct_labels.S_4)];
healthy_labels = array2table(struct_labels,'VariableNames',{'FLOAT_Condition','NO_FLOAT_Condition'});

names_variables = {'LMG_duration','LMG_max','LMG_mean','RMG_duration','RMG_max',...
    'RMG_mean','LTA_duration','LTA_max','LTA_mean','RTA_duration','RTA_max','RTA_mean',...
    'ROM_ank_FE_R','ROM_knee_FE_R','ROM_hip_FE_R','ROM_knee_AA_R', 'ROM_hip_AA_R','w_ank_FE_R',...
    'w_knee_FE_R','w_hip_FE_R','w_knee_AA_R','w_hip_AA_R','ROM_ank_FE_L','ROM_knee_FE_L','ROM_hip_FE_L',...
    'ROM_knee_AA_L', 'ROM_hip_AA_L','w_ank_FE_L','w_knee_FE_L','w_hip_FE_L','w_knee_AA_L','w_hip_AA_L',...
    'gait_cycle_duration','cadence','stance_duration_right','swing_duration_right','stance_duration_left',...
    'swing_duration_left','double_stance_duration','stride_length_right_m','stride_length_left_m','swing_length_right_cm',...
    'swing_length_left_cm','step_length_right_cm','step_length_left_cm','step_width_cm','max_heel_clearance_right',...
    'max_heel_clearance_left','max_knee_clearance_right','max_knee_clearance_left','max_toe_clearance_right','max_toe_clearance_left'
    };

healthy_table = array2table(healthy_matrix,'VariableNames',names_variables);
end
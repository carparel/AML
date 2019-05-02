function [whole_table,whole_matrix,whole_labels] = merge_condition_tables(whole_matrix_H,labels_H,whole_matrix_SCI,labels_SCI)
% This function merges (vertically) the two matrices of Healthy and SCI
% features.
%
% INPUT: - whole_matrix_H = matrix containing all the features of the
%                           Healthy subjects
%        - labels_H = labels indicating the condition of the "gait cycles"
%                     in the Healthy group
%        - whole_matrix_SCI = matrix containing all the features of the
%                             SCI subjects
%        - labels_SCI = labels indicating the condition of the "gait cycles"
%                       in the SCI group
%
% OUTPUT: - whole_table = the table with all the features. The names of
%                         variables are indicated.
%         - whole_matrix = the matrix corresponding to the whole_feat_table                       
%         - whole_labels = a vector of 2 dimensions containing the labels
%                          indicating the "condition" of the gait cycle 
%                          (healthy/SCI and FLOAT/NO_FLOAT)

whole_matrix = [whole_matrix_H;whole_matrix_SCI];

% Defining the labels to keep trace of the characteristics of each gait
% cycle

labels_H = table2array(labels_H);
labels_SCI = table2array(labels_SCI);
labels = [labels_H;labels_SCI];
whole_labels = array2table(labels,'VariableNames',{'Healthy_Condition','NO_FLOAT_Condition'});

names_variables = {'LMG_duration','LMG_max','LMG_mean','RMG_duration','RMG_max',...
    'RMG_mean','LTA_duration','LTA_max','LTA_mean','RTA_duration','RTA_max','RTA_mean',...
    'ROM_ank_FE_R','ROM_knee_FE_R','ROM_hip_FE_R','ROM_knee_AA_R', 'ROM_hip_AA_R','w_ank_FE_R',...
    'w_knee_FE_R','w_hip_FE_R','w_knee_AA_R','w_hip_AA_R','ROM_ank_FE_L','ROM_knee_FE_L','ROM_hip_FE_L',...
    'ROM_knee_AA_L', 'ROM_hip_AA_L','w_ank_FE_L','w_knee_FE_L','w_hip_FE_L','w_knee_AA_L','w_hip_AA_L',...
    'gait_cycle_duration','cadence','stance_duration_right','swing_duration_right','stance_duration_left',...
    'swing_duration_left','double_stance_duration','stride_length_m','swing_length_right_cm',...
    'swing_length_left_cm','step_length_right_cm','step_length_left_cm','step_width_cm','max_heel_clearance_right',...
    'max_heel_clearance_left','max_knee_clearance_right','max_knee_clearance_left','max_toe_clearance_right','max_toe_clearance_left',...
    'speed'
    };

whole_table = array2table(whole_matrix,'VariableNames',names_variables);
end


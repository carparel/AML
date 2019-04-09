function [Healthy_subjects]= append_gait_cycles(Healthy_subjects)
% This function appends to the original structure all the gait cycles.
% 
% INPUT: - Healthy_subjects = structure containing all the data from the
%                              Healthy subjects
%
% OUTPUT: - Healthy_subjects = updated structure


number_subjects = length(fieldnames(Healthy_subjects));
index_subject = [4];

for i = 1:length(index_subject)
    subject = ['S_' num2str(index_subject(i))];
    [Healthy_subjects] = split_into_gaits_healthy(Healthy_subjects,subject);
end
    
end
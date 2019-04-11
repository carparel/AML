function [Healthy_subjects]= append_gait_cycles(Healthy_subjects,year)
% This function appends to the original structure all the gait cycles.
% 
% INPUT: - Healthy_subjects = structure containing all the data from the
%                              Healthy subjects
%
% OUTPUT: - Healthy_subjects = updated structure


number_subjects = length(fieldnames(Healthy_subjects));
if year == '2018'
    index_subject = [4];
else
    index_subject = [1, 2, 3];
end


for i = 1:length(index_subject)
    subject = ['S_' num2str(index_subject(i))];
    [Healthy_subjects] = split_into_gaits_healthy(Healthy_subjects,subject);
end
    
end
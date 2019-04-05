function [Healthy_subjects]= append_gait_cycles(Healthy_subjects,fs_KIN,fs_EMG)
% This function appends to the original structure all the gait cycles.

% Subject 1 and 2 are not included for the moment because they are not
% correctly loaded 
number_sub = length(fieldnames(Healthy_subjects));
index_subject = [3,4,5,6];
    for i = 1:length(index_subject)
    subject = ['S_' num2str(index_subject(i))];
    [Healthy_subjects] = split_into_gaits_healthy(Healthy_subjects,subject,fs_KIN,fs_EMG);
    end
end
function [Healthy_subjects]= append_gait_events(Healthy_subjects,fs_KIN,fs_EMG,year)
% This function appends to the original structure all the gait events.
%
% INPUT: - Healthy_subjects = structure containing all the data from the
%                              Healthy subjects
%         - fs_Kin = sampling frequency for the markers
%         - fs_EMG = sampling frequency for the EMG
%         - year = A string variable indicating the year to which the
%                  healthy patients belong to. It can be either '2018' or 
%                  '2019'.
%
% OUTPUT: - Healthy_subjects = updated original structure

if strcmp(year,'2018')
    % There is only subject 4 on Healthy subject 2018
    index_subject = [4];
else
    % There are subjects 1,2,3 on Healthy subject 2019
    index_subject = [1, 2, 3];
end
for i = 1:length(index_subject)
    subject = ['S_' num2str(index_subject(i))];
    [Healthy_subjects] = detect_gait_events_healthy(Healthy_subjects,subject,fs_KIN,fs_EMG);
end
    
end
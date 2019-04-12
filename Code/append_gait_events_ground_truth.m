function [Healthy_subjects]= append_gait_events_ground_truth(Healthy_subjects,struct_all_events,fs_KIN,fs_EMG,year)
% This function appends to the original structure all the gait events.
%
% INPUT: - Healthy_subjects = structure containing all the data from the
%                              Healthy subjects
%         - fs_Kin = sampling frequency for the markers
%         - fs_EMG = sampling frequency for the EMG
%
% OUTPUT: Healthy_subjects = updated structure

if strcmp(year,'2018')
    index_subject = 4;
else
    index_subject = [1, 2, 3];
end

for i = 1:length(index_subject)
    subject = ['S_' num2str(index_subject(i))];
    year_events = struct_all_events.(['Year_' year]);
    Healthy_subjects = insert_ground_truth_events(Healthy_subjects,subject,year_events,fs_KIN,fs_EMG);
end
    
end
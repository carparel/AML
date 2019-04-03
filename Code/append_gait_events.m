function [Healthy_subjects]= append_gait_events(Healthy_subjects,leg)
% This function appends to the original structure all the gait events.

% Subject 1 and 2 are not included for the moment because they are not
% correctly loaded 

number_sub = length(fieldnames(Healthy_subjects));
index_subject = [3,4,5,6];
    for i = 1:length(index_subject)
    subject = ['S_' num2str(index_subject(i))];
    [Healthy_subjects] = detect_gait_events_healthy(Healthy_subjects,subject,leg);
    end
end
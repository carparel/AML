function [Healthy_subjects,SCI_subjects]= structureEMG(Healthy_subjects,SCI_subjects,Fs_EMG_S,Fs_EMG_H19,year)
% This function appends to the original structure all the EMG data
% filtered for the markers we are interested about. Inside the Filtered
% data, the EMG signals are divided into envelope and noenvelope

% Subject 1 and 2 are not included for the moment because they are not
% correctly loaded 
number_sub = length(fieldnames(Healthy_subjects));
if year == '2018'
    index_subject = [4];
else
    index_subject = [1, 2, 3];
end

    for i = 1:length(index_subject)
    subject = ['S_' num2str(index_subject(i))];
    [Healthy_subjects,SCI_subjects] = create_EMG_struct_filtered(Healthy_subjects,SCI_subjects,subject,Fs_EMG_S,Fs_EMG_H19,year);
    [Healthy_subjects,SCI_subjects] = normalize(Healthy_subjects,SCI_subjects,subject);
    end
end
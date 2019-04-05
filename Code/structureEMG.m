function [Healthy_subjects,SCI_subjects]= structureEMG(Healthy_subjects,SCI_subjects,Fs)
% This function appends to the original structure all the EMG data
% filtered for the markers we are interested about. Inside the Filtered
% data, the EMG signals are divided into envelope and noenvelope

% Subject 1 and 2 are not included for the moment because they are not
% correctly loaded 
number_sub = length(fieldnames(Healthy_subjects));
index_subject = [3,4,5,6];
    for i = 1:length(index_subject)
    subject = ['S_' num2str(index_subject(i))];
    [Healthy_subjects,SCI_subjects] = create_EMG_struct_filtered(Healthy_subjects,SCI_subjects,subject,Fs);
    [Healthy_subjects,SCI_subjects] = normalize(Healthy_subjects,SCI_subjects,subject);
    end
end
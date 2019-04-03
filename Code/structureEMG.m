function [Healthy_subjects,SCI_subjects]= structureEMG(Healthy_subjects,SCI_subjects,Fs)

% Choose your subject
number_sub = length(fieldnames(Healthy_subjects));
index_subject = [3,4,5,6];
    for i = 1:length(index_subject)
    subject = ['S_' num2str(index_subject(i))];
    [Healthy_subjects,SCI_subjects] = create_EMG_struct_filtered(Healthy_subjects,SCI_subjects,subject,Fs);
    end
end
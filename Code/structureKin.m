function [Healthy_subjects,SCI_subjects]= structureKin(Healthy_subjects,SCI_subjects,Fs,year)
% This function appends to the original structure all the kinetic data
% filtered for the markers we are interested about.

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
    [Healthy_subjects,SCI_subjects] = create_Kin_struct_filtered(Healthy_subjects,SCI_subjects,subject,Fs);
    end
end
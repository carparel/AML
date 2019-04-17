function [Healthy_subjects,SCI_subjects]= structure_Kin(Healthy_subjects,SCI_subjects,Fs_kin,year)
% This function appends to the original structure all the kinetic data
% filtered for the markers we are interested about.
%
% INPUT: - Healthy_subjects = structure containing all the data from the
%                             Healthy subjects.
%        - SCI_subjects = structure containing all the data from the
%                            SCI subjects.            
%        - Fs_kin = sampling frequency for the markers signals.
%        - year = A string variable indicating the year to which the
%                 healthy patients belong to. It can be either '2018' or 
%                 '2019'.
%
% OUTPUT: - Healthy_subjects = updated original structure
%         - SCI_subjects = updated original structure

if strcmp(year,'2018')
    % Healthy subjects 2018 contain only subject 4
    index_subject = [4];
else
    % Healthy subjects 2019 contain subjects 1,2,3
    index_subject = [1, 2, 3];
end
    for i = 1:length(index_subject)
    subject = ['S_' num2str(index_subject(i))];
    [Healthy_subjects,SCI_subjects] = create_Kin_struct_filtered(Healthy_subjects,SCI_subjects,subject,Fs_kin);
    end
end
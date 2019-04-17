function [Healthy_subjects,SCI_subjects]= structure_EMG(Healthy_subjects,SCI_subjects,Fs_EMG_S,Fs_EMG_H,year)
% This function appends to the original structure all the EMG data
% filtered for the markers we are interested about. Inside the Filtered
% data, the EMG signals are divided into envelope and noenvelope

% Subject 1 and 2 are not included for the moment because they are not
% correctly loaded 
%
% INPUT: - Healthy_subjects = structure containing all the data from the
%                             Healthy subjects.
%        - SCI_subjects = structure containing all the data from the
%                            SCI subjects.            
%        - fs_EMG_S = sampling frequency for the EMG for SCI subjects
%        - fs_EMG_H = sampling frequency for the EMG for Healthy subjects
%        - year = A string variable indicating the year to which the
%                 healthy patients belong to. It can be either '2018' or 
%                 '2019'.
%
% OUTPUT: - Healthy_subjects = updated original structure
%         - SCI_subjects = updated original structure

if year == '2018'
    % Healthy subjects 2018 contain only subject 4
    index_subject = [4];
else
    % Healthy subjects 2019 contain subjects 1,2,3
    index_subject = [1, 2, 3];
end
    for i = 1:length(index_subject)
    subject = ['S_' num2str(index_subject(i))];
    [Healthy_subjects,SCI_subjects] = create_EMG_struct_filtered(Healthy_subjects,SCI_subjects,subject,Fs_EMG_S,Fs_EMG_H,year);
    [Healthy_subjects,SCI_subjects] = normalize(Healthy_subjects,SCI_subjects,subject);
    end
end
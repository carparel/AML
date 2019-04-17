function [Healthy_subjects]= append_gait_cycles(Healthy_subjects,year)
% This function appends to the original structure all the gait cycles.
% 
% INPUT: - Healthy_subjects = structure containing all the data from the
%                              Healthy subjects
%        - year = A string variable indicating the year to which the healthy
%                 patients belong to. It can be either '2018' or '2019'.
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
    [Healthy_subjects] = split_into_gaits_healthy(Healthy_subjects,subject);
end

end
function [ Healthy_subjects, SCI_subjects] = create_Kin_struct_filtered(Healthy_subjects,SCI_subjects,subject,Fs)
% This function fills the fields in the original structures (Healthy and 
% SCI) corresponding to the filtered signals and the rectified ones.
%
% INPUT: - Healthy_subjects = Structure containing the data for healthy subjects
%        - SCI_subjects = Structure containing the data for SCI subjects
%        - subject = the number of the subject you want to analyse. It should be
%                    a string such as 'S_4' or 'S_5'
%        - Fs = sampling frequency of the Kin recording.
%
% OUTPUT: - Healthy_subjects = Updated structure with the filtered Kin                            
%         - SCI_subjects = Updated structure with the filtered Kin
  
conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
markers_SCI = {'LASI','RASI','LKNE','RKNE','LTOE','RTOE','LANK','RANK'};
markers_H = {'LHIP','RHIP','LKNE','RKNE','LTOE','RTOE','LANK','RANK'};

SCI_Kin = create_Kin_struct(SCI_subjects,'SCI');
Healthy_Kin = create_Kin_struct(Healthy_subjects.(subject),'Healthy');

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        temporary_struct = Healthy_Kin.(conditions{condition}).(trials{trial});
            for marker = 1:length(markers_H)
                 Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Filtered.Kin.(markers_H{marker}) = filtering_Kin(temporary_struct.(markers_H{marker}),Fs);
            end
    end
end

for condition = 1:length(conditions)
     for trial = 1:length(trials)
         temporary_struct = SCI_Kin.(conditions{condition}).(trials{trial});
            for marker = 1:length(markers_SCI)
                SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.Kin.(markers_SCI{marker}) = filtering_Kin(temporary_struct.(markers_SCI{marker}),Fs);
            end
    end
end


end


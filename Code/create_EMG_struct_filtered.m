function [Healthy_subjects,SCI_subjects] = create_EMG_struct_filtered(Healthy_subjects,SCI_subjects,subject,Fs_EMG_S,Fs_EMG_H,year)
% This function fills the fields in the original structures (Healthy and 
% SCI) corresponding to the filtered signals and the rectified ones.
%
% INPUT: - Healthy_subjects = Structure containing the data for healthy subjects
%        - SCI_subjects = Structure containing the data for SCI subjects
%        - subject = the number of the subject you want to analyse. It should be
%                    a string such as 'S_4' or 'S_5'
%        - Fs = sampling frequency of the EMG recording.
%
% OUTPUT: - Healthy_subjects = Updated structure with the filtered EMG                            
%         - SCI_subjects = Updated structure with the filtered EMG
                              
conditions = {'NO_FLOAT','FLOAT'};
muscles = {'RMG','LMG','RTA','LTA'};
trials = {'T_01','T_02','T_03'};
if year == '2018'
    Fs_EMG_H = Fs_EMG_S;
else 
    Fs_EMG_H = Fs_EMG_H;
end
    
    
SCI_EMG = create_EMG_struct(SCI_subjects);
Healthy_EMG = create_EMG_struct(Healthy_subjects.(subject));

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        temporary_struct = Healthy_EMG.(conditions{condition}).(trials{trial});
        for muscle = 1:length(muscles)
            Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Filtered.Type = 'Filtered Data';
            Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Filtered.EMG.envelope.(muscles{muscle}) = filtering_EMG(temporary_struct.(muscles{muscle}),'Healthy',Fs_EMG_H,true);
            Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Filtered.EMG.noenvelope.(muscles{muscle}) = filtering_EMG(temporary_struct.(muscles{muscle}),'Healthy',Fs_EMG_H,false);
            Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Rectified = abs(Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Filtered.EMG.noenvelope. ...
                (muscles{muscle}));
        end
    end
end

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        temporary_struct = SCI_EMG.(conditions{condition}).(trials{trial});
        for muscle = 1:length(muscles)
            SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.Type = 'Filtered Data';
            SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.EMG.envelope.(muscles{muscle}) = filtering_EMG(temporary_struct.(muscles{muscle}),'SCI',Fs_EMG_S,true);    
            SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.EMG.noenvelope.(muscles{muscle}) = filtering_EMG(temporary_struct.(muscles{muscle}),'SCI',Fs_EMG_S,false);    
            SCI_subjects.(conditions{condition}).(trials{trial}).Rectified = abs(SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.EMG.noenvelope.(muscles{muscle}));
        end
    end
end

end
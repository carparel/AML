function [Healthy_subjects,SCI_subjects] = normalize(Healthy_subjects,SCI_subjects,subject)
% This function removes artifacts and normalizes the EMG signal. The 
% normalization is performed by dividing with the maximum contraction
% recorded over all trials (of the same subject). The rationale behind this
% is that this value corresponds to the maximum contraction ever recorded
% in the selected subject. 
%
% INPUT: - Healthy_subjects = the structure containing all the data related 
%                             Healthy subjects.
%        - SCI_subjects = the structure containing all the data related 
%                         SCI subjects. 
%        - subject = a string parameter. It has to be the number of the
%                    subject, such as 'S_4'.
%
% OUTPUT: - Healthy_subjects = updated original Healthy structure.
%         - SCI_subjects = updated original SCI structure.

conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
muscles = {'RMG','LMG','RTA','LTA'};

for muscle = 1:length(muscles) 
    for trial = 1:length(trials)
        for condition = 1:length(conditions)
            maximum_noenv(trial,condition) = max(Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Filtered.EMG.noenvelope.(muscles{muscle}));
            maximum_env(trial,condition)= max(Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Filtered.EMG.envelope.(muscles{muscle}));
        end
    end
    absolute_maxima_noenv = max(max(maximum_noenv));
    absolute_maxima_env = max(max(maximum_env));
    for trial = 1:length(trials)
        for condition = 1:length(conditions)
    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Normalized.EMG.noenvelope.(muscles{muscle}) = ... 
    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Filtered.EMG.noenvelope.(muscles{muscle})/absolute_maxima_noenv;
    
    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Normalized.EMG.envelope.(muscles{muscle}) = ... 
    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Filtered.EMG.envelope.(muscles{muscle})/absolute_maxima_env;
        end
    end
end

for muscle = 1:length(muscles) 
    for trial = 1:length(trials)
        for condition = 1:length(conditions)
            maximum_noenv(trial,condition) = max(SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.EMG.noenvelope.(muscles{muscle}));
            maximum_env(trial,condition) = max(SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.EMG.envelope.(muscles{muscle}));
        end
    end
    absolute_maxima_noenv = max(max(maximum_noenv));
    absolute_maxima_env = max(max(maximum_env));
    for trial = 1:length(trials)
        for condition = 1:length(conditions)
            SCI_subjects.(conditions{condition}).(trials{trial}).Normalized.EMG.noenvelope.(muscles{muscle}) = ... 
            SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.EMG.noenvelope.(muscles{muscle})/absolute_maxima_noenv;

            SCI_subjects.(conditions{condition}).(trials{trial}).Normalized.EMG.envelope.(muscles{muscle}) = ... 
            SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.EMG.envelope.(muscles{muscle})/absolute_maxima_env;
        end
    end
end

end
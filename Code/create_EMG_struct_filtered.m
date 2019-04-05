function [Healthy_subjects,SCI_subjects] = create_EMG_struct_filtered(Healthy_subjects,SCI_subjects,subject,Fs)

conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
muscles = {'RMG','LMG','RTA','LTA'};

SCI_EMG = create_EMG_struct(SCI_subjects);
Healthy_EMG = create_EMG_struct(Healthy_subjects.(subject));

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        temporary_struct = Healthy_EMG.(conditions{condition}).(trials{trial});
        for muscle = 1:length(muscles)
            Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Filtered.Type = 'Filtered Data';
            Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Filtered.EMG.envelope.(muscles{muscle}) = filtering_EMG(temporary_struct.(muscles{muscle}),Fs,true);
            Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Filtered.EMG.noenvelope.(muscles{muscle}) = filtering_EMG(temporary_struct.(muscles{muscle}),Fs,false);
        end
    end
end

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        temporary_struct = SCI_EMG.(conditions{condition}).(trials{trial});
        for muscle = 1:length(muscles)
            SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.Type = 'Filtered Data';
            SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.EMG.envelope.(muscles{muscle}) = filtering_EMG(temporary_struct.(muscles{muscle}),Fs,true);    
            SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.EMG.noenvelope.(muscles{muscle}) = filtering_EMG(temporary_struct.(muscles{muscle}),Fs,false);    
        end
    end
end

end
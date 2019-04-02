function [struct_EMG_filtered] = create_EMG_struct_filtered(EMG_struct,Fs,envelope)

conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
muscles = {'RMG','LMG','RTA','LTA'};


for condition = 1:length(conditions)
    for trial = 1:length(trials)
        temporary_struct = EMG_struct.(conditions{condition}).(trials{trial});
        for muscle = 1:length(muscles)
            struct_EMG_filtered.(conditions{condition}).(trials{trial}).(muscles{muscle}) = filtering_EMG(temporary_struct.(muscles{muscle}),Fs,envelope);    
        end
    end
end

end
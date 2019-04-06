function [new_struct] = merge_EMG_subjects(data)
% DON'T SHOW TO ANYONE

conditions = {'FLOAT','NO_FLOAT'};
trials = {'T_01','T_02','T_03'};

new_struct = data.('S_4');

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        current = new_struct.(conditions{condition}).(trials{trial}).Parsed;
        if strcmp(conditions{condition},'NO_FLOAT')
            for gait = 1:2
                current{1,gait}.Left.EMG.envelope.LMG =  data.S_5.NO_FLOAT.(trials{trial}).Parsed{1,gait}.Left.EMG.envelope.LMG;
            end
        end
    end
end

end


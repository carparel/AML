function [struct_EMG] = create_EMG_struct(raw_struct)
% This function is used in order to have a more compact structure containing 
% the EMG data (only the muscles we are interested in).
%
% INPUTS: - raw_struct = the structure containing all the fields. It's the
%                        structure from which you want to sort some data.
%
% OUTPUT: - struct_EMG = the more compact structure containing the EMG
%                        markers with only the desired muscles.

conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
muscles = {'RMG','LMG','RTA','LTA'};


for condition = 1:length(conditions)
    for trial = 1:length(trials)
        temporary_struct = raw_struct.(conditions{condition}).(trials{trial}).Raw.EMG;
        for muscle = 1:length(muscles)
            struct_EMG.(conditions{condition}).(trials{trial}).(muscles{muscle}) = temporary_struct.(muscles{muscle});
        end
    end
end


end


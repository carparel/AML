function [struct_Kin] = create_Kin_struct(raw_struct,type)
% BLABLABLA

conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
markers_SCI = {'LASI','RASI','LKNE','RKNE','LTOE','RTOE','LANK','RANK'};
markers_H = {'LHIP','RHIP','LKNE','RKNE','LTOE','RTOE','LANK','RANK'};

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        temporary_struct = raw_struct.(conditions{condition}).(trials{trial}).Raw.Kin;
        if strcmp(type,'SCI')
            for marker = 1:length(markers_SCI)
                struct_Kin.(conditions{condition}).(trials{trial}).(markers_SCI{marker}) = temporary_struct.(markers_SCI{marker});
            end
        elseif strcmp(type,'Healthy')
            for marker = 1:length(markers_H)
                struct_Kin.(conditions{condition}).(trials{trial}).(markers_H{marker}) = temporary_struct.(markers_H{marker});
            end
        end
    end
end


end


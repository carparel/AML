function [struct_Kin_filtered] = create_Kin_struct_filtered(Kin_struct,Fs,type)
% BLABLABLABLA
% 
%
conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
markers_SCI = {'LASI','RASI','LKNE','RKNE','LTOE','RTOE','LANK','RANK'};
markers_H = {'LHIP','RHIP','LKNE','RKNE','LTOE','RTOE','LANK','RANK'};

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        temporary_struct = Kin_struct.(conditions{condition}).(trials{trial});
        if strcmp(type,'SCI')
            for marker = 1:length(markers_SCI)
                struct_Kin_filtered.(conditions{condition}).(trials{trial}).(markers_SCI{marker}) = filtering_Kin(temporary_struct.(markers_SCI{marker}),Fs);
            end
        elseif strcmp(type,'Healthy')
            for marker = 1:length(markers_H)
                struct_Kin_filtered.(conditions{condition}).(trials{trial}).(markers_H{marker}) = filtering_Kin(temporary_struct.(markers_H{marker}),Fs);
            end
        end
    end
end


end


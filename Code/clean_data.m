function [subjects_struct] = clean_data(subjects_struct,coeff_dilatation,year)

    % This function cuts the edges of the Filtered data in order to remove artefacts
    % INPUT:   -subjects_struct
    % OUTPUT:  -subjects_struct: same structure of the input one, with edges
    %           removed

    markers = {'RHIP','RKNE','RTOE','RANK','LHIP','LKNE','LTOE','LANK'};
    muscles = {'RMG','RTA','LMG','LTA'};
 

    if strcmp(year,'2018')
        subject = 'S_4';
        for marker = 1: length(markers)
            temporary_Kin = subjects_struct.(subject).NO_FLOAT.T_01.Filtered.Kin.(markers{marker});
            subjects_struct.(subject).NO_FLOAT.T_01.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-100,:);
        end
        for muscle = 1: length(muscles)
            temporary_EMG = subjects_struct.(subject).NO_FLOAT.T_01.Filtered.EMG.envelope.(muscles{muscle});
            subjects_struct.(subject).NO_FLOAT.T_01.Filtered.EMG.envelope.(muscles{muscle}) = temporary_EMG(1:end-100*coeff_dilatation);
        end

    else
        % S_2
        % T03
        % No Float
        for marker = 1: length(markers)
            temporary_Kin = subjects_struct.S_2.NO_FLOAT.T_03.Filtered.Kin.(markers{marker});
            subjects_struct.S_2.NO_FLOAT.T_03.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-200,:);
        end
        for muscle = 1: length(muscles)
            temporary_EMG = subjects_struct.S_2.NO_FLOAT.T_03.Filtered.EMG.envelope.(muscles{muscle});
            subjects_struct.S_2.NO_FLOAT.T_03.Filtered.EMG.envelope.(muscles{muscle}) = temporary_EMG(1:end-200*coeff_dilatation);
        end

        % Float
        for marker = 1: length(markers)
            temporary_Kin = subjects_struct.S_2.NO_FLOAT.T_03.Filtered.Kin.(markers{marker});
            subjects_struct.S_2.FLOAT.T_03.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-60,:);
        end
        for muscle = 1: length(muscles)
            temporary_EMG = subjects_struct.S_2.NO_FLOAT.T_03.Filtered.EMG.envelope.(muscles{muscle});
            subjects_struct.S_2.FLOAT.T_03.Filtered.EMG.envelope.(muscles{muscle}) = temporary_EMG(1:end-60*coeff_dilatation);
        end    

        % T02
        % No Float
        for marker = 1: length(markers)
            temporary_Kin = subjects_struct.S_2.NO_FLOAT.T_02.Filtered.Kin.(markers{marker});
            subjects_struct.S_2.NO_FLOAT.T_02.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-300,:);
        end
        for muscle = 1: length(muscles)
            temporary_EMG = subjects_struct.S_2.NO_FLOAT.T_02.Filtered.EMG.envelope.(muscles{muscle});
            subjects_struct.S_2.NO_FLOAT.T_02.Filtered.EMG.envelope.(muscles{muscle}) = temporary_EMG(1:end-300*coeff_dilatation);
        end

        % T01
        % No Float
        for marker = 1: length(markers)
            temporary_Kin = subjects_struct.S_2.NO_FLOAT.T_01.Filtered.Kin.(markers{marker});
            subjects_struct.S_2.NO_FLOAT.T_01.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-100,:);
        end
        for muscle = 1: length(muscles)
            temporary_EMG = subjects_struct.S_2.NO_FLOAT.T_01.Filtered.EMG.envelope.(muscles{muscle});
            subjects_struct.S_2.NO_FLOAT.T_01.Filtered.EMG.envelope.(muscles{muscle}) = temporary_EMG(1:end-100*coeff_dilatation);
        end

        % Float
        for marker = 1: length(markers)
            temporary_Kin = subjects_struct.S_2.FLOAT.T_01.Filtered.Kin.(markers{marker});
            subjects_struct.S_2.FLOAT.T_01.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-300,:);
        end
        for muscle = 1: length(muscles)
            temporary_EMG = subjects_struct.S_2.FLOAT.T_01.Filtered.EMG.envelope.(muscles{muscle});
            subjects_struct.S_2.FLOAT.T_01.Filtered.EMG.envelope.(muscles{muscle}) = temporary_EMG(1:end-300*coeff_dilatation);
        end  
        
        % S_1
        % T_03
        % Float
        for marker = 1: length(markers)
            temporary_Kin = subjects_struct.S_1.FLOAT.T_03.Filtered.Kin.(markers{marker});
            subjects_struct.S_1.FLOAT.T_03.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-300,:);
        end
        for muscle = 1: length(muscles)
            temporary_EMG = subjects_struct.S_1.FLOAT.T_03.Filtered.EMG.envelope.(muscles{muscle});
            subjects_struct.S_1.FLOAT.T_03.Filtered.EMG.envelope.(muscles{muscle}) = temporary_EMG(1:end-300*coeff_dilatation);
        end   
        
        % T_01
        % Float
        for marker = 1: length(markers)
            temporary_Kin = subjects_struct.S_1.FLOAT.T_01.Filtered.Kin.(markers{marker});
            subjects_struct.S_1.FLOAT.T_01.Filtered.Kin.(markers{marker}) = temporary_Kin(800:end-200,:);
        end
        for muscle = 1: length(muscles)
            temporary_EMG = subjects_struct.S_1.FLOAT.T_01.Filtered.EMG.envelope.(muscles{muscle});
            subjects_struct.S_1.FLOAT.T_01.Filtered.EMG.envelope.(muscles{muscle}) = temporary_EMG(800*coeff_dilatation:end-200*coeff_dilatation);
        end         

        % No Float
        for marker = 1: length(markers)
            temporary_Kin = subjects_struct.S_1.NO_FLOAT.T_01.Filtered.Kin.(markers{marker});
            subjects_struct.S_1.NO_FLOAT.T_01.Filtered.Kin.(markers{marker}) = temporary_Kin(200:end,:);
        end
        for muscle = 1: length(muscles)
            temporary_EMG = subjects_struct.S_1.NO_FLOAT.T_01.Filtered.EMG.envelope.(muscles{muscle});
            subjects_struct.S_1.NO_FLOAT.T_01.Filtered.EMG.envelope.(muscles{muscle}) = temporary_EMG(200*coeff_dilatation:end);
        end  
        
        % S_3
        % T_02
        % No Float
        for marker = 1: length(markers)
            temporary_Kin = subjects_struct.S_3.NO_FLOAT.T_02.Filtered.Kin.(markers{marker});
            subjects_struct.S_3.NO_FLOAT.T_02.Filtered.Kin.(markers{marker}) = temporary_Kin(50:end-100,:);
        end
        for muscle = 1: length(muscles)
            temporary_EMG = subjects_struct.S_3.NO_FLOAT.T_02.Filtered.EMG.envelope.(muscles{muscle});
            subjects_struct.S_3.NO_FLOAT.T_02.Filtered.EMG.envelope.(muscles{muscle}) = temporary_EMG(50*coeff_dilatation:end-100*coeff_dilatation);
        end  
 
        % T_01
        % Float
        for marker = 1: length(markers)
            temporary_Kin = subjects_struct.S_3.FLOAT.T_01.Filtered.Kin.(markers{marker});
            subjects_struct.S_3.FLOAT.T_01.Filtered.Kin.(markers{marker}) = temporary_Kin(100:end,:);
        end
        for muscle = 1: length(muscles)
            temporary_EMG = subjects_struct.S_3.FLOAT.T_01.Filtered.EMG.envelope.(muscles{muscle});
            subjects_struct.S_3.FLOAT.T_01.Filtered.EMG.envelope.(muscles{muscle}) = temporary_EMG(100*coeff_dilatation:end);
        end  
        
    end
    
    
    
    
    
    
    
    
    
end















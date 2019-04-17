function [subjects_struct] = clean_data(subjects_struct,coeff_dilatation,year)
% This function cuts the edges of the Filtered data in order to remove 
% artefacts.
%
% INPUT: - subjects_struct = the structure containing all the data for healthy
%                            subjects.
%        - coeff_dilatation = corresponding to the coefficient of
%                             dilatation between kin and emg signals. It is 
%                             equal to the ration between the emg sampling
%                             frequency and the kin sampling frequency.
%        - year = A string variable indicating the year to which the
%                 healthy patients belong to. It can be either '2018' or 
%                 '2019'.
%
% OUTPUT: - subjects_struct = same structure as the input one, with edges
%                             removed

% Defining kin markers for right and left leg
markers = {'RHIP','RKNE','RTOE','RANK','LHIP','LKNE','LTOE','LANK'};
% Defining EMG markers for right and left leg
muscles = {'RMG','RTA','LMG','LTA'};


if strcmp(year,'2018')
    % For Healthy subjects 2018 there is only subject 4
    subject = 'S_4';
    % Cutting edges for the kin signals
    for marker = 1: length(markers)
        temporary_Kin = subjects_struct.(subject).NO_FLOAT.T_01.Filtered.Kin.(markers{marker});
        subjects_struct.(subject).NO_FLOAT.T_01.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-100,:);
    end
    % Cutting edges for the EMG signals
    for muscle = 1: length(muscles)
        temporary_EMG_env = subjects_struct.(subject).NO_FLOAT.T_01.Normalized.EMG.envelope.(muscles{muscle});
        subjects_struct.(subject).NO_FLOAT.T_01.Normalized.EMG.envelope.(muscles{muscle}) = temporary_EMG_env(1:end-100*coeff_dilatation);
        temporary_EMG_no_env = subjects_struct.(subject).NO_FLOAT.T_01.Normalized.EMG.noenvelope.(muscles{muscle});
        subjects_struct.(subject).NO_FLOAT.T_01.Normalized.EMG.noenvelope.(muscles{muscle}) = temporary_EMG_no_env(1:end-100*coeff_dilatation);
    end

% For Healthy subjects 2019    
else
    
    % For the second subject S_2
    % For third trial T03
    % for No Float condition
    
    % Cutting edges for the kin signals
    for marker = 1: length(markers)
        temporary_Kin = subjects_struct.S_2.NO_FLOAT.T_03.Filtered.Kin.(markers{marker});
        subjects_struct.S_2.NO_FLOAT.T_03.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-200,:);
    end
    % Cutting edges for the EMG signals
    for muscle = 1: length(muscles)
        temporary_EMG_env = subjects_struct.S_2.NO_FLOAT.T_03.Normalized.EMG.envelope.(muscles{muscle});
        subjects_struct.S_2.NO_FLOAT.T_03.Normalized.EMG.envelope.(muscles{muscle}) = temporary_EMG_env(1:end-200*coeff_dilatation);
        temporary_EMG_no_env = subjects_struct.S_2.NO_FLOAT.T_03.Normalized.EMG.noenvelope.(muscles{muscle});
        subjects_struct.S_2.NO_FLOAT.T_03.Normalized.EMG.noenvelope.(muscles{muscle}) = temporary_EMG_no_env(1:end-200*coeff_dilatation);
    end
    
    % For the second subject S_2
    % For third trial T03
    % for Float condition
    
    % Cutting edges for the kin signals
    for marker = 1: length(markers)
        temporary_Kin = subjects_struct.S_2.FLOAT.T_03.Filtered.Kin.(markers{marker});
        subjects_struct.S_2.FLOAT.T_03.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-60,:);
    end
    % Cutting edges for the EMG signals
    for muscle = 1: length(muscles)
        temporary_EMG_env = subjects_struct.S_2.FLOAT.T_03.Normalized.EMG.envelope.(muscles{muscle});
        subjects_struct.S_2.FLOAT.T_03.Normalized.EMG.envelope.(muscles{muscle}) = temporary_EMG_env(1:end-60*coeff_dilatation);
        temporary_EMG_no_env = subjects_struct.S_2.FLOAT.T_03.Normalized.EMG.noenvelope.(muscles{muscle});
        subjects_struct.S_2.FLOAT.T_03.Normalized.EMG.noenvelope.(muscles{muscle}) = temporary_EMG_no_env(1:end-60*coeff_dilatation);
    end
    
    % For the second subject S_2
    % For second trial T02
    % For No Float condition
    
    % Cutting edges for the kin signals
    for marker = 1: length(markers)
        temporary_Kin = subjects_struct.S_2.NO_FLOAT.T_02.Filtered.Kin.(markers{marker});
        subjects_struct.S_2.NO_FLOAT.T_02.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-300,:);
    end
    % Cutting edges for the EMG signals
    for muscle = 1: length(muscles)
        temporary_EMG_env = subjects_struct.S_2.NO_FLOAT.T_02.Normalized.EMG.envelope.(muscles{muscle});
        subjects_struct.S_2.NO_FLOAT.T_02.Normalized.EMG.envelope.(muscles{muscle}) = temporary_EMG_env(1:end-300*coeff_dilatation);
        temporary_EMG_no_env = subjects_struct.S_2.NO_FLOAT.T_02.Normalized.EMG.noenvelope.(muscles{muscle});
        subjects_struct.S_2.NO_FLOAT.T_02.Normalized.EMG.noenvelope.(muscles{muscle}) = temporary_EMG_no_env(1:end-300*coeff_dilatation);
    end
    
    % For the second subject S_2
    % For first trial T01
    % For No Float condition
    
    % Cutting edges for the kin signals
    for marker = 1: length(markers)
        temporary_Kin = subjects_struct.S_2.NO_FLOAT.T_01.Filtered.Kin.(markers{marker});
        subjects_struct.S_2.NO_FLOAT.T_01.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-100,:);
    end
    % Cutting edges for the EMG signals
    for muscle = 1: length(muscles)
        temporary_EMG_env = subjects_struct.S_2.NO_FLOAT.T_01.Normalized.EMG.envelope.(muscles{muscle});
        subjects_struct.S_2.NO_FLOAT.T_01.Normalized.EMG.envelope.(muscles{muscle}) = temporary_EMG_env(1:end-100*coeff_dilatation);
        temporary_EMG_no_env = subjects_struct.S_2.NO_FLOAT.T_01.Normalized.EMG.noenvelope.(muscles{muscle});
        subjects_struct.S_2.NO_FLOAT.T_01.Normalized.EMG.noenvelope.(muscles{muscle}) = temporary_EMG_no_env(1:end-100*coeff_dilatation);
    end
    
    % For the second subject S_2
    % For first trial T01
    % For Float condition
    
    % Cutting edges for the kin signals
    for marker = 1: length(markers)
        temporary_Kin = subjects_struct.S_2.FLOAT.T_01.Filtered.Kin.(markers{marker});
        subjects_struct.S_2.FLOAT.T_01.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-300,:);
    end
    % Cutting edges for the EMG signals
    for muscle = 1: length(muscles)
        temporary_EMG_env = subjects_struct.S_2.FLOAT.T_01.Normalized.EMG.envelope.(muscles{muscle});
        subjects_struct.S_2.FLOAT.T_01.Normalized.EMG.envelope.(muscles{muscle}) = temporary_EMG_env(1:end-300*coeff_dilatation);
        temporary_EMG_no_env = subjects_struct.S_2.FLOAT.T_01.Normalized.EMG.noenvelope.(muscles{muscle});
        subjects_struct.S_2.FLOAT.T_01.Normalized.EMG.noenvelope.(muscles{muscle}) = temporary_EMG_no_env(1:end-300*coeff_dilatation);
    end
    
    % For the first subject S_1
    % For third trial T_03
    % For Float condition
    
    % Cutting edges for the kin signals
    for marker = 1: length(markers)
        temporary_Kin = subjects_struct.S_1.FLOAT.T_03.Filtered.Kin.(markers{marker});
        subjects_struct.S_1.FLOAT.T_03.Filtered.Kin.(markers{marker}) = temporary_Kin(1:end-300,:);
    end
    % Cutting edges for the EMG signals
    for muscle = 1: length(muscles)
        temporary_EMG_env = subjects_struct.S_1.FLOAT.T_03.Normalized.EMG.envelope.(muscles{muscle});
        subjects_struct.S_1.FLOAT.T_03.Normalized.EMG.envelope.(muscles{muscle}) = temporary_EMG_env(1:end-300*coeff_dilatation);
        temporary_EMG_no_env = subjects_struct.S_1.FLOAT.T_03.Normalized.EMG.noenvelope.(muscles{muscle});
        subjects_struct.S_1.FLOAT.T_03.Normalized.EMG.noenvelope.(muscles{muscle}) = temporary_EMG_no_env(1:end-300*coeff_dilatation);
    end
    
    % For the first subject S_1
    % For first trial T_01
    % For Float condition
    
    % Cutting edges for the kin signals
    for marker = 1: length(markers)
        temporary_Kin = subjects_struct.S_1.FLOAT.T_01.Filtered.Kin.(markers{marker});
        subjects_struct.S_1.FLOAT.T_01.Filtered.Kin.(markers{marker}) = temporary_Kin(800:end-200,:);
    end
    % Cutting edges for the EMG signals
    for muscle = 1: length(muscles)
        temporary_EMG_env = subjects_struct.S_1.FLOAT.T_01.Normalized.EMG.envelope.(muscles{muscle});
        subjects_struct.S_1.FLOAT.T_01.Normalized.EMG.envelope.(muscles{muscle}) = temporary_EMG_env(800*coeff_dilatation:end-200*coeff_dilatation);
        temporary_EMG_no_env = subjects_struct.S_1.FLOAT.T_01.Normalized.EMG.noenvelope.(muscles{muscle});
        subjects_struct.S_1.FLOAT.T_01.Normalized.EMG.noenvelope.(muscles{muscle}) = temporary_EMG_no_env(800*coeff_dilatation:end-200*coeff_dilatation);
    end
    
    % For the first subject S_1
    % For first trial T_01
    % For No Float condition
    
    % Cutting edges for the kin signals
    for marker = 1: length(markers)
        temporary_Kin = subjects_struct.S_1.NO_FLOAT.T_01.Filtered.Kin.(markers{marker});
        subjects_struct.S_1.NO_FLOAT.T_01.Filtered.Kin.(markers{marker}) = temporary_Kin(200:end,:);
    end
    % Cutting edges for the EMG signals
    for muscle = 1: length(muscles)
        temporary_EMG_env = subjects_struct.S_1.NO_FLOAT.T_01.Normalized.EMG.envelope.(muscles{muscle});
        subjects_struct.S_1.NO_FLOAT.T_01.Normalized.EMG.envelope.(muscles{muscle}) = temporary_EMG_env(200*coeff_dilatation:end);
        temporary_EMG_no_env = subjects_struct.S_1.NO_FLOAT.T_01.Normalized.EMG.noenvelope.(muscles{muscle});
        subjects_struct.S_1.NO_FLOAT.T_01.Normalized.EMG.noenvelope.(muscles{muscle}) = temporary_EMG_no_env(200*coeff_dilatation:end);
        
    end
    
    % For the third subject S_3
    % For second trial T_02
    % For No Float condition
    
    % Cutting edges for the kin signals
    for marker = 1: length(markers)
        temporary_Kin = subjects_struct.S_3.NO_FLOAT.T_02.Filtered.Kin.(markers{marker});
        subjects_struct.S_3.NO_FLOAT.T_02.Filtered.Kin.(markers{marker}) = temporary_Kin(50:end-100,:);
    end
    % Cutting edges for the EMG signals
    for muscle = 1: length(muscles)
        temporary_EMG_env = subjects_struct.S_3.NO_FLOAT.T_02.Normalized.EMG.envelope.(muscles{muscle});
        subjects_struct.S_3.NO_FLOAT.T_02.Normalized.EMG.envelope.(muscles{muscle}) = temporary_EMG_env(50*coeff_dilatation:end-100*coeff_dilatation);
        temporary_EMG_no_env = subjects_struct.S_3.NO_FLOAT.T_02.Normalized.EMG.noenvelope.(muscles{muscle});
        subjects_struct.S_3.NO_FLOAT.T_02.Normalized.EMG.noenvelope.(muscles{muscle}) = temporary_EMG_no_env(50*coeff_dilatation:end-100*coeff_dilatation);
    end
    
    % For the third subject S_3
    % For second trial T_01
    % For Float condition
    
    % Cutting edges for the kin signals
    for marker = 1: length(markers)
        temporary_Kin = subjects_struct.S_3.FLOAT.T_01.Filtered.Kin.(markers{marker});
        subjects_struct.S_3.FLOAT.T_01.Filtered.Kin.(markers{marker}) = temporary_Kin(100:end,:);
    end
    % Cutting edges for the EMG signals
    for muscle = 1: length(muscles)
        temporary_EMG_env = subjects_struct.S_3.FLOAT.T_01.Normalized.EMG.envelope.(muscles{muscle});
        subjects_struct.S_3.FLOAT.T_01.Normalized.EMG.envelope.(muscles{muscle}) = temporary_EMG_env(100*coeff_dilatation:end);
        temporary_EMG_no_env = subjects_struct.S_3.FLOAT.T_01.Normalized.EMG.noenvelope.(muscles{muscle});
        subjects_struct.S_3.FLOAT.T_01.Normalized.EMG.noenvelope.(muscles{muscle}) = temporary_EMG_no_env(100*coeff_dilatation:end);
    end
end
end















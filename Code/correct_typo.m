function [Healthy_subjects_19] = correct_typo(Healthy_subjects_19)
%This function changes the typo in Subject 1 trial 1 NO_FLOAT 2019 Healthy

Healthy_subjects_19.S_1.NO_FLOAT.T_01.Raw.Kin.LKNE = Healthy_subjects_19.S_1.NO_FLOAT.T_01.Raw.Kin.LKNEE;
Healthy_subjects_19.S_1.NO_FLOAT.T_01.Raw.Kin.RKNE = Healthy_subjects_19.S_1.NO_FLOAT.T_01.Raw.Kin.RKNEE;
Healthy_subjects_19.S_1.NO_FLOAT.T_01.Raw.Kin.LKNEE = [];
Healthy_subjects_19.S_1.NO_FLOAT.T_01.Raw.Kin.RKNEE = [];
end


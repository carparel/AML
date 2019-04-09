function [SCI_subjects] = detect_gait_events_SCI(SCI_subjects,csv_files_NO_FLOAT_CRUTCHES,csv_files_FLOAT_NO_CRUTCHES,fs_Kin,fs_EMG)
% This function is used in order to make a whole structure of events, for
% each case (FLOAT,NO FLOAT) and each trial. Though, it is needed to have a
% structure for the right leg and a structure for the left leg.
%
% INPUT : - SCI_subjects = the structure containing all the data concerning
%                          the SCI subjects.
%         - fs_Kin = the sampling frequency for the kinetic markers.
%         - fs_EMG = the sampling frequency for the EMG markers.
%
% OUPUT : - SCI_subjects = the updated Healthy_subjects with the detected
%                          events.
%
% DESCRIPTION TO BE CHANGED

conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
legs = {'Right', 'Left'};

HS=[];
TO=[];

csv =[];

for condition = 1:length(conditions)
    
    if strcmp(conditions{condition},'NO_FLOAT')
        csv = csv_files_NO_FLOAT_CRUTCHES;
    elseif strcmp(conditions{condition},'FLOAT')
        csv = csv_files_FLOAT_NO_CRUTCHES;
    end
    
    for trial = 1:length(trials)
        
        % This Coefficient of Dilation is due to the fact that the amount
        % of time considered is the same, but the number of time points is
        % diminished (due to the filtering in frequencies). This  basically
        % means that each time index n the new matrix is divided by this "coefficient of dilation"
        
       
        
        for leg = 1:length(legs)
            
            
            time_points_for_HS = csv{1,trial}.Time_s_(strcmp(csv{1,trial}.Context,legs{leg}) & strcmp(csv{1,trial}.Name,'Foot Strike'));
            time_points_for_TO = csv{1,trial}.Time_s_(strcmp(csv{1,trial}.Context,legs{leg}) & strcmp(csv{1,trial}.Name,'Foot Off'));
            
            SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker = round(time_points_for_HS * fs_Kin);
            SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker = round(time_points_for_TO * fs_Kin);
            
            
            SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg = round(time_points_for_HS * fs_EMG);
            SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_emg = round(time_points_for_TO * fs_EMG);
        end
    end
end

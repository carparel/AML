function [SCI_subjects] = detect_gait_events_SCI(SCI_subjects,csv_files_NO_FLOAT_CRUTCHES,csv_files_FLOAT_NO_CRUTCHES,fs_marker,fs_emg)
%fs is the sampling frequency 
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
        
        coefficient_dilation_marker = length(SCI_subjects.(conditions{condition}).(trials{trial}).Raw.Kin.LTOE)/ ...
            length(SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.Kin.LTOE);
        
        
        coefficient_dilation_emg = length(SCI_subjects.(conditions{condition}).(trials{trial}).Raw.EMG.RMG)/ ...
            length(SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.EMG.envelope.RMG);
        
        
        for leg = 1:length(legs)
            
            
            time_points_for_HS = csv{1,trial}.Time_s_(strcmp(csv{1,trial}.Context,legs{leg}) & strcmp(csv{1,trial}.Name,'Foot Strike'));
            time_points_for_TO = csv{1,trial}.Time_s_(strcmp(csv{1,trial}.Context,legs{leg}) & strcmp(csv{1,trial}.Name,'Foot Off'));
            
            SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker = (time_points_for_HS / coefficient_dilation_marker) * fs_marker;
            SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker = (time_points_for_TO / coefficient_dilation_marker) * fs_marker;
            
            
            SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg = (time_points_for_HS / coefficient_dilation_emg) * fs_emg;
            SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_emg = (time_points_for_TO / coefficient_dilation_emg) * fs_emg;
        end
    end
end

function [SCI_subjects] = detect_gait_events_SCI(SCI_subjects,csv_files_NO_FLOAT_CRUTCHES,csv_files_FLOAT_NO_CRUTCHES,fs_Kin,fs_EMG)
% This function is used in order to make a whole structure of events, for
% each case (FLOAT,NO FLOAT) and each trial. Though, it is needed to have a
% structure for the right leg and a structure for the left leg.
%
% INPUT : - SCI_subjects = the structure containing all the data concerning
%                          the SCI subjects.
%         - csv_files_NO_FLOAT_CRUTCHES = .csv file containing the time
%                                         events for SCI subjects in the
%                                         condition NO_FLOAT.
%         - csv_files_FLOAT_NO_CRUTCHES = .csv file containing the time
%                                         events for SCI subjects in the
%                                         condition FLOAT.
%         - fs_Kin = the sampling frequency for the kinetic markers.
%         - fs_EMG = the sampling frequency for the EMG markers.
%
% OUTPUT : - SCI_subjects = the updated Healthy_subjects with the detected
%                          events.


conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
legs = {'Right', 'Left'};

% To initialize empty vectors for heel strike and toe off events
HS=[];
TO=[];

%To initialize empty vector to read the csv files
csv =[];

for condition = 1:length(conditions)
    
    % To take events from csv files
    if strcmp(conditions{condition},'NO_FLOAT')
        csv = csv_files_NO_FLOAT_CRUTCHES;
    elseif strcmp(conditions{condition},'FLOAT')
        csv = csv_files_FLOAT_NO_CRUTCHES;
    end
    
    for trial = 1:length(trials)
        
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

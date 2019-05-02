function [Healthy_subjects] = insert_ground_truth_events(Healthy_subjects,subject,year_events,freq_KIN,freq_EMG)
% This function inserts in the original structures the events found by
% visual inspection. 
%
% INPUT: - Healthy_subjects = original structure containing the data relted
%          healthy subjects for a specific year.
%        - subject = a string parameter. It indicated the number of the
%                    subject. Is should be something like 'S_4'.
%        - year_events = the structure containing the events detected by
%                        visual inspection for a specific year.
%        - freq_KIN = sampling frequency for the kin signals.
%        - freq_EMG = sampling frequency for the EMG signals.
%
% OUTPT: - Healthy_subjects = updated original structures.

conditions = {'FLOAT','NO_FLOAT'};
trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};

ratio_frequencies = freq_EMG/freq_KIN;

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        current = year_events.(subject).(conditions{condition}).(trials{trial}).Event;
        for leg = 1:length(legs)
            if strcmp(legs{leg},'Right')
                markers = {'RTOE','RANK'};
            else
                markers = {'LTOE','LANK'};
            end
            for marker = 1:length(markers)
                strike = current.(legs{leg}).(markers{marker}).STRIKE;
                off = current.(legs{leg}).(markers{marker}).OFF;
                
                if ((strcmp(markers{marker},'RANK') || strcmp(markers{marker},'LANK')))
                    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker = strike; % We put the events in the structure
                    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HO_marker = off; % We put the events in the structure
                    
                    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg = round(strike*ratio_frequencies);
                    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HO_emg = round(off*ratio_frequencies); 
                else
                    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TS_marker = strike;
                    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker = off; 
                    
                    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TS_emg = round(strike*ratio_frequencies); 
                    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_emg = round(off*ratio_frequencies);                   
                    
                end
                
            end
        end
    end
end


end


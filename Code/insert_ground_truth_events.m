function [Healthy_subjects] = insert_ground_truth_events(Healthy_subjects,subject,year_events,freq_KIN,freq_EMG)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

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


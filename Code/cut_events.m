function [Healthy_struct] = cut_events(Healthy_struct,year)
% This function cuts some of the event previously detected. It is important
% to take into account the same number of strike and off points in order to
% well detect the gait cycles and to easily extract the features after.
%
% INPUT: - Healthy_struct = structure containing the data about the healthy
%                           subjects.
%
% OUTPUT: -Healthy_struct = updated structure with the Healthy subjects.

trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
conditions = {'NO_FLOAT','FLOAT'};

if strcmp(year,'2018')
    nbr_subjects = 4;
else
    nbr_subjects = [1, 2, 3];
end


for s = nbr_subjects(1):nbr_subjects(end)
    for condition = 1:length(conditions)
        for trial = 1:length(trials)
            nbr_events_HS_left = length(Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.Left.HS_marker);
            nbr_events_HS_right = length(Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.Right.HS_marker);
            nbr_events_TO_right = length(Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.Right.TO_marker);
            nbr_events_TO_left = length(Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.Left.TO_marker);
            
            min_nbr_events = min([nbr_events_HS_right,nbr_events_HS_left,nbr_events_TO_right,nbr_events_TO_left]);
            
            for leg = 1:length(legs)
                
                                
                Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker = Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker(1:min_nbr_events);
                Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker = Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker(1:min_nbr_events);
                
                Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg = Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg(1:min_nbr_events);
                Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_emg = Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_emg(1:min_nbr_events);
             
         
            
                heel_strikes = Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker;
                toe_offs = Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker;
                heel_strikes_emg = Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg;
                toe_offs_emg = Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_emg;
                
                if heel_strikes(1) > toe_offs(1)
                    Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker = heel_strikes(1:length(toe_offs)-1);
                    Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg = heel_strikes_emg(1:length(toe_offs)-1);
                    Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker = toe_offs(2:end);
                    Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_emg = toe_offs_emg(2:end);
                end
                
            end
        end
    end
end

end


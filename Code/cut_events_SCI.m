function [SCI_struct] = cut_events_SCI(SCI_struct)
% This function cuts some of the event previously detected. It is important
% to take into account the same number of strike and off points in order to
% well detect the gait cycles and to easily extract the features after.
% Also, we want to be sure to aleways have the heel strike as first event
% and not the toe off. So also this was checked and solved if necessary.
%
% INPUT: - SCI_struct = structure containing the data about the SCI subjects.
%
% OUTPUT: - SCI_struct = updated original structure.

trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
conditions = {'NO_FLOAT','FLOAT'};

for condition = 1:length(conditions)
    
    for trial = 1:length(trials)
        
        nbr_events_HS_right = length(SCI_struct.(conditions{condition}).(trials{trial}).Event.Right.HS_marker);
        nbr_events_HS_left = length(SCI_struct.(conditions{condition}).(trials{trial}).Event.Left.HS_marker);
        nbr_events_TO_right = length(SCI_struct.(conditions{condition}).(trials{trial}).Event.Right.TO_marker);
        nbr_events_TO_left = length(SCI_struct.(conditions{condition}).(trials{trial}).Event.Left.TO_marker);
        % Taking the minimum number of events between right and left leg
        min_nbr_events = min([nbr_events_HS_right,nbr_events_HS_left,nbr_events_TO_right,nbr_events_TO_left]);
        for leg = 1:length(legs)

            % Cutting events for the Kin signals
            SCI_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker = SCI_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker(1:min_nbr_events);
            SCI_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker = SCI_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker(1:min_nbr_events);
            
            % Cutting events for the EMG signals
            SCI_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg = SCI_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg(1:min_nbr_events);
            SCI_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_emg = SCI_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_emg(1:min_nbr_events);
            
            % Checking that we start with and heel strike and not a toe
            % off, if not the case we solve the problem
            heel_strikes = SCI_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker;
            toe_offs = SCI_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker;
            
            if heel_strikes(1) > toe_offs(1)
                SCI_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker = heel_strikes(1:length(toe_offs)-1);
                SCI_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker = toe_offs(2:end);
            end
            
        end
    end
end
end


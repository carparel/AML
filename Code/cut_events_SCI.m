function [SCI_struct] = cut_events_SCI(SCI_struct)
% This function cuts some of the event previously detected. It is important
% to take into account the same number of strike and off points in order to
% well detect the gait cycles and to easily extract the features after.
%
% INPUT: - SCI_struct = structure containing the data about the SCI
%                           subjects.
%
% OUTPUT: -SCI_struct = updated structure with the SCI subjects.
trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
conditions = {'NO_FLOAT','FLOAT'}; 
for condition = 1:length(conditions)
    for trial = 1:length(trials)
        for leg = 1:length(legs)
            
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


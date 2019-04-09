function [Healthy_struct] = cut_events(Healthy_struct)
%UNTITLED2 Summary of this function goes here
 % We check if the first index we have is a off or a strike
 

trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
conditions = {'NO_FLOAT','FLOAT'}; 
nbr_subjects = 4;

for s = 4:nbr_subjects
for condition = 1:length(conditions)
    for trial = 1:length(trials)
        for leg = 1:length(legs)
            
            heel_strikes = Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker;
            toe_offs = Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker;

            if heel_strikes(1) > toe_offs(1)
                Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker = heel_strikes(1:length(toe_offs)-1);
                Healthy_struct.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker = toe_offs(2:end);
            end  
            
        end
    end
end
end

end


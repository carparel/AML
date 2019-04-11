function [temp_feat_table] = extract_temp_features_Healthy(Healthy_struct,fsKin)
% BLABLA

trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
conditions = {'NO_FLOAT','FLOAT'};

% To initialize the vector in which we are going to stock our
% features/variables
cond_H = [];
cond_NO_F  = [];

gait_cycle_duration = [];
cadence = [];
stance_duration_right = [];
stance_duration_left = [];

swing_duration_right = [];
swing_duration_left = [];
double_stance_duration = [];

for condition = 1:length(conditions)
    
    for trial = 1:length(trials)
        
        nbr_events_HS_right = length(Healthy_struct.(conditions{condition}).(trials{trial}).Event.Right.HS_marker);
        nbr_events_HS_left = length(Healthy_struct.(conditions{condition}).(trials{trial}).Event.Left.HS_marker);
        nbr_events_TO_right = length(Healthy_struct.(conditions{condition}).(trials{trial}).Event.Right.TO_marker);
        nbr_events_TO_left = length(Healthy_struct.(conditions{condition}).(trials{trial}).Event.Left.TO_marker);
        min_nbr_events = min([nbr_events_HS_right,nbr_events_HS_left,nbr_events_TO_right,nbr_events_TO_left]);
        
        for leg = 1:length(legs) 
            
            heel_strikes = Healthy_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker;
            toe_offs = Healthy_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker;
            
            for gait = 1:min_nbr_events-1
                
                % This is if is used just to stock once and not twice the
                % gait duration and the "labels" of the gait. 
                if strcmp(legs{leg},'Right')
                    duration_idx = heel_strikes(gait+1)-heel_strikes(gait);
                    duration = duration_idx / fsKin;
                    cadence_unit = 120/duration;
                    
                    gait_cycle_duration = [gait_cycle_duration duration];
                    cadence = [cadence cadence_unit];
                    
                    
                    if(strcmp(conditions{condition},'NO_FLOAT'))
                        cond_H = [cond_H 0];
                        cond_NO_F = [cond_NO_F 1];
                    else
                        cond_H = [cond_H 0];
                        cond_NO_F = [cond_NO_F 0];
                    end
                end
                                
                duration_stance_idx = abs(toe_offs(gait)-heel_strikes(gait));
                duration_swing_idx = abs(heel_strikes(gait+1)-toe_offs(gait));
                
                duration_stance = duration_stance_idx/ fsKin;
                duration_swing = duration_swing_idx / fsKin;
                
                
                if strcmp(legs{leg},'Right')
                    stance_duration_right = [stance_duration_right duration_stance];
                    swing_duration_right = [swing_duration_right duration_swing];
                else
                    stance_duration_left = [stance_duration_left duration_stance];
                    swing_duration_left = [swing_duration_left duration_swing];
                end
                
                
            end
        end
        
            % Let's see which is the first heel strike, if right or left
            heel_s = zeros(length(legs),min_nbr_events);
            toe_o = zeros(length(legs),min_nbr_events);
            
            for leg = 1:length(legs)
                    heel_s(leg,:) = Healthy_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker(1:min_nbr_events)';
                    toe_o(leg,:) = Healthy_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker(1:min_nbr_events)';
            end
            
            if heel_s(1,1) < heel_s(2,1)
                for gait = 1:min_nbr_events-1
                    if mod(gait,2) == 1
                        duration_idx(gait) = toe_o(1,gait)-heel_s(2,gait);
                    elseif mod(gait,2) == 0
                        duration_idx(gait) = toe_o(2,gait-1)-heel_s(1,gait);
                    end
                    duration= duration_idx / fsKin;
                end
                double_stance_duration = [double_stance_duration duration];
                
            elseif heel_s(2,1) < heel_s(1,1)
                for gait = 1:min_nbr_events-1
                    if mod(gait,2) == 1
                        duration_idx(gait) = toe_o(2,gait)-heel_s(1,gait);
                    elseif mod(gait,2) == 0
                        duration_idx(gait) = toe_o(1,gait-1)-heel_s(2,gait);
                    end
                    duration = duration_idx / fsKin;
                end
                double_stance_duration = [double_stance_duration duration];
            end
    end
end

names = {'Condition_Healthy','Condition_NO_Float','gait_cycle_duration','cadence','stance_duration_right','swing_duration_right','stance_duration_left','swing_duration_left','double_stance_duration'};
temp_feat_table = table(cond_H',cond_NO_F',gait_cycle_duration',cadence',stance_duration_right',swing_duration_right',stance_duration_left',swing_duration_left',double_stance_duration','VariableNames',names);
end


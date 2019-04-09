function [temp_feat_table] = extract_temp_features_Healthy(Healthy_struct,fsKin)
% BLABLA

trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
conditions = {'NO_FLOAT','FLOAT'};

% To initialize the vector in which we are going to stock our
% features/variables
cond_ = [];

gait_cycle_duration = [];

stance_duration_right = [];
stance_duration_left = [];

swing_duration_right = [];
swing_duration_left = [];

for condition = 1:length(conditions)
    
    for trial = 1:length(trials)
        
        nbr_events_right = length(Healthy_struct.(conditions{condition}).(trials{trial}).Event.Right.HS_marker);
        nbr_events_left = length(Healthy_struct.(conditions{condition}).(trials{trial}).Event.Left.HS_marker);
        
        min_nbr_events = min([nbr_events_right,nbr_events_left]);
        
        for leg = 1:length(legs) % To consider the gait cycle duration we just need one leg (from HS to HS)
            
            heel_strikes = Healthy_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker;
            toe_offs = Healthy_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker;
            
            for gait = 1:min_nbr_events-1
                
                % This is if is used just to stock once and not twicethe
                % gait duration and the "labels" of the gait. 
                if strcmp(legs{leg},'Right')
                    duration_idx = heel_strikes(gait+1)-heel_strikes(gait);
                    duration = duration_idx / fsKin;
                    gait_cycle_duration = [gait_cycle_duration duration];
                    
                    if strcmp(conditions{condition},'NO_FLOAT')
                        cond_ = [cond_ 11];
                    else
                        cond_ = [cond_ 10];
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
    end
end

names = {'Condition','gait_cycle_duration','stance_duration_right','swing_duration_right','stance_duration_left','swing_duration_left'};
temp_feat_table = table(cond_',gait_cycle_duration',stance_duration_right',swing_duration_right',stance_duration_left',swing_duration_left','VariableNames',names);
end


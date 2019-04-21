function [speed_feat_table] = extract_speed_feature(struct,stride_length,gait_cycle_duration,type)
% This functions calculate the speed feature
%
% INPUT: - stride_length  
%        - gait_cycle_duration 
%        - type = a string parameter. It is either 'SCI' or 'Healthy'.
%
% OUTPUT: - speed_feat_table = the resulting matrix containing all the
%                              speed features for all samples (all gait
%                              cycles).

trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
conditions = {'NO_FLOAT','FLOAT'};

% To initialize the vectors in which we are going to stock our labels 
cond_H = []; % Is 1 if subject Healthy and is 0 if SCI
cond_NO_F = [];% Is 1 if NO_FLOAT and is 0 if FLOAT

for condition = 1:length(conditions)
    
    for trial = 1:length(trials)
        
        nbr_events = length(struct.(conditions{condition}).(trials{trial}).Event.Right.HS_marker);
        
        
        for leg = 1:length(legs)
            
            
            for gait = 1:nbr_events-1
                if strcmp(legs{leg},'Right')
                    
                   
                    if strcmp(type,'Healthy')
                        if strcmp(conditions{condition},'NO_FLOAT')
                            cond_H = [cond_H 1];
                            cond_NO_F = [cond_NO_F 1];
                        else
                            cond_H = [cond_H 1];
                            cond_NO_F = [cond_NO_F 0];
                        end
                    elseif strcmp(type,'SCI')
                        if strcmp(conditions{condition},'NO_FLOAT')
                            cond_H = [cond_H 0];
                            cond_NO_F = [cond_NO_F 1];
                        else
                            cond_H = [cond_H 0];
                            cond_NO_F = [cond_NO_F 0];
                        end
                    end
                end
            end
        end
    end
end


speed = stride_length./gait_cycle_duration;


names = {'Condition_Healthy','Condition_NO_Float','speed'};
speed_feat_table = table(cond_H',cond_NO_F',speed','VariableNames',names);
end


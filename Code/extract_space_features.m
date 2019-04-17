function [space_feat_table] = extract_space_features(struct,type)
% This functions extracts the spatial features from the data.
%
% INPUT: - struct = Structure containing all the data.
%        - type = a string parameter. It is either 'SCI' or 'Healthy'.
%
% OUTPUT: - space_feat_table = the resulting matrix containing all the
%                              spatial features for all samples (all gait
%                              cycles).

trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
conditions = {'NO_FLOAT','FLOAT'};

% To initialize the vectors in which we are going to stock our labels 
cond_H = []; % Is 1 if subject Healthy and is 0 if SCI
cond_NO_F = [];% Is 1 if NO_FLOAT and is 0 if FLOAT

% To initialize the vector in which we are going to stock our
% features/variables
stride_length_right = [];
stride_length_left = [];
swing_length_right = [];
swing_length_left = [];
step_length_right = [];
step_length_left = [];
step_width = [];
max_heel_clearance_right = [];
max_heel_clearance_left = [];

max_knee_clearance_right = [];
max_knee_clearance_left = [];

max_toe_clearance_right = [];
max_toe_clearance_left = [];

for condition = 1:length(conditions)
    
    for trial = 1:length(trials)
        
        min_nbr_events = length(struct.(conditions{condition}).(trials{trial}).Event.Right.HS_marker);
        
        rank_y = struct.(conditions{condition}).(trials{trial}).Filtered.Kin.RANK(:,2);
        lank_y = struct.(conditions{condition}).(trials{trial}).Filtered.Kin.LANK(:,2);
        rank_x = struct.(conditions{condition}).(trials{trial}).Filtered.Kin.RANK(:,1);
        lank_x = struct.(conditions{condition}).(trials{trial}).Filtered.Kin.LANK(:,1);
        rank_z = struct.(conditions{condition}).(trials{trial}).Filtered.Kin.RANK(:,3);
        lank_z = struct.(conditions{condition}).(trials{trial}).Filtered.Kin.LANK(:,3);
        
        rkne_z = struct.(conditions{condition}).(trials{trial}).Filtered.Kin.RKNE(:,3);
        lkne_z = struct.(conditions{condition}).(trials{trial}).Filtered.Kin.LKNE(:,3);
        
        rtoe_z = struct.(conditions{condition}).(trials{trial}).Filtered.Kin.RTOE(:,3);
        ltoe_z = struct.(conditions{condition}).(trials{trial}).Filtered.Kin.LTOE(:,3);
        
        for leg = 1:length(legs)
            
            heel_strikes = struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker;
            toe_offs = struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker;
            
            for gait = 1:min_nbr_events-1
                if strcmp(legs{leg},'Right')
                    marker = 'RANK';
                    
                    % Stride length is the distance between HS of the same foot
                    
                    current = struct.(conditions{condition}).(trials{trial}).Filtered.Kin.(marker);
                    length_space_stride = abs(current(heel_strikes(gait+1),2)-current(heel_strikes(gait),2))/1000;
                    stride_length_right = [stride_length_right length_space_stride];
                    length_space_swing = abs(current(heel_strikes(gait+1),2)-current(toe_offs(gait),2))/10;
                    swing_length_right = [swing_length_right length_space_swing];
                    
                    height_heel_right = max(rank_z(heel_strikes(gait):heel_strikes(gait+1)))/10;
                    max_heel_clearance_right = [max_heel_clearance_right height_heel_right];
                    
                    height_knee_right = max(rkne_z(heel_strikes(gait):heel_strikes(gait+1)))/10;
                    max_knee_clearance_right = [max_knee_clearance_right height_knee_right];
                    
                    height_toe_right = max(rtoe_z(heel_strikes(gait):heel_strikes(gait+1)))/10;
                    max_toe_clearance_right = [max_toe_clearance_right height_toe_right];
                    
                    % In order not to double the conditions
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
                                
                    
                elseif strcmp(legs{leg},'Left')
                    marker = 'LANK';
                    current = struct.(conditions{condition}).(trials{trial}).Filtered.Kin.(marker);
                    length_space_stride = abs(current(heel_strikes(gait+1),2)-current(heel_strikes(gait),2))/1000;
                    stride_length_left = [stride_length_left length_space_stride];
                    length_space_swing = abs(current(heel_strikes(gait+1),2)-current(toe_offs(gait),2))/10;
                    swing_length_left = [swing_length_left length_space_swing];
                    
                    height_heel_left = max(lank_z(heel_strikes(gait):heel_strikes(gait+1)))/10;
                    max_heel_clearance_left = [max_heel_clearance_left height_heel_left];
                    
                    height_knee_left = max(lkne_z(heel_strikes(gait):heel_strikes(gait+1)))/10;
                    max_knee_clearance_left = [max_knee_clearance_left height_knee_left];
                    
                    height_toe_left = max(ltoe_z(heel_strikes(gait):heel_strikes(gait+1)))/10;
                    max_toe_clearance_left = [max_toe_clearance_left height_toe_left];
                    
                end
            end
        end
        
        
        % To compute the step length I need the hill strikes of both feet
        % to be stored
        
        
        heel_s = zeros(length(legs),min_nbr_events);
        for leg = 1:length(legs)
            heel_s(leg,:) = struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker(1:min_nbr_events)';
        end
        
        
        if heel_s(1,1) < heel_s(2,1)
            for gait = 1:min_nbr_events-1
                length_step_left = abs(lank_y(heel_s(2,gait))-rank_y(heel_s(1,gait)))/10;
                length_step_right = abs(rank_y(heel_s(1,gait+1))-lank_y(heel_s(2,gait)))/10;
                step_length_left = [step_length_left length_step_left];
                step_length_right = [step_length_right length_step_right];
                width = abs(lank_x(heel_s(2,gait))-rank_x(heel_s(1,gait)))/10;
                step_width = [step_width width];
            end
            
        elseif heel_s(2,1) < heel_s(1,1)
            for gait = 1:min_nbr_events-1
                length_step_right = abs(rank_y(heel_s(1,gait))-lank_y(heel_s(2,gait)))/10;
                length_step_left = abs(lank_y(heel_s(2,gait+1))-rank_y(heel_s(1,gait)))/10;
                step_length_left = [step_length_left length_step_left];
                step_length_right = [step_length_right length_step_right];
                width = abs(rank_x(heel_s(1,gait))-lank_x(heel_s(2,gait)))/10;
                step_width = [step_width width];
            end
            
        end
    end
end

names = {'Condition_Healthy','Condition_NO_Float','stride_length_right_m','stride_length_left_m','swing_length_right_cm','swing_length_left_cm','step_length_right_cm','step_length_left_cm','step_width_cm','max_heel_clearance_right','max_heel_clearance_left','max_knee_clearance_right','max_knee_clearance_left','max_toe_clearance_right','max_toe_clearance_left'};
space_feat_table = table(cond_H',cond_NO_F',stride_length_right',stride_length_left',swing_length_right',swing_length_left',step_length_right',step_length_left',step_width',max_heel_clearance_right',max_heel_clearance_left',max_knee_clearance_right',max_knee_clearance_left',max_toe_clearance_right',max_toe_clearance_left','VariableNames',names);

end
% Step length is the distance between the heel strike of one foot and the heel strike of the opposite foot




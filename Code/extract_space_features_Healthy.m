function [space_feat_table] = extract_space_features_Healthy(Healthy_struct)

% BLABLABLA

trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
conditions = {'NO_FLOAT','FLOAT'};

% To initialize the vector in which we are going to stock our
% features/variables
cond_ = [];
%Let's start with this ones..
stride_length_right = [];
stride_length_left = [];
swing_length_right = [];
swing_length_left = [];
step_length_right = [];
step_length_left = [];
step_width = [];

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
                if strcmp(legs{leg},'Right')
                    marker = 'RANK';
                    % Stride length is the distance between HS of the same foot
                    current = Healthy_struct.(conditions{condition}).(trials{trial}).Filtered.Kin.(marker);
                    length_space_stride = abs(current(heel_strikes(gait+1),2)-current(heel_strikes(gait),2))/1000;
                    stride_length_right = [stride_length_right length_space_stride];
                    length_space_swing = abs(current(heel_strikes(gait+1),2)-current(toe_offs(gait),2))/10;
                    swing_length_right = [swing_length_right length_space_swing];
                    % In order not to double the conditions
                    if strcmp(conditions{condition},'NO_FLOAT')
                        cond_ = [cond_ 11];
                    else
                        cond_ = [cond_ 10];
                    end
                    
                elseif strcmp(legs{leg},'Left')
                    marker = 'LANK';
                    current = Healthy_struct.(conditions{condition}).(trials{trial}).Filtered.Kin.(marker);
                    length_space_stride = abs(current(heel_strikes(gait+1),2)-current(heel_strikes(gait),2))/1000;
                    stride_length_left = [stride_length_left length_space_stride];
                    length_space_swing = abs(current(heel_strikes(gait+1),2)-current(toe_offs(gait),2))/10;
                    % I don't super like these swings...but that's how it
                    % is
                    swing_length_left = [swing_length_left length_space_swing];
                end
            end
        end
        
        
        % To compute the step length I need the hill strikes of both feet
        % to be stored
        
        rank_y = Healthy_struct.(conditions{condition}).(trials{trial}).Filtered.Kin.RANK(:,2);
        lank_y = Healthy_struct.(conditions{condition}).(trials{trial}).Filtered.Kin.LANK(:,2);
        rank_x = Healthy_struct.(conditions{condition}).(trials{trial}).Filtered.Kin.RANK(:,1);
        lank_x = Healthy_struct.(conditions{condition}).(trials{trial}).Filtered.Kin.RANK(:,1);
        
        heel_s = zeros(length(legs),min_nbr_events);
        for leg = 1:length(legs)
            heel_s(leg,:) = Healthy_struct.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker(1:min_nbr_events)';
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

names = {'Condition','stride_length_right_m','stride_length_left_m','swing_length_right_cm','swing_length_left_cm','step_length_right_cm','step_length_left_cm','step_width_cm'};
space_feat_table = table(cond_',stride_length_right',stride_length_left',swing_length_right',swing_length_left',step_length_right',step_length_left',step_width','VariableNames',names);
end
% Step length is the distance between the heel strike of one foot and the heel strike of the opposite foot




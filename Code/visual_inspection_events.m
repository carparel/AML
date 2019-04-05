function [] = visual_inspection_events(subjects_struct,subject)
% BLABLABLA

conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        current_trial = subjects_struct.(subject).(conditions{condition}).(trials{trial}).Filtered.Kin;
        
        % Markers left leg:
        LHIP = current_trial.LHIP;
        LKNE = current_trial.LKNE;
        LANK = current_trial.LANK;
        LTOE = current_trial.LTOE;
        
        left_leg_X(1,:) = LHIP(:,1);
        left_leg_X(2,:) = LKNE(:,1);
        left_leg_X(3,:) = LANK(:,1);
        left_leg_X(4,:) = LTOE(:,1);
        
        left_leg_Y(1,:) = LHIP(:,2);
        left_leg_Y(2,:) = LKNE(:,2);
        left_leg_Y(3,:) = LANK(:,2);
        left_leg_Y(4,:) = LTOE(:,2);
        
        left_leg_Z(1,:) = LHIP(:,3);
        left_leg_Z(2,:) = LKNE(:,3);
        left_leg_Z(3,:) = LANK(:,3);
        left_leg_Z(4,:) = LTOE(:,3);
        
        
        % Markers right leg:
        RHIP = current_trial.RHIP;
        RKNE = current_trial.RKNE;
        RANK = current_trial.RANK;
        RTOE = current_trial.RTOE;
        
        right_leg_X(1,:) = RHIP(:,1);
        right_leg_X(2,:) = RKNE(:,1);
        right_leg_X(3,:) = RANK(:,1);
        right_leg_X(4,:) = RTOE(:,1);
       
        right_leg_Y(1,:) = RHIP(:,2);
        right_leg_Y(2,:) = RKNE(:,2);
        right_leg_Y(3,:) = RANK(:,2);
        right_leg_Y(4,:) = RTOE(:,2);
        
        right_leg_Z(1,:) = RHIP(:,3);
        right_leg_Z(2,:) = RKNE(:,3);
        right_leg_Z(3,:) = RANK(:,3);
        right_leg_Z(4,:) = RTOE(:,3);
        
        figure()
        for t = 1:length(LHIP)
            clf;
            scatter3(left_leg_X(:,t),left_leg_Y(:,t),left_leg_Z(:,t));
            hold on;
            scatter3(right_leg_X(:,t),right_leg_Y(:,t),right_leg_Z(:,t));
            plot3(left_leg_X(:,t),left_leg_Y(:,t),left_leg_Z(:,t),'-bx','LineWidth',1.2);
            plot3(right_leg_X(:,t),right_leg_Y(:,t),right_leg_Z(:,t),'-rx','LineWidth',1.2);
            title(['Time = ', num2str(t/100)])
            drawnow
            pause(0.05);
        end
    end
end
end


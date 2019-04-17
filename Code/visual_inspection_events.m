function [] = visual_inspection_events(subjects_struct,subject,condition,trial)
% This function plots the kin signals in a ZY space for all time points, in
% order to see a sort of projection of the dynamics on this plane. 

% INPUT: - subjects_struct = structure containing all the data related to the
%                            Healthy subjects 
%        - subject = a string parameter representing the specific subject
%                    to consider. It should be something like 'S_4'.
%        - condition = the condition for the subject, either FLOAT or
%                      NO_FLOAT.
%        - trial = a string parameter. It corresponds to the number of the
%                  specific trial, like 'T_01'.
%        

current_trial = subjects_struct.(subject).(condition).(trial).Filtered.Kin;

% Markers left leg:
LHIP = current_trial.LHIP;
LKNE = current_trial.LKNE;
LANK = current_trial.LANK;
LTOE = current_trial.LTOE;

left_leg_X = zeros(4,length(LHIP));
left_leg_Y = zeros(4,length(LHIP));
left_leg_Z = zeros(4,length(LHIP));

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

right_leg_X = zeros(4,length(LHIP));
right_leg_Y = zeros(4,length(LHIP));
right_leg_Z = zeros(4,length(LHIP));

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

nbr_time_points = length(LHIP);

%% The 3D video

% figure()
% for t = 1:nbr_time_points
%     clf;
%     scatter3(left_leg_X(:,t),left_leg_Y(:,t),left_leg_Z(:,t));
%     hold on;
%     scatter3(right_leg_X(:,t),right_leg_Y(:,t),right_leg_Z(:,t));
%     plot3(left_leg_X(:,t),left_leg_Y(:,t),left_leg_Z(:,t),'-b','LineWidth',1.2);
%     plot3(right_leg_X(:,t),right_leg_Y(:,t),right_leg_Z(:,t),'-r','LineWidth',1.2);
%     title(['Time = ', num2str(t/100), ' [s]'])
%     legend('Markers left','Markers right','Left leg','Right leg');
%     drawnow
%     %pause(0.05);
% end

%% The 2D corresponding plot

h = figure();
% We take out around 100 points because there is some noise at the end? 
subplot(2,1,1)
for t = 1:2:nbr_time_points-100
    scatter(left_leg_Y(3,t),left_leg_Z(3,t),'ro');
    scatter(left_leg_Y(4,t),left_leg_Z(4,t),'bo');
    scatter(left_leg_Y(1:2,t),left_leg_Z(1:2,t),'ko');
    plot(left_leg_Y(:,t),left_leg_Z(:,t),'k-','LineWidth',1.2);
    hold on;
end
xlabel('Y coordinate (the direction of movement)','FontSize',15);
ylabel('Z coordinate (height of the foot)','FontSize',15);
title('Left leg','FontSize',15);
legend('','Ankle','Toe');
subplot(2,1,2)
for t = 1:2:nbr_time_points-100
    scatter(right_leg_Y(3,t),right_leg_Z(3,t),'ro');
    scatter(right_leg_Y(4,t),right_leg_Z(4,t),'bo');
    scatter(right_leg_Y(1:2,t),right_leg_Z(1:2,t),'ko');
    plot(right_leg_Y(:,t),right_leg_Z(:,t),'k-','LineWidth',1.2);
    hold on;
end
xlabel('Y coordinate (the direction of movement)','FontSize',15);
ylabel('Z coordinate (height of the foot)','FontSize',15);
title('Right leg','FontSize',15);
legend('','Ankle','Toe');
set(h,'Position',[0 0 1920 820]);

end


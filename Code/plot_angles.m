function [] = plot_angles(Healthy_subjects,SCI_subjects)

% This function subplots the left FE hip, knee and ankle angles averaged over all
% trials and gaits for one healthy (S_4) and one SCI subject, in the NO_FLOAT condition. 
% 
% INPUT: -Healthy_subjects: struct containing data of the healthy subjects
%        -SCI_subjects: struct containing data of the SCI subjects
% 
% OUTPUT: \\

    trials = {'T_01','T_02','T_03'};
    markers_healthy = {'LHIP','LKNE','LTOE','LANK'};
    markers_SCI = {'LASI','LKNE','LTOE','LANK'};

    %% Healthy subject n4

    % this is to find the shortest gait cycle
    for trial = 1:length(trials)
        
        current = Healthy_subjects.S_4.NO_FLOAT.(trials{trial}).Parsed;
        
        for gait = 1:length(current)
            matrix(trial,gait) = length(current{1,gait}.Left.Kin.(markers_healthy{2}));
        end
        
    end
    
    minimum_length = min(min(matrix(matrix>0)));

    
    for trial = 1:length(trials) 
        
            current = Healthy_subjects.S_4.NO_FLOAT.(trials{trial}).Parsed;
            
           % this adapts all the gait cycles to the shortest one 
           for gait=1:length(current)
                
                for marker = 1:length(markers_healthy)
                    
                    current{1,gait}.Left.Kin.(markers_healthy{marker}) = resample(current{1,gait}. ...
                     Left.Kin.(markers_healthy{marker}),minimum_length,...
                     length(current{1,gait}.Left.Kin.(markers_healthy{marker})),0);
                end
                
            end
       
            for gait = 1:length(current)
                    
                    % Hip
                    % Flexion Extension
                 
                    % defining the segment vector
                    vec_hip_knee = current{1,gait}.Left.Kin.(markers_healthy{2}) - current{1,gait}.Left.Kin.(markers_healthy{1});
                   
                    % Since I want the angle only in the YZ plane, we set
                    % their x coordinate to zero (equivalent to projecting
                    % them) for each time instant                    
                    
                    vec_hip_knee = [zeros(length(vec_hip_knee),1) vec_hip_knee(:,2:3)];   
                    vec_n = [0,0,-1]; % This is the vertical axis with respect to we will evaluate the angles
                    
                    for i = 1:length(vec_hip_knee(:,1))
                        
                         % angle btw two vectors for each time instant
                        angle_FE_hip(i) = acosd(dot(vec_hip_knee(i,:),vec_n)/(norm(vec_hip_knee(i,:))*norm(vec_n)));
                    
                    end   
                    
                    % stocking
                    angle_FE_hip_gait(gait,:) =  angle_FE_hip;
                    
                    % Knee
                    % Flexion Extension
                    
                    % defining the segment vector  
                    vec_knee_ankle = current{1,gait}.Left.Kin.(markers_healthy{4}) - current{1,gait}.Left.Kin.(markers_healthy{2});                    
                    
                    % Since I want the angle only in the YZ plane, we set
                    % their x coordinate to zero (equivalent to projecting
                    % them) for each time instant
                    
                    vec_knee_ankle = [zeros(length(vec_knee_ankle),1) vec_knee_ankle(:,2:3)];
                    
                    for i = 1:length(vec_hip_knee(:,1))
                        
                        % angle btw two vectors for each time instant
                        angle_FE_knee(i) = acosd(dot(vec_hip_knee(i,:),vec_knee_ankle(i,:))/(norm(vec_hip_knee(i,:))*(norm(vec_knee_ankle(i,:)))));
                    
                    end
                    
                    % stocking      
                    angle_FE_knee_gait(gait,:) = angle_FE_knee;
                    
                    % Foot
                    % Flexion Extension
                   
                    % defining the segment vector
                    vec_ankle_toe = current{1,gait}.Left.Kin.(markers_healthy{3}) - current{1,gait}.Left.Kin.(markers_healthy{4});
                    
                    % Since I want the angle only in the YZ plane, we set
                    % their x coordinate to zero (equivalent to projecting
                    % them) for each time instant
                    vec_ankle_toe = [zeros(length(vec_ankle_toe),1) vec_ankle_toe(:,2:3)];
                    
                    for i = 1:length(vec_ankle_toe(:,1))
                        
                        % angle btw two vectors for each time instant
                        angle_FE_ankle(i) = 90 - acosd(dot(vec_ankle_toe(i,:),vec_knee_ankle(i,:))/(norm(vec_ankle_toe(i,:))*(norm(vec_knee_ankle(i,:)))));
                    
                    end
                    
                    % stocking
                    angle_FE_ankle_gait(gait,:) = angle_FE_ankle;
        
            end 
                
            angle_FE_hip_trial(trial,:) = mean(angle_FE_hip_gait);
            angle_FE_knee_trial(trial,:) = mean(angle_FE_knee_gait);
            angle_FE_ankle_trial(trial,:) = mean(angle_FE_ankle_gait);
            
                    
    end 
    
    % the plotted angle is the mean over trials and gaits
    angle_FE_hip_subj =  mean(angle_FE_hip_trial);
    angle_FE_knee_subj =  mean(angle_FE_knee_trial);
    angle_FE_ankle_subj =  mean(angle_FE_ankle_trial);


    %% SCI subject
    
    % initializing all the variables to zero to deal with dimensions
    % mismatch
    vec_hip_knee = 0;
    vec_knee_ankle = 0;
    vec_ankle_toe = 0;
    current = 0;
    matrix = 0;

    % this is to find the shortest gait cycle

    for trial = 1:length(trials)
        
        current = SCI_subjects.NO_FLOAT.(trials{trial}).Parsed;
        for gait = 1:length(current)
            
            matrix(trial,gait) = length(current{1,gait}.Left.Kin.(markers_SCI{2}));
        
        end
        
    end
    
    minimum_length = min(min(matrix(matrix>0)));
    

    for trial = 1:length(trials)
        
            current = SCI_subjects.NO_FLOAT.(trials{trial}).Parsed;
            
            % this adapts all the gait cycles to the shortest one 

            for gait=1:length(current)
                
                for marker = 1:length(markers_SCI)
                    
                    current{1,gait}.Left.Kin.(markers_SCI{marker}) = resample(current{1,gait}. ...
                     Left.Kin.(markers_SCI{marker}),minimum_length,...
                     length(current{1,gait}.Left.Kin.(markers_SCI{marker})),0);
                
                end
                
            end
            
            for gait = 1:length(current)
                % Hip
                % Flexion Extension

                % defining the segment vector
                vec_hip_knee = current{1,gait}.Left.Kin.(markers_SCI{2}) - current{1,gait}.Left.Kin.(markers_SCI{1});

                % Since I want the angle only in the YZ plane, we set
                % their x coordinate to zero (equivalent to projecting
                % them) for each time instant                    

                vec_hip_knee = [zeros(length(vec_hip_knee),1) vec_hip_knee(:,2:3)];                    
                vec_n = [0,0,-1]; % This is the vertical axis with respect to we will evaluate the angles

                for i = 1:length(vec_hip_knee(:,1))
                     % angle btw two vectors for each time instant
                    angle_FE_hip_SCI(i) = acosd(dot(vec_hip_knee(i,:),vec_n)/(norm(vec_hip_knee(i,:))*norm(vec_n)));
                
                end                 
                
                % stocking
                for k = 1:length(angle_FE_hip_SCI(1,:))
                    
                    angle_FE_hip_gait_SCI(gait,k) =  angle_FE_hip_SCI(k);
                
                end

                % Knee
                % Flexion Extension

                % defining the segment vector                  
                vec_knee_ankle = current{1,gait}.Left.Kin.(markers_SCI{4}) - current{1,gait}.Left.Kin.(markers_SCI{2});                    

                % Since I want the angle only in the YZ plane, we set
                % their x coordinate to zero (equivalent to projecting
                % them) for each time instant

                vec_knee_ankle = [zeros(length(vec_knee_ankle),1) vec_knee_ankle(:,2:3)];

                for i = 1:length(vec_hip_knee(:,1))
                    % angle btw two vectors for each time instant
                    angle_FE_knee_SCI(i) = acosd(dot(vec_hip_knee(i,:),vec_knee_ankle(i,:))/(norm(vec_hip_knee(i,:))*(norm(vec_knee_ankle(i,:)))));
                end
                
                % stocking
                for k = 1:length(angle_FE_knee_SCI(1,:))

                    angle_FE_knee_gait_SCI(gait,k) =  angle_FE_knee_SCI(k);

                end

                % Foot
                % Flexion Extension

                % defining the segment vector
                vec_ankle_toe = current{1,gait}.Left.Kin.(markers_SCI{3}) - current{1,gait}.Left.Kin.(markers_SCI{4});

                % Since I want the angle only in the YZ plane, we set
                % their x coordinate to zero (equivalent to projecting
                % them) for each time instant
                vec_ankle_toe = [zeros(length(vec_ankle_toe),1) vec_ankle_toe(:,2:3)];

                for i = 1:length(vec_ankle_toe(:,1))

                    % angle btw two vectors for each time instant
                    angle_FE_ankle_SCI(i) = 90 - acosd(dot(vec_ankle_toe(i,:),vec_knee_ankle(i,:))/(norm(vec_ankle_toe(i,:))*(norm(vec_knee_ankle(i,:)))));

                end
                
                % stocking
                for k = 1:length(angle_FE_ankle_SCI(1,:))

                    angle_FE_ankle_gait_SCI(gait,k) =  angle_FE_ankle_SCI(k);

                end
            end
            
            angle_FE_hip_trial_SCI(trial,:) = mean(angle_FE_hip_gait_SCI);
            angle_FE_knee_trial_SCI(trial,:) = mean(angle_FE_knee_gait_SCI);
            angle_FE_ankle_trial_SCI(trial,:) = mean(angle_FE_ankle_gait_SCI);
                     
    end
    
    % the plotted angle is the mean over trials and gaits
    angle_FE_hip_subj_SCI =  mean(angle_FE_hip_trial_SCI);
    angle_FE_knee_subj_SCI =  mean(angle_FE_knee_trial_SCI);
    angle_FE_ankle_subj_SCI =  mean(angle_FE_ankle_trial_SCI);

  %% Plotting
  
  timepoints_1 = (1:1:length(angle_FE_hip_subj))/100;
  timepoints_2 = (1:1:length(angle_FE_hip_subj_SCI))/100;
      
  figure;
  subplot(2,1,1)
  plot(timepoints_1,angle_FE_hip_subj,'LineWidth',1.2);
  hold on;
  plot(timepoints_1,angle_FE_knee_subj,'LineWidth',1.2);
  plot(timepoints_1,angle_FE_ankle_subj,'LineWidth',1.2);
  legend({'Hip','Knee','Ankle'},'FontSize',18,'Location','Best')
  xlabel('Time [s]','FontSize',18);
  ylabel('Angle [deg]','FontSize',18);
  XMIN_1 = timepoints_1(1);
  XMAX_1 = timepoints_1(end);
  axis([XMIN_1,XMAX_1,-inf,+inf]);
  ax = gca;
  ax.FontSize = 16;
  title('Healthy','FontSize',22);
  subplot(2,1,2)
  plot(timepoints_2,angle_FE_hip_subj_SCI,'LineWidth',1.2);
  hold on;
  plot(timepoints_2,angle_FE_knee_subj_SCI,'LineWidth',1.2);
  plot(timepoints_2,angle_FE_ankle_subj_SCI,'LineWidth',1.2);
  legend({'Hip','Knee','Ankle'},'FontSize',18,'Location','Best');
  title('SCI','Fontsize',26);
  xlabel('Time [s]','FontSize',18);
  ylabel('Angle [deg]','FontSize',18);  
  XMIN_2 = timepoints_2(1);
  XMAX_2 = timepoints_2(end);
  axis([XMIN_2,XMAX_2,-inf,+inf]);
  ax = gca;
  ax.FontSize = 16;
  
  
  
    
    
    
    
end
                    

 
















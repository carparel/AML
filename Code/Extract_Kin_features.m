function [Kin_feat_table] = Extract_Kin_features(new_struct,type)
% This function evaluates the ROM and w for hip, knee and ankle for both FE and
% AA. 
%
% INPUT: - new_struc = Struct of the selected subject
%        - type = Type (SCI or Healthy)
%
% OUTPUT: - Kin_feat_table = Table containing for each column the selected 
%                            feature (ROM or omega) for each sample (gait cycles) 
%                            on the rows.

trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
conditions = {'NO_FLOAT','FLOAT'};


% To initialize the vector in which we are going to stock our
% features/variables
cond_H = [];
cond_NO_F = [];

ROM_ank_FE_R = [];
ROM_knee_FE_R = [];
ROM_hip_FE_R = [];

ROM_knee_AA_R = [];
ROM_hip_AA_R = [];

w_ank_FE_R = [];
w_knee_FE_R = [];
w_hip_FE_R = [];

w_knee_AA_R = [];
w_hip_AA_R = [];


ROM_ank_FE_L = [];
ROM_knee_FE_L = [];
ROM_hip_FE_L = [];

ROM_ank_AA_L = [];
ROM_knee_AA_L = [];
ROM_hip_AA_L = [];

w_ank_FE_L = [];
w_knee_FE_L = [];
w_hip_FE_L = [];

w_ank_AA_L = [];
w_knee_AA_L = [];
w_hip_AA_L = [];

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        for leg = 1:length(legs)
            if strcmp(type,'SCI')       
                if strcmp(legs{leg},'Right')
                    markers = {'RASI','RKNE','RTOE','RANK'};
                else
                    markers = {'LASI','LKNE','LTOE','LANK'};
                end
            else
                if strcmp(legs{leg},'Right')
                    markers = {'RHIP','RKNE','RTOE','RANK'};
                else
                    markers = {'LHIP','LKNE','LTOE','LANK'};
                end
            end
            
            current = new_struct.(conditions{condition}).(trials{trial}).Parsed;
            for gait = 1:length(current)
                    
                    % Hip
                    % Flexion Extension
                 
                    % defining the segment vector
                    vec_hip_knee = current{1,gait}.(legs{leg}).Kin.(markers{2}) - current{1,gait}.(legs{leg}).Kin.(markers{1});
                   
                    % Since I want the angle only in the YZ plane, we set
                    % their x coordinate to zero (equivalent to projecting
                    % them) for each time instant                    
                    
                    vec_hip_knee = [zeros(length(vec_hip_knee),1) vec_hip_knee(:,2:3)];                    
                    vec_n = [0,0,-1]; % This is the vertical axis with respect to we will evaluate the angles
                    
                    for i = 1:length(vec_hip_knee(:,1))
                         % angle btw two vectors for each time instant
                        angle_FE_1(i) = acosd(dot(vec_hip_knee(i,:),vec_n)/(norm(vec_hip_knee(i,:))*norm(vec_n)));
                    end
                    
                    % computing ROM and angular velocity
                    range_of_motion_1 = max(angle_FE_1)-min(angle_FE_1);
                    omega_1 = mean(diff(angle_FE_1));

                    % stocking                    
                    if strcmp(legs{leg},'Right')
                        ROM_hip_FE_R = [ROM_hip_FE_R range_of_motion_1];
                        w_hip_FE_R = [w_hip_FE_R omega_1];
                    else
                        ROM_hip_FE_L = [ROM_hip_FE_L range_of_motion_1];
                        w_hip_FE_L = [w_hip_FE_L omega_1];
                    end                        
                    
                    % Adduction Abduction
 
                     % defining the segment vector                   
                    vec_hip_knee_AA = current{1,gait}.(legs{leg}).Kin.(markers{2}) - current{1,gait}.(legs{leg}).Kin.(markers{1});
                    
                    % Since I want the angle only in the XZ plane, we set
                    % their y coordinate to zero (equivalent to projecting
                    % them) for each time instant                    
                    
                    vec_hip_knee_AA = [vec_hip_knee_AA(:,1) zeros(length(vec_hip_knee_AA),1) vec_hip_knee_AA(:,3)];                    
                    
                    for i = 1:length(vec_hip_knee_AA(:,1))
                        % angle btw two vectors for each time instant
                        angle_AA_1(i) = acosd(dot(vec_hip_knee_AA(i,:),vec_n)/(norm(vec_hip_knee_AA(i,:))*norm(vec_n)));
                    end                 
                   
                    % computing ROM and angular velocity
                    range_of_motion_2 = max(angle_AA_1)-min(angle_AA_1);                    
                    omega_2 = mean(diff(angle_AA_1));                    

                    % stocking
                    if strcmp(legs{leg},'Right')
                        ROM_hip_AA_R = [ROM_hip_AA_R range_of_motion_2];
                        w_hip_AA_R = [w_hip_AA_R omega_2];
                    else
                        ROM_hip_AA_L = [ROM_hip_AA_L range_of_motion_2];
                        w_hip_AA_L = [w_hip_AA_L omega_2];
                    end  
                    
                    % Knee
                    % Flexion Extension
                    
                    % defining the segment vector                  
                    vec_knee_ankle = current{1,gait}.(legs{leg}).Kin.(markers{4}) - current{1,gait}.(legs{leg}).Kin.(markers{2});                    
                    
                    % Since I want the angle only in the YZ plane, we set
                    % their x coordinate to zero (equivalent to projecting
                    % them) for each time instant
                    
                    vec_knee_ankle = [zeros(length(vec_knee_ankle),1) vec_knee_ankle(:,2:3)];
                    
                    for i = 1:length(vec_hip_knee(:,1))
                        % angle btw two vectors for each time instant
                        angle_FE_2(i) = acosd(dot(vec_hip_knee(i,:),vec_knee_ankle(i,:))/(norm(vec_hip_knee(i,:))*(norm(vec_knee_ankle(i,:)))));
                    end
                    
                    % computing ROM and angular velocity           
                    range_of_motion_3 = max(angle_FE_2)-min(angle_FE_2);                    
                    omega_3 = mean(diff(angle_FE_2));

                    % stocking
                    if strcmp(legs{leg},'Right')
                        ROM_knee_FE_R = [ROM_knee_FE_R range_of_motion_3];
                        w_knee_FE_R = [w_knee_FE_R omega_3];
                    else
                        ROM_knee_FE_L = [ROM_knee_FE_L range_of_motion_3];
                        w_knee_FE_L = [w_knee_FE_L omega_3];
                    end 
                    
                    % Adduction Abduction
             
                    % defining the segment vector
                    vec_knee_ankle_AA = current{1,gait}.(legs{leg}).Kin.(markers{4}) - current{1,gait}.(legs{leg}).Kin.(markers{2});
                    
                    % Since I want the angle only in the XZ plane, we set
                    % their y coordinate to zero (equivalent to projecting
                    % them) for each time instant                      
                    vec_knee_ankle_AA = [vec_knee_ankle_AA(:,1) zeros(length(vec_knee_ankle_AA),1) vec_knee_ankle_AA(:,3)];                    
                    
                    for i = 1:length(vec_hip_knee_AA(:,1))
                        % angle btw two vectors for each time instant
                        angle_AA_2(i) = acosd(dot(vec_knee_ankle_AA(i,:),vec_n)/(norm(vec_knee_ankle_AA(i,:))*norm(vec_n)));
                    end                 

                    % computing ROM and angular velocity
                    range_of_motion_4 = max(angle_AA_2)-min(angle_AA_2);                    
                    omega_4 = mean(diff(angle_AA_2));                    

                    % stocking
                    if strcmp(legs{leg},'Right')
                        ROM_knee_AA_R = [ROM_knee_AA_R range_of_motion_4];
                        w_knee_AA_R = [w_knee_AA_R omega_4];
                    else
                        ROM_knee_AA_L = [ROM_knee_AA_L range_of_motion_4];
                        w_knee_AA_L = [w_knee_AA_L omega_4];
                    end  
        
                    
                    % Foot
                    % Flexion Extension
                   
                    % defining the segment vector
                    vec_ankle_toe = current{1,gait}.(legs{leg}).Kin.(markers{3}) - current{1,gait}.(legs{leg}).Kin.(markers{4});
                    
                    % Since I want the angle only in the YZ plane, we set
                    % their x coordinate to zero (equivalent to projecting
                    % them) for each time instant
                    vec_ankle_toe = [zeros(length(vec_ankle_toe),1) vec_ankle_toe(:,2:3)];
                    
                    for i = 1:length(vec_ankle_toe(:,1))
                        % angle btw two vectors for each time instant
                        angle_FE_3(i) = 90 - acosd(dot(vec_ankle_toe(i,:),vec_knee_ankle(i,:))/(norm(vec_ankle_toe(i,:))*(norm(vec_knee_ankle(i,:)))));
                    end
                    
                    % computing ROM and angular velocity
                    range_of_motion_5 = max(angle_FE_3)-min(angle_FE_3);
                    omega_5 = mean(diff(angle_FE_3));

                    % stocking
                    if strcmp(legs{leg},'Right')
                        ROM_ank_FE_R = [ROM_ank_FE_R range_of_motion_5];
                        w_ank_FE_R = [w_ank_FE_R omega_5];
                    else
                        ROM_ank_FE_L = [ROM_ank_FE_L range_of_motion_5];
                        w_ank_FE_L = [w_ank_FE_L omega_5];
                        
                        if(strcmp(type,'Healthy'))
                            if(strcmp(conditions{condition},'NO_FLOAT'))
                                cond_H = [cond_H 1];
                                cond_NO_F = [cond_NO_F 1];
                            else
                                cond_H = [cond_H 1];
                                cond_NO_F = [cond_NO_F 0];
                            end 
                        else
                            if(strcmp(conditions{condition},'NO_FLOAT'))
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


%Filling the Table

names = {'Condition_H_S','Condition_NF_F','ROM_ank_FE_R','ROM_knee_FE_R','ROM_hip_FE_R',...
    'ROM_knee_AA_R', 'ROM_hip_AA_R','w_ank_FE_R',...
    'w_knee_FE_R','w_hip_FE_R','w_knee_AA_R','w_hip_AA_R',...
    'ROM_ank_FE_L','ROM_knee_FE_L','ROM_hip_FE_L',...
    'ROM_knee_AA_L', 'ROM_hip_AA_L','w_ank_FE_L','w_knee_FE_L',...
    'w_hip_FE_L','w_knee_AA_L','w_hip_AA_L'};
Kin_feat_table = table(cond_H', cond_NO_F', ROM_ank_FE_R',ROM_knee_FE_R',ROM_hip_FE_R',...
    ROM_knee_AA_R',ROM_hip_AA_R',w_ank_FE_R',...
    w_knee_FE_R', w_hip_FE_R',w_knee_AA_R',w_hip_AA_R',...
    ROM_ank_FE_L', ROM_knee_FE_L',ROM_hip_FE_L',...
    ROM_knee_AA_L',ROM_hip_AA_L', w_ank_FE_L',w_knee_FE_L',...
    w_hip_FE_L',w_knee_AA_L',w_hip_AA_L','VariableNames',names);
end



function [Kin_feat_table] = Extract_Kin_features_Healthy(new_struct,Fs_Kin)
% CIAO
trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
conditions = {'NO_FLOAT','FLOAT'};


% To initialize the vector in which we are going to stock our
% features/variables
cond_ = [];

ROM_ank_FE_R = [];
ROM_knee_FE_R = [];
ROM_hip_FE_R = [];

ROM_ank_AA_R = [];
ROM_knee_AA_R = [];
ROM_hip_AA_R = [];

w_ank_FE_R = [];
w_knee_FE_R = [];
w_hip_FE_R = [];

w_ank_AA_R = [];
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
            if strcmp(legs{leg},'Right')
                markers = {'RHIP','RKNE','RTOE','RANK'};
            else
                markers = {'LHIP','LKNE','LTOE','LANK'};
            end
            current = new_struct.(conditions{condition}).(trials{trial}).Parsed;
            for gait = 1:length(current)
                    
                    % Hip
                    % Flexion Extension
                    
                    vec_hip_knee = current{1,gait}.(legs{leg}).Kin.(markers{2}) - current{1,gait}.(legs{leg}).Kin.(markers{1});
                    vec_hip_knee = [zeros(length(vec_hip_knee),1) vec_hip_knee(:,2:3)];                    
                    %vec_n = [0,0,1];
                    vec_n = [0,1,0];
                    
                    for i = 1:length(vec_hip_knee(:,1))
                        angle_hip(i) = asind(dot(vec_hip_knee(i,:),vec_n)/(norm(vec_hip_knee(i,:))*norm(vec_n)));
                    end
                    
                    range_of_motion = max(angle)-min(angle);                    
                    omega = mean(diff(angle));

                    if strcmp(legs{leg},'Right')
                        ROM_hip_FE_R = [ROM_hip_FE_R range_of_motion];
                        w_hip_FE_R = [w_hip_FE_R omega];
                    else
                        ROM_hip_FE_L = [ROM_hip_FE_L range_of_motion];
                        w_hip_FE_L = [w_hip_FE_L omega];
                    end                        
                    
                    % Adduction Abduction
                    
                    vec_hip_knee_AA = current{1,gait}.(legs{leg}).Kin.(markers{2}) - current{1,gait}.(legs{leg}).Kin.(markers{1});
                    vec_hip_knee_AA = [vec_hip_knee_AA(:,1) zeros(length(vec_hip_knee_AA),1) vec_hip_knee_AA(:,3)];                    
                    
                    for i = 1:length(vec_hip_knee_AA(:,1))
                       angle(i) = acosd(dot(vec_hip_knee_AA(i,:),vec_n)/(norm(vec_hip_knee_AA(i,:))*norm(vec_n)));
                    end                 
                   
                    range_of_motion = max(angle)-min(angle);                    
                    omega = mean(diff(angle));                    

                    if strcmp(legs{leg},'Right')
                        ROM_hip_AA_R = [ROM_hip_AA_R range_of_motion];
                        w_hip_AA_R = [w_hip_AA_R omega];
                    else
                        ROM_hip_AA_L = [ROM_hip_AA_L range_of_motion];
                        w_hip_AA_L = [w_hip_AA_L omega];
                    end  
                    
                    % Knee
                    
                    vec_knee_ankle = current{1,gait}.(legs{leg}).Kin.(markers{4}) - current{1,gait}.(legs{leg}).Kin.(markers{2});                    
                    % Since I want the angle only in the YZ plane, I set
                    % their x coordinate to zero (equivalent to projecting
                    % them) for each time instant
                    
                    vec_knee_ankle = [zeros(length(vec_knee_ankle),1) vec_knee_ankle(:,2:3)];
                    
                    for i = 1:length(vec_hip_knee(:,1))
                        % angle btw two vectors 
                        angle_knee(i) = acosd(dot(vec_hip_knee(i,:),vec_knee_ankle(i,:))/(norm(vec_hip_knee(i,:))*(norm(vec_knee_ankle(i,:)))));
                    end
                    
                    range_of_motion = max(angle)-min(angle);                    
                    omega = mean(diff(angle));
                    
                    if strcmp(legs{leg},'Right')
                        ROM_knee_FE_R = [ROM_knee_FE_R range_of_motion];
                        w_knee_FE_R = [w_knee_FE_R omega];
                    else
                        ROM_knee_FE_L = [ROM_knee_FE_L range_of_motion];
                        w_knee_FE_L = [w_knee_FE_L omega];
                    end 
                    
                    % Foot
                    
                    vec_ankle_toe = current{1,gait}.(legs{leg}).Kin.(markers{3}) - current{1,gait}.(legs{leg}).Kin.(markers{4});
                    vec_ankle_toe = [zeros(length(vec_ankle_toe),1) vec_ankle_toe(:,2:3)];
                    
                    for i = 1:length(vec_ankle_toe(:,1))
                        % angle btw two vectors 
                        angle(i) = acosd(dot(vec_ankle_toe(i,:),vec_knee_ankle(i,:))/(norm(vec_ankle_toe(i,:))*(norm(vec_knee_ankle(i,:)))));
                    end                 
                    
                    range_of_motion = max(angle)-min(angle);                    
                    omega = mean(diff(angle));

                    if strcmp(legs{leg},'Right')
                        ROM_ank_FE_R = [ROM_ank_FE_R range_of_motion];
                        w_ank_FE_R = [w_ank_FE_R omega];
                    else
                        ROM_ank_FE_L = [ROM_ank_FE_L range_of_motion];
                        w_ank_FE_L = [w_ank_FE_L omega];
                    end 
                    
                    if strcmp(conditions{condition},'NO_FLOAT')
                       cond_ = [cond_ 11]; %the first 1 means Healthy, the second one that he's able to walk alone (NO_FLOAT)
                    else
                       cond_ = [cond_ 10];
                    end
            end
        end
    end                
end

names = {'Condition','ROM_ank_FE_R','ROM_knee_FE_R','ROM_hip_FE_R','ROM_ank_AA_R','ROM_knee_AA_R', 'ROM_hip_AA_R','w_ank_FE_R','w_knee_FE_R','w_hip_FE_R','w_ank_AA_R','w_knee_AA_R','w_hip_AA_R','ROM_ank_FE_L','ROM_knee_FE_L','ROM_hip_FE_L','ROM_ank_AA_L','ROM_knee_AA_L', 'ROM_hip_AA_L','w_ank_FE_L','w_knee_FE_L','w_hip_FE_L','w_ank_AA_L','w_knee_AA_L','w_hip_AA_L'};
EMG_feat_table = table(cond_', ROM_ank_FE_R',ROM_knee_FE_R',ROM_hip_FE_R',ROM_ank_AA_R',ROM_knee_AA_R',ROM_hip_AA_R',w_ank_FE_R',w_knee_FE_R',w_hip_FE_R',w_ank_AA_R',w_knee_AA_R',w_hip_AA_R',ROM_ank_FE_L',ROM_knee_FE_L',ROM_hip_FE_L',ROM_ank_AA_L',ROM_knee_AA_L',ROM_hip_AA_L',w_ank_FE_L',w_knee_FE_L',w_hip_FE_L',w_ank_AA_L',w_knee_AA_L',w_hip_AA_L','VariableNames',names);

end



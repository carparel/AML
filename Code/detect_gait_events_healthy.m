function [Healthy_subjects] = detect_gait_events_healthy(Healthy_subjects,subject)
% 
% This function is used in order to make a whole structure of events, for
% each case (FLOAT,NO FLOAT) and each trial. Though, it is needed to have a
% structure for the right leg and a structure for the left leg
% INPUT : - datas = all the data to consider, for a subject that must be
%           defined outside the function
%         - leg = if it's the right or left leg, in order to take the good
%         markers
% OUPUT : struct of events

datas = Healthy_subjects.(subject);


legs = {'Right','Left'};
conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
markers = {'Heel','Toe'};
markers_names = {'LANK','LTOE'};
markers_names = {'RANK','RTOE'};

% We initialize the events and the threshold
HS=[];
HO=[];
TS=[];
TO=[];

threshold=[];

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        for marker = 1:length(markers)
            for leg = 1:length(legs)
                
                
                  coefficient_dilation_marker = length(datas.(conditions{condition}).(trials{trial}).Raw.Kin.LTOE)/ ...
            length(datas.(conditions{condition}).(trials{trial}).Filtered.Kin.LTOE);
        
        
        coefficient_dilation_emg = length(datas.(conditions{condition}).(trials{trial}).Raw.EMG.RMG)/ ...
            length(datas.(conditions{condition}).(trials{trial}).Filtered.EMG.envelope.RMG);
                
                if strcmp(legs{leg},'left')
                    markers_names = {'LANK','LTOE'};
                elseif strcmp(legs{leg},'right')
                    markers_names = {'RANK','RTOE'};
                end
                
                if strcmp(markers{marker},'Heel') %If we consider the Heel, we take into account the ANKLE marker
                    marker_position_to_consider = datas.(conditions{condition}).(trials{trial}).Filtered.Kin.(markers_names{1});
                    signal = marker_position_to_consider(:,2); % Just Y-Pos
                    if strcmp(conditions{condition},'FLOAT')
                        threshold = 8; % We have empirically found that the threshold for the FLOAT is 8, for the NO_FLOAT is 4
                        [HS,HO] = plateau_endpoints(signal,threshold); % We determine Heel Strike and Heel Off
                    elseif strcmp(conditions{condition},'NO_FLOAT')
                        threshold =4;
                        [HS,HO] = plateau_endpoints(signal,threshold);
                    end
                    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker = HS; % We put the events in the structure
                    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HO_marker = HO;
                    
                    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg = (HS*coefficient_dilation_marker)/coefficient_dilation_emg; % We put the events in the structure
                    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).HO_emg = (HO*coefficient_dilation_marker)/coefficient_dilation_emg;
                end
                
            if strcmp(markers{marker},'Toe') %If we consider the Toe, we take into account the TOE marker
                marker_position_to_consider = datas.(conditions{condition}).(trials{trial}).Filtered.Kin.(markers_names{2});
                signal = marker_position_to_consider(:,2);
                if strcmp(conditions{condition},'FLOAT')
                    threshold = 8;
                    [TS,TO] = plateau_endpoints(signal,threshold);
                elseif strcmp(conditions{condition},'NO_FLOAT')
                    threshold =4;
                    [TS,TO] = plateau_endpoints(signal,threshold);
                end
                Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TS_marker = TS;
                Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_marker = TO;
                
                Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TS_emg = (TS*coefficient_dilation_marker)/coefficient_dilation_emg; % We put the events in the structure
                Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.(legs{leg}).TO_emg = (TO*coefficient_dilation_marker)/coefficient_dilation_emg;
            end
            end
        end
    end
    
end
end
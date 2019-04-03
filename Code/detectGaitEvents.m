function [Healthy_subjects] = detectGaitEvents(Healthy_subjects,subject,leg)
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

if strcmp(leg,'left')
    markers_names = {'LANK','LTOE'};
elseif strcmp(leg,'right')
    markers_names = {'RANK','RTOE'};
end


conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
markers = {'Heel','Toe'};

% We initialize the events and the threshold
HS=[];
HO=[];
TS=[];
TO=[];

threshold=[];

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        for marker = 1:length(markers)
            
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
                Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.HS = HS; % We put the events in the structure
                Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.HO = HO;
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
                Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.TS = TS;
                Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Event.TO = TO;
            end
        end
    end
end

end
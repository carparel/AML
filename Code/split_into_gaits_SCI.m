function [SCI_subjects] = split_into_gaits_SCI(SCI_subjects)
% This functions divides the signal into gait cycles for the SCI subjects
% based on the gait events previously found. 
%
% INPUT: - SCI_subjects = structure containing all the data related to the
%                         SCI subjects.
%
% OUTPUT: -SCI_subjects = updated structure. 

conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
legs = {'Right', 'Left'};
envelopes = {'envelope','noenvelope'};



for condition = 1:length(conditions)
    for trial = 1:length(trials)
        for leg = 1:length(legs)

            if strcmp(legs{leg},'Right')
                markers = {'RASI','RKNE','RTOE','RANK'};
                emgs = {'RMG','RTA'};
            elseif strcmp(legs{leg},'Left')
                markers = {'LASI','LKNE','LTOE','LANK'};
                emgs = {'LMG','LTA'};
            end
            
            nbr_events_right = length(SCI_subjects.(conditions{condition}).(trials{trial}).Event.Right.HS_marker);
            nbr_events_left = length(SCI_subjects.(conditions{condition}).(trials{trial}).Event.Left.HS_marker);
            
            min_nbr_events = min([nbr_events_right,nbr_events_left]);
            
            for nb_steps = 1:min_nbr_events-1
                
                for marker = 1:length(markers)
                    old_signal = SCI_subjects.(conditions{condition}).(trials{trial}).Filtered.Kin.(markers{marker});
                    SCI_subjects.(conditions{condition}).(trials{trial}).Parsed{nb_steps}.(legs{leg}).Kin.(markers{marker}) = ...
                        old_signal(SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker(nb_steps) : ...
                        SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker(nb_steps+1),:);
                end
                
                
                
                for emg = 1:length(emgs)
                    for envelope = 1:length(envelopes)
                        if strcmp(envelopes{envelope},'envelope')
                            old_signal = SCI_subjects.(conditions{condition}).(trials{trial}).Normalized.EMG.envelope.(emgs{emg});
                            SCI_subjects.(conditions{condition}).(trials{trial}).Parsed{nb_steps}.(legs{leg}).EMG.envelope.(emgs{emg}) = ...
                                old_signal((SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg(nb_steps)) : ...
                                (SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg(nb_steps+1)),:);
                        elseif strcmp(envelopes{envelope},'noenvelope')
                            old_signal = SCI_subjects.(conditions{condition}).(trials{trial}).Normalized.EMG.noenvelope.(emgs{emg});
                            SCI_subjects.(conditions{condition}).(trials{trial}).Parsed{nb_steps}.(legs{leg}).EMG.noenvelope.(emgs{emg}) = ...
                                old_signal((SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg(nb_steps)) : ...
                                (SCI_subjects.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg(nb_steps+1)),:);
                        end
                    end
                end
            end
        end
    end
end
end

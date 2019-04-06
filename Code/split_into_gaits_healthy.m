function [Healthy_subjects] = split_into_gaits_healthy(Healthy_subjects,subject)

datas = Healthy_subjects.(subject);
conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
legs = {'Right', 'Left'};
envelopes = {'envelope','noenvelope'};

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        for leg = 1:length(legs)
            
            
            if strcmp(legs{leg},'Right')  
                markers = {'RHIP','RKNE','RTOE','RANK'};
                emgs = {'RMG','RTA'};
            elseif strcmp(legs{leg},'Left')
                markers = {'LHIP','LKNE','LTOE','LANK'};
                emgs = {'LMG','LTA'};
            end
            
            nbr_events_right = length(datas.(conditions{condition}).(trials{trial}).Event.Right.HS_marker);
            nbr_events_left = length(datas.(conditions{condition}).(trials{trial}).Event.Left.HS_marker);
            
            min_nbr_events = min([nbr_events_right,nbr_events_left]);
            
            for nb_steps = 1:min_nbr_events-1
                
                for marker = 1:length(markers)
                    old_signal = datas.(conditions{condition}).(trials{trial}).Filtered.Kin.(markers{marker});
                    Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Parsed{nb_steps}.(legs{leg}).Kin.(markers{marker}) = ...
                        old_signal(datas.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker(nb_steps) : ...
                        datas.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_marker(nb_steps+1));
                end
                
                
                
                for emg = 1:length(emgs)
                    %
                    for envelope = 1:length(envelopes)
                        if strcmp(envelopes{envelope},'envelope')
                            old_signal = datas.(conditions{condition}).(trials{trial}).Filtered.EMG.envelope.(emgs{emg});
                            Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Parsed{nb_steps}.(legs{leg}).EMG.envelope.(emgs{emg}) = ...
                                old_signal((datas.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg(nb_steps)) : ...
                                (datas.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg(nb_steps+1)));
                        elseif strcmp(envelopes{envelope},'noenvelope')
                            old_signal = datas.(conditions{condition}).(trials{trial}).Filtered.EMG.noenvelope.(emgs{emg});
                            Healthy_subjects.(subject).(conditions{condition}).(trials{trial}).Parsed{nb_steps}.(legs{leg}).EMG.noenvelope.(emgs{emg}) = ...
                                old_signal((datas.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg(nb_steps)) : ...
                                (datas.(conditions{condition}).(trials{trial}).Event.(legs{leg}).HS_emg(nb_steps+1)));
                        end
                    end
                end
            end
        end
    end
end
end

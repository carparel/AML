function [EMG_feat_table] = Extract_EMG_features_Healthy(struct_,Fs_EMG)
% CIAO
trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
conditions = {'NO_FLOAT','FLOAT'};


% To initialize the vector in which we are going to stock our
% features/variables
cond_ = [];

LTA_time = [];
LTA_max = [];
LTA_mean = [];

RTA_time = [];
RTA_max = [];
RTA_mean = [];

LMG_time = [];
LMG_max = [];
LMG_mean = [];

RMG_time = [];
RMG_max = [];
RMG_mean = [];

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        for leg = 1:length(legs)
            if strcmp(legs{leg},'Right')
                muscles = {'RMG','RTA'};
            else
                muscles = {'LMG','LTA'};
            end
            current = struct_.(conditions{condition}).(trials{trial}).Parsed;
            for gait = 1:length(current)
                for muscle = 1:length(muscles)
                    if (strcmp(muscles{muscle},'LTA') || strcmp(muscles{muscle},'RTA'))

                        current_signal = current{1,gait}.(legs{leg}).EMG.envelope.(muscles{muscle});
                        figure()
                        XMIN = 0;
                        XMAX = length(current_signal);
                        YMIN = -inf;
                        YMAX = +inf;
                        plot(current_signal);
                        hold on;
                        idx = find(current_signal < 0.01);
                        onset1 = 1;
                        offset1 = idx(1);
                        onset2 = idx(end);
                        offset2 = length(current_signal);
                        plot(onset1,current_signal(onset1),'ro');
                        plot(offset1,current_signal(offset1),'bo');
                        plot(offset2,current_signal(offset2),'bo');
                        plot(onset2,current_signal(onset2),'ro');
                        axis([XMIN XMAX YMIN YMAX]);
                        legend('EMG signal','Onsets','Offsets')
                        title([conditions{condition} ' ' trials{trial} ' ' legs{leg} ' Gait = ' num2str(gait) ' ' muscles{muscle}]);

                        if strcmp(muscles{muscle},'LTA')
                            % Duration [s]
                            length_idx1 = offset1 - onset1;
                            LTA_duration1 = length_idx1/Fs_EMG;
                            length_idx2 = offset2 - onset2;
                            LTA_duration2 = length_idx2/Fs_EMG;
                            duration = LTA_duration1 + LTA_duration2;
                            
                            LTA_time = [LTA_time duration];
                            
                            % Max amplitude
                            max_1 = max(current_signal(onset2:offset2));
                            max_2 = max(current_signal(onset1:offset1));
                            max_amp = max([max_1 max_2]);
                            
                            LTA_max = [LTA_max max_amp];
                            
                            % Mean amplitude
                            rms_1 = rms(current_signal(onset2:offset2));
                            rms_2 = rms(current_signal(onset1:offset1));
                            mean_amp = mean([rms_1 rms_2]);
                            
                            LTA_mean = [LTA_mean mean_amp];
                            
                            if strcmp(conditions{condition},'NO_FLOAT')
                                cond_ = [cond_ 11]; %the first 1 means Healthy, the second one that he's able to walk alone (NO_FLOAT)
                            else
                                cond_ = [cond_ 10];
                            end
                        else
                            % Duration [s]
                            length_idx1 = offset1 - onset1;
                            RTA_duration1 = length_idx1/Fs_EMG;
                            length_idx2 = offset2 - onset2;
                            RTA_duration2 = length_idx2/Fs_EMG;
                            duration = RTA_duration1 + RTA_duration2;
                            
                            RTA_time = [RTA_time duration];
                            
                            % Max amplitude
                            max_1 = max(current_signal(onset2:offset2));
                            max_2 = max(current_signal(onset1:offset1));
                            max_amp = max([max_1 max_2]);
                            
                            RTA_max = [RTA_max max_amp];
                            
                            % Mean amplitude
                            rms_1 = rms(current_signal(onset2:offset2));
                            rms_2 = rms(current_signal(onset1:offset1));
                            mean_amp = mean([rms_1 rms_2]);
                            
                            RTA_mean = [RTA_mean mean_amp];
                        end
                    else
                        current_signal = current{1,gait}.(legs{leg}).EMG.envelope.(muscles{muscle});
                        
%                         figure()
%                         XMIN = 0;
%                         XMAX = length(current_signal);
%                         YMIN = -inf;
%                         YMAX = +inf;
%                         plot(current_signal)
%                         hold on;
                        if (strcmp(muscles{muscle},'LMG') &&  strcmp(conditions{condition},'NO_FLOAT'))
                            threshold = 0.01;
                            movsignal = movmean(current_signal,250);
                        else
                            threshold = 0.025;
                            movsignal = movmean(current_signal,500);
                        end
                        [~,onset] = min(abs(movsignal(1:round(length(current_signal)/2)) - threshold));
                        [~,offset] = min(abs(movsignal(round((length(current_signal)/2)) + 1: end) - threshold));
                        offset = offset + round(length(current_signal)/2);
%                         plot(onset,current_signal(onset),'ro')
%                         plot(offset,current_signal(offset),'bo')
%                         axis([XMIN XMAX YMIN YMAX]);
%                         title([conditions{condition} ' ' trials{trial} ' ' legs{leg} ' Gait = ' num2str(gait) ' ' muscles{muscle}]);
%                         
                        if strcmp(muscles{muscle},'LMG')
                            % Duration [s]
                            length_idx = offset - onset;
                            duration = length_idx/Fs_EMG;
                            LMG_time = [LMG_time duration];
                            
                            % Max amplitude
                            max_amp = max(current_signal(onset:offset));
                            LMG_max = [LMG_max max_amp];
                            
                            % Mean amplitude
                            mean_amp = rms(current_signal(onset:offset));
                            LMG_mean = [LMG_mean mean_amp];
                        else
                            % Duration [s]
                            length_idx = offset - onset;
                            duration = length_idx/Fs_EMG;
                            RMG_time = [RMG_time duration];
                            
                            % Max amplitude
                            max_amp = max(current_signal(onset:offset));
                            RMG_max = [RMG_max max_amp];
                            
                            % Mean amplitude
                            mean_amp = rms(current_signal(onset:offset));
                            RMG_mean = [RMG_mean mean_amp];
                        end
                    end
                end
                
            end
        end
    end
end

names = {'Condition','LMG_duration','LMG_max','LMG_mean','RMG_duration','RMG_max', 'RMG_mean','LTA_duration','LTA_max','LTA_mean','RTA_duration','RTA_max','RTA_mean'};
EMG_feat_table = table(cond_', LMG_time',LMG_max',LMG_mean',RMG_time',RMG_max',RMG_mean',LTA_time',LTA_max',LTA_mean',RTA_time',RTA_max',RTA_mean','VariableNames',names);

end



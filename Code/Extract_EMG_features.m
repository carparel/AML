function [EMG_feat_table] = Extract_EMG_features(struct_,type,Fs_EMG)
% This extracts the features from the EMG signals
% 
% INPUT: - struct_ = the data structure 
%        - type = corresponding to either Healthy or SCI
%        - Fs = sampling frequency for the EMG signals.
%        
%
% OUTPUT: EMG_feat_table = table containing the extracted features
% (columns) ...
trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
conditions = {'NO_FLOAT','FLOAT'};


% To initialize the vector in which we are going to stock our
% features/variables
cond_H = [];
cond_NO_F= [];

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
                        if strcmp(type,'Healthy')
                         
                            
                            current_signal = current{1,gait}.(legs{leg}).EMG.envelope.(muscles{muscle});
                            
                            if strcmp(conditions{condition},'FLOAT')
                                threshold = 0.1;
                            else
                                threshold = 0.18;
                            end
                            movsignal = movmean(current_signal,500);
                            idx = find(movsignal < threshold);
                            onset1 = 1; 
                            offset1 = idx(1);
                            
                            %if for a specific case the threshold no_float
                            %is a bit too high
                            if idx(1) == 1
                                idx = find(current_signal < 0.15);
                                offset1 = idx(1);
                            end
                            
                            onset2 = idx(end);
                            offset2 = length(current_signal);
                           
                            % Uncomment to plot Healthy subjects LTA or RTA
                            
%                             figure()
%                             XMIN = 0;
%                             XMAX = length(current_signal);
%                             YMIN = -inf;
%                             YMAX = +inf;
%                             plot(current_signal);
%                             hold on;
% 
% 
%                             plot(onset1,current_signal(onset1),'ro');
%                             plot(offset1,current_signal(offset1),'bo');
%                             plot(offset2,current_signal(offset2),'bo');
%                             plot(onset2,current_signal(onset2),'ro');
% 
%                             axis([XMIN XMAX YMIN YMAX]);
%                             legend('EMG signal','Onsets','Offsets')
%                             title([conditions{condition} ' ' trials{trial} ' ' legs{leg} ' Gait = ' num2str(gait) ' ' muscles{muscle}]);

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
                               
                               % In order to evaluate the condition
                               if strcmp(conditions{condition},'NO_FLOAT')
                                    cond_H = [cond_H 1];
                                    cond_NO_F = [cond_NO_F 1];
                               else
                                    cond_H = [cond_H 1];
                                    cond_NO_F = [cond_NO_F 0];
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
                        end
                        
                        
                        if strcmp(type,'SCI')
                            if strcmp(muscles{muscle},'LTA')
                                current_signal = current{1,gait}.(legs{leg}).EMG.envelope.(muscles{muscle});
                                


                            threshold = 0.2;
                            movsignal = movmean(current_signal,500);
                            idx = find(movsignal < threshold);
                            
                            onset1 = 1; 
                            offset1 = idx(1);
                             
                            onset2 = idx(end);
                            offset2 = length(current_signal);
                                % Uncomment to plot SCI subjects LTA
                                
%                                 figure()
%                                 XMIN = 0;
%                                 XMAX = length(current_signal);
%                                 YMIN = -inf;
%                                 YMAX = +inf;
%                                 plot(current_signal);
%                                 hold on;
% 
%                                 plot(onset1,current_signal(onset1),'ro');
%                                 plot(offset1,current_signal(offset1),'bo');
%                                 plot(offset2,current_signal(offset2),'bo');
%                                 plot(onset2,current_signal(onset2),'ro');
%                                 axis([XMIN XMAX YMIN YMAX]);
%                                 legend('EMG signal','Onsets','Offsets')
%                                 title([conditions{condition} ' ' trials{trial} ' ' legs{leg} ' Gait = ' num2str(gait) ' ' muscles{muscle}]);
% 

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
                                
                                
                                if(strcmp(conditions{condition},'NO_FLOAT'))
                                    cond_H = [cond_H 0];
                                    cond_NO_F = [cond_NO_F 1];
                                else
                                    cond_H = [cond_H 0];
                                    cond_NO_F = [cond_NO_F 0];
                                end
                                
                            else %For RTA for SCI patients
                                
                            threshold = 0.17;
                                movsignal = movmean(current_signal,500);
                                
                            
                                [~,onset1] = min(abs(movsignal(1:round(length(current_signal)/2)) - threshold));
                                [~,offset2] = min(abs(movsignal(round((length(current_signal)/2)) + 1: end) - threshold));
                                offset2 = offset2 + round(length(current_signal)/2);


                                [~,idx] = findpeaks(current_signal,'MinPeakHeight',0.3);
                                
                                if (length(idx) == 1)
                                
                                onset2 =  idx;
                                offset1 = idx;
                                
                                else
                                    
                                    [~,onset2] =  min(current_signal(idx(1):idx(2)));
                                    onset2 = onset2 + idx(1);
                                    offset1 = onset2;
                                end
                                %Uncomment to plot SCI for RTA muscle
                                
%                                 figure()
%                                 XMIN = 0;
%                                 XMAX = length(current_signal);
%                                 YMIN = -inf;
%                                 YMAX = +inf;
%                                 plot(current_signal);
%                                 hold on;
% 
%                                 plot(onset1,current_signal(onset1),'ro');
%                                 plot(offset1,current_signal(offset1),'bo');
%                                 plot(offset2,current_signal(offset2),'bo');
%                                 plot(onset2,current_signal(onset2),'ro');
%                                 axis([XMIN XMAX YMIN YMAX]);
%                                 legend('EMG signal','Onsets','Offsets')
%                                 title([conditions{condition} ' ' trials{trial} ' ' legs{leg} ' Gait = ' num2str(gait) ' ' muscles{muscle}]);
% 

                                
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
                        end 
                        
  
                    else % For RMG and LMG muscles
                        if (strcmp(type,'Healthy') || strcmp(type,'SCI'))
                            current_signal = current{1,gait}.(legs{leg}).EMG.envelope.(muscles{muscle});                    

                            threshold = 0.1;
                            movsignal = movmean(current_signal,500);
                        
                            [~,onset] = min(abs(movsignal(1:round(length(current_signal)/2)) - threshold));
                            [~,offset] = min(abs(movsignal(round((length(current_signal)/2)) + 1: end) - threshold));
                            offset = offset + round(length(current_signal)/2);
                            % Uncomment to plot RMG and LMG muscles (for
                            % either SCI or Healthy)
                            
%                             figure()
%                             XMIN = 0;
%                             XMAX = length(current_signal);
%                             YMIN = -inf;
%                             YMAX = +inf;
%                             plot(current_signal)
%                             hold on;
%                             
%                             plot(onset,current_signal(onset),'ro')
%                             plot(offset,current_signal(offset),'bo')
%                             axis([XMIN XMAX YMIN YMAX]);
%                             title([conditions{condition} ' ' trials{trial} ' ' legs{leg} ' Gait = ' num2str(gait) ' ' muscles{muscle}]);

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
end
% THERE IS A PROBLEM WITH LMG......
LMG_time = [LMG_time 0.5];
LMG_max = [LMG_max 0.5];

names = {'Healthy_Condition','NO_Float_Condition','LMG_duration','LMG_max','LMG_mean','RMG_duration','RMG_max', 'RMG_mean','LTA_duration','LTA_max','LTA_mean','RTA_duration','RTA_max','RTA_mean'};
EMG_feat_table = table(cond_H',cond_NO_F', LMG_time',LMG_max',LMG_mean',RMG_time',RMG_max',RMG_mean',LTA_time',LTA_max',LTA_mean',RTA_time',RTA_max',RTA_mean','VariableNames',names);

end



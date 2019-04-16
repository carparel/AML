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
                        if (strcmp(type,'Healthy'))
                            
                            current_signal = current{1,gait}.(legs{leg}).EMG.envelope.(muscles{muscle});
                            
                            movsignal = movmean(current_signal,400);
                            epsilon = 0.02;
                            idx = find(movsignal < min(movsignal)+epsilon);
                            onset1 = 1;
                            offset1 = idx(1);
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
%                             plot(movsignal);
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
%
                            if strcmp(muscles{muscle},'LTA')
                                if((onset1 == offset1) && (onset2 ==offset2))
                                    % Duration [s]
                                    length_idx = offset2 - onset1;
                                    LTA_duration = length_idx/Fs_EMG;
                                    duration = LTA_duration;
                                    LTA_time = [LTA_time duration];
                                    
                                    % Max amplitude
                                    max_amp = max(current_signal(onset1:offset2));
                                    LTA_max = [LTA_max max_amp];
                                    
                                    % Mean amplitude
                                    mean_amp = rms(current_signal(onset1:offset2));
                                    LTA_mean = [LTA_mean mean_amp];
                                else
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
                                    
                                    
                                end
                                % In order to evaluate the condition
                                if strcmp(conditions{condition},'NO_FLOAT')
                                    cond_H = [cond_H 1];
                                    cond_NO_F = [cond_NO_F 1];
                                else
                                    cond_H = [cond_H 1];
                                    cond_NO_F = [cond_NO_F 0];
                                end
                                
                            else
                                if((onset1 == offset1) && (onset2 ==offset2))
                                    % Duration [s]
                                    length_idx = offset2 - onset1;
                                    RTA_duration = length_idx/Fs_EMG;
                                    duration = RTA_duration;
                                    RTA_time = [RTA_time duration];
                                    
                                    % Max amplitude
                                    max_amp = max(current_signal(onset1:offset2));
                                    RTA_max = [RTA_max max_amp];
                                    
                                    % Mean amplitude
                                    mean_amp = rms(current_signal(onset1:offset2));
                                    RTA_mean = [RTA_mean mean_amp];
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
                            % For SCI subjects
                        else
                            if strcmp(muscles{muscle},'LTA')
                                current_signal = current{1,gait}.(legs{leg}).EMG.envelope.(muscles{muscle});
                                
                                movsignal = movmean(current_signal,400);
                                epsilon = 0.04;
                                idx = find(movsignal < min(movsignal)+epsilon);
                                onset1 = 1;
                                offset1 = idx(1);
                                onset2 = idx(end);
                                offset2 = length(current_signal);
                                
 
                                % Uncomment to plot SCI subject LTA (same
                                % reasoning as for Healthy)
%                                 figure()
%                                 XMIN = 0;
%                                 XMAX = length(current_signal);
%                                 YMIN = -inf;
%                                 YMAX = +inf;
%                                 plot(current_signal);
%                                 hold on;
%                                 plot(movsignal);
%
%
%                                 plot(onset1,current_signal(onset1),'ro');
%                                 plot(offset1,current_signal(offset1),'bo');
%                                 plot(offset2,current_signal(offset2),'bo');
%                                 plot(onset2,current_signal(onset2),'ro');
%
%                                 axis([XMIN XMAX YMIN YMAX]);
%                                 legend('EMG signal','Onsets','Offsets')
%                                 title([conditions{condition} ' ' trials{trial} ' ' legs{leg} ' Gait = ' num2str(gait) ' ' muscles{muscle}]);
%
%
                                if((onset1 == offset1) && (onset2 ==offset2))
                                    % Duration [s]
                                    length_idx = offset2 - onset1;
                                    LTA_duration = length_idx/Fs_EMG;
                                    duration = LTA_duration;
                                    LTA_time = [LTA_time duration];
                                    
                                    % Max amplitude
                                    max_amp = max(current_signal(onset1:offset2));
                                    LTA_max = [LTA_max max_amp];
                                    
                                    % Mean amplitude
                                    mean_amp = rms(current_signal(onset1:offset2));
                                    LTA_mean = [LTA_mean mean_amp];
                                else
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
                                    
                                    
                                end
                                % In order to evaluate the condition
                                if strcmp(conditions{condition},'NO_FLOAT')
                                    cond_H = [cond_H 0];
                                    cond_NO_F = [cond_NO_F 1];
                                else
                                    cond_H = [cond_H 0];
                                    cond_NO_F = [cond_NO_F 0];
                                end
                                
                            else
                                idx = find(current_signal > max(current_signal)/3);
                                
                                onset = idx(1);
                                offset = idx(end);
                                % Uncomment to plot SCI subject RTA (only
                                % taking into account one onset and onse
                                % offset)
                                
%                                 figure()
%                                 XMIN = 0;
%                                 XMAX = length(current_signal);
%                                 YMIN = -inf;
%                                 YMAX = +inf;
%                                 plot(current_signal);
%                                 hold on;
%
%
%
%                                 plot(onset,current_signal(onset),'ro');
%                                 plot(offset,current_signal(offset),'bo');
%
%
%                                 axis([XMIN XMAX YMIN YMAX]);
%                                 legend('EMG signal','Onsets','Offsets')
%                                 title([conditions{condition} ' ' trials{trial} ' ' legs{leg} ' Gait = ' num2str(gait) ' ' muscles{muscle}]);
%
%

                                % Duration [s]
                                length_idx = offset - onset;
                                RTA_duration = length_idx/Fs_EMG;
                                duration = RTA_duration;
                                RTA_time = [RTA_time duration];
                                
                                % Max amplitude
                                max_amp = max(current_signal(onset:offset));
                                RTA_max = [RTA_max max_amp];
                                
                                % Mean amplitude
                                mean_amp = rms(current_signal(onset:offset));
                                RTA_mean = [RTA_mean mean_amp];
                                
                            end
                            
                        end
                        
                    else % For RMG and LMG muscles
                        if (strcmp(type,'Healthy') || strcmp(type,'SCI'))
                            current_signal = current{1,gait}.(legs{leg}).EMG.envelope.(muscles{muscle});
                            
              
                            idx = find(current_signal > max(current_signal)/4);
                            onset = idx(1);
                            offset = idx(end);
                            
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
%                             
%                             plot(onset,current_signal(onset),'ro')
%                             plot(offset,current_signal(offset),'bo')
%                             axis([XMIN XMAX YMIN YMAX]);
%                             title([conditions{condition} ' ' trials{trial} ' ' legs{leg} ' Gait = ' num2str(gait) ' ' muscles{muscle}]);
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
end


names = {'Healthy_Condition','NO_Float_Condition','LMG_duration','LMG_max','LMG_mean','RMG_duration','RMG_max', 'RMG_mean','LTA_duration','LTA_max','LTA_mean','RTA_duration','RTA_max','RTA_mean'};
EMG_feat_table = table(cond_H',cond_NO_F', LMG_time',LMG_max',LMG_mean',RMG_time',RMG_max',RMG_mean',LTA_time',LTA_max',LTA_mean',RTA_time',RTA_max',RTA_mean','VariableNames',names);

end



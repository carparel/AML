function [strike_idx, off_idx] = find_events(signal,condition)
% Signal is already the desired vector (i.e. only Y coordinate).
% The signal should already be CUT!!

%TO TRY ALL THE PLOTS
% conditions = {'FLOAT','NO_FLOAT'};
% trials = {'T_01','T_02','T_03'};
% subjects_nbr = 6;
% markers = {'LANK','RANK','LTOE','RTOE'};


% for s = 3:subjects_nbr
%     for condition = 1:length(conditions)
%         if strcmp(conditions{condition},'NO_FLOAT')
%             % Experimental thresholds:
%             peak_distance = 100;
%             thr_HS = 0.5;
%             thr_TO = 0.5;
%         else
%             % Experimental thresholds:
%             peak_distance = 100;
%             thr_HS = 0.3;
%             thr_TO = 0.3;
%         end
%
%         for trial = 1:length(trials)
%             for marker = 1:length(markers)
%                 signal_matrix = Healthy_subjects.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Filtered.Kin.(markers{marker});
%                 signal = signal_matrix(:,2);
%                 der1 = diff(signal);
%                 der2 = diff(der1);
%                 der2 = movmean(der2,20);
%
%                 if (signal(end) > 0)
%                     [~,idx_TO] = findpeaks(der2,'MinPeakHeight',thr_TO,'MinPeakDistance',peak_distance); %HS when the gait "goes" down
%                     [~,idx_HS] = findpeaks(-der2,'MinPeakHeight',thr_HS,'MinPeakDistance',peak_distance); %TO when the gait "goes" down
%
%                     figure()
%                     plot(signal);
%                     hold on;
%                     plot(idx_TO+2,signal(idx_TO+2),'ro');
%                     plot(idx_HS+2,signal(idx_HS+2),'bo');
%                     legend('Signal','TO','HS')
%                     title(['S_' num2str(s) ' ' conditions{condition} ' ' trials{trial} ' ' markers{marker}]);
%                 else
%                     [~,idx_TO] = findpeaks(-der2,'MinPeakHeight',thr_TO,'MinPeakDistance',peak_distance); %HS when the gait "goes" down
%                     [~,idx_HS] = findpeaks(der2,'MinPeakHeight',thr_HS,'MinPeakDistance',peak_distance); %TO when the gait "goes" down
%
%                     figure()
%                     plot(signal);
%                     hold on;
%                     plot(idx_TO+2,signal(idx_TO+2),'ro'); %HS
%                     plot(idx_HS+2,signal(idx_HS+2),'bo'); %TO
%                     legend('Signal','TO','HS')
%                     title(['S_' num2str(s) ' ' conditions{condition} ' ' trials{trial} ' ' markers{marker}]);
%                 end
%             end
%         end
%     end
% end


if strcmp(condition,'NO_FLOAT')
    % Experimental thresholds:
    peak_distance = 100;
    thr_HS = 0.5;
    thr_TO = 0.5;
else
    % Experimental thresholds:
    peak_distance = 100;
    thr_HS = 0.3;
    thr_TO = 0.3;
end

der1 = diff(signal);
der2 = diff(der1);
der2 = movmean(der2,20);

if (signal(end) > 0)
    [~,idx_TO] = findpeaks(der2,'MinPeakHeight',thr_TO,'MinPeakDistance',peak_distance); %HS when the gait "goes" down
    [~,idx_HS] = findpeaks(-der2,'MinPeakHeight',thr_HS,'MinPeakDistance',peak_distance); %TO when the gait "goes" down
    
%     figure()
%     plot(signal);
%     hold on;
%     plot(idx_TO+2,signal(idx_TO+2),'ro');
%     plot(idx_HS+2,signal(idx_HS+2),'bo');
%     legend('Signal','TO','HS')
    strike_idx = idx_HS + 2;
    off_idx = idx_TO + 2;
else
    [~,idx_TO] = findpeaks(-der2,'MinPeakHeight',thr_TO,'MinPeakDistance',peak_distance); %HS when the gait "goes" down
    [~,idx_HS] = findpeaks(der2,'MinPeakHeight',thr_HS,'MinPeakDistance',peak_distance); %TO when the gait "goes" down
    
%     figure()
%     plot(signal);
%     hold on;
%     plot(idx_TO+2,signal(idx_TO+2),'ro'); %HS
%     plot(idx_HS+2,signal(idx_HS+2),'bo'); %TO
%     legend('Signal','TO','HS')

    strike_idx = idx_HS + 2;
    off_idx = idx_TO + 2;
end

end


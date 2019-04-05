function [strike_idx, off_idx] = find_events(signal,condition)
% Signal is already the desired vector (i.e. only Y coordinate). 

conditions = {'FLOAT','NO_FLOAT'};
trials = {'T_01','T_02','T_03'};
subjects_nbr = 6;
markers = {'LANK','RANK','LTOE','RTOE'};

% TO TRY ALL THE PLOTS
% for s = 4:subjects_nbr
%     for condition = 1:length(conditions)
%         for trial = 1:length(trials)
%             for marker = 1:length(markers)
%                 if strcmp(conditions{condition},'NO_FLOAT')
%                     signal_matrix = Healthy_subjects.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Filtered.Kin.(markers{marker});
%                     cut_signal = signal_matrix(20:length(signal_matrix)-20,2);
%                     der1 = diff(cut_signal);
%                     der2 = diff(der1);
%                     
%                     for i = 1:length(der2)-20
%                         if (mean(der2(i:i+20)) > -0.4 && mean(der2(i:i+20)) < 0.6)
%                             der2(i) = 0;
%                         end
%                     end
%                     
%                     % Experimental thresholds:
%                     peak_distance = 100;
%                     thr_HS = 0.6;
%                     thr_TO = 0.4;
%                     
%                     [~,idx_HS] = findpeaks(der2,'MinPeakHeight',thr_HS,'MinPeakDistance',peak_distance);%,'MinPeakWidth',5);
%                     [~,idx_TO] = findpeaks(-der2,'MinPeakHeight',thr_TO,'MinPeakDistance',peak_distance);%,'MinPeakWidth',5);
%                     figure()
%                     plot(cut_signal);
%                     hold on;
%                     plot(idx_HS+2,cut_signal(idx_HS+2),'ro'); %HS
%                     plot(idx_TO+2,cut_signal(idx_TO+2),'bo'); %TO
%                     title(['S_' num2str(s) ' ' conditions{condition} ' ' trials{trial} ' ' markers{marker}]);
%                     
%                 else
%                     signal_matrix = Healthy_subjects.(['S_' num2str(s)]).(conditions{condition}).(trials{trial}).Filtered.Kin.(markers{marker});
%                     cut_signal = signal_matrix(20:length(signal_matrix)-20,2);
%                     der1 = diff(cut_signal);
%                     der2 = diff(der1);
%                     
%                     for i = 1:length(der2)-10
%                         if (mean(der2(i:i+10)) > -0.4 && mean(der2(i:i+10)) < 0.4)
%                             der2(i) = 0;
%                         end
%                     end
%                     
%                     % Experimental thresholds:
%                     peak_distance = 90;
%                     thr_HS = 0.4;
%                     thr_TO = 0.4;
%                     
%                     [~,idx_HS] = findpeaks(der2,'MinPeakHeight',thr_HS,'MinPeakDistance',peak_distance,'MinPeakWidth',5);
%                     [~,idx_TO] = findpeaks(-der2,'MinPeakHeight',thr_TO,'MinPeakDistance',peak_distance,'MinPeakWidth',5);
%                     figure()
%                     plot(cut_signal);
%                     hold on;
%                     plot(idx_HS+2,cut_signal(idx_HS+2),'ro'); %HS
%                     plot(idx_TO+2,cut_signal(idx_TO+2),'bo'); %TO
%                     title(['S_' num2str(s) ' ' conditions{condition} ' ' trials{trial} ' ' markers{marker}]);
%                     
%                 end
%             end
%         end
%     end
% end

cut_signal = signal(30:length(signal_matrix)-30);

der1 = diff(cut_signal);
der2 = diff(der1);
    
if strcmp(condition,'NO_FLOAT')
    
    for i = 1:length(der2)-20
        if (mean(der2(i:i+20)) > -0.4 && mean(der2(i:i+20)) < 0.6)
            der2(i) = 0;
        end
    end
    
    % Experimental thresholds:
    peak_distance = 100;
    thr_HS = 0.6;
    thr_TO = 0.4;
    
    [~,idx_HS] = findpeaks(der2,'MinPeakHeight',thr_HS,'MinPeakDistance',peak_distance);%,'MinPeakWidth',5);
    [~,idx_TO] = findpeaks(-der2,'MinPeakHeight',thr_TO,'MinPeakDistance',peak_distance);%,'MinPeakWidth',5);
    figure()
    plot(cut_signal);
    hold on;
    plot(idx_HS+2,cut_signal(idx_HS+2),'ro'); %HS
    plot(idx_TO+2,cut_signal(idx_TO+2),'bo'); %TO
    title(condition);
    
    % + 2 because of the second derivative
    strike_idx = idx_HS + 2;
    off_idx = idx_TO + 2;
else
    
    for i = 1:length(der2)-10
        if (mean(der2(i:i+10)) > -0.4 && mean(der2(i:i+10)) < 0.4)
            der2(i) = 0;
        end
    end
    
    % Experimental thresholds:
    peak_distance = 90;
    thr_HS = 0.4;
    thr_TO = 0.4;
    
    [~,idx_HS] = findpeaks(der2,'MinPeakHeight',thr_HS,'MinPeakDistance',peak_distance,'MinPeakWidth',5);
    [~,idx_TO] = findpeaks(-der2,'MinPeakHeight',thr_TO,'MinPeakDistance',peak_distance,'MinPeakWidth',5);
    figure()
    plot(cut_signal);
    hold on;
    plot(idx_HS+2,cut_signal(idx_HS+2),'ro'); %HS
    plot(idx_TO+2,cut_signal(idx_TO+2),'bo'); %TO
    title(condition);
    
    % + 2 because of the second derivative
    strike_idx = idx_HS + 2;
    off_idx = idx_TO + 2;
end

end


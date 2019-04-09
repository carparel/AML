function [strike_idx, off_idx] = find_events(signal,condition)
%  This function is used to detect the events (strike and off points) for
%  the given signal. We use a method based on the second derivative of the
%  signal, because these events are likely to correspond (or at least they
%  are really close) to the points of maximum convexity and concavity of
%  the signal (thus corresponding to the maxima and minima of the second
%  derivative).
%
% INPUT: - signal = it is already the desired vector (the second component,
%                  Y component, of the desired marker). The marker should  to
%                  correspond either the ANKLE one or the TOE one. 
%        - condition = a string value, one of the two possible conditions 
%                      'NO_FLOAT' and 'FLOAT'. This is important because the
%                      thresholds for the detection depend on the
%                      condition.
%
% OUTPUT: - strike_idx = vector containing the strike points, i.e. they can
%                       be heel strike or toe strike, depending on which
%                       marker is considered.
%         - off_idx = vector containing the off points, i.e. they can be
%                     heel off or toe off, depending on which marker is 
%                     considered.

%% TO PLOT ALL CASES 
% Uncomment these lines if you want to plot all the figures in order to assess
% how good the detection of the events is.
%
% conditions = {'FLOAT','NO_FLOAT'};
% trials = {'T_01','T_02','T_03'};
% subjects_nbr = 4;
% markers = {'LANK','RANK','LTOE','RTOE'};
% 
% 
% for s = 4:subjects_nbr
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

%% MAIN CODE OF THE FUNCTION

if strcmp(condition,'NO_FLOAT')
    % Experimental thresholds:
    peak_distance = 100;
    thr_strike = 0.5;
    thr_off = 0.5;
elseif strcmp(condition,'FLOAT')
    % Experimental thresholds:
    peak_distance = 100;
    thr_strike = 0.3;
    thr_off = 0.3;
end

der1 = diff(signal);
der2 = diff(der1);
der2 = movmean(der2,20);

if (signal(end) > 0)
    [~,idx_off] = findpeaks(der2,'MinPeakHeight',thr_off,'MinPeakDistance',peak_distance); 
    [~,idx_strike] = findpeaks(-der2,'MinPeakHeight',thr_strike,'MinPeakDistance',peak_distance); 
    strike_idx = idx_strike + 2;
    off_idx = idx_off + 2;
else
    [~,idx_off] = findpeaks(-der2,'MinPeakHeight',thr_off,'MinPeakDistance',peak_distance); 
    [~,idx_strike] = findpeaks(der2,'MinPeakHeight',thr_strike,'MinPeakDistance',peak_distance); 
    strike_idx = idx_strike + 2;
    off_idx = idx_off + 2;
end


end



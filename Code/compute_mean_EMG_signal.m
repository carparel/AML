function [normalized_mean_EMG] = compute_mean_EMG_signal(EMG_struct)
% To compute the mean EMG signal over the 3 trials.
%
% NOTICE that the struct you give as argument has to be already one of the
% FLOAT_NO_CRUTCHES or NO_FLOAT_CRUTCHES for example. 

l1 = length(EMG_struct.T01.LMG);
l2 = length(EMG_struct.T02.LMG);
l3 = length(EMG_struct.T03.LMG);

min_l = min([l1,l2,l3]);

EMG_LMG(1,:) = EMG_struct.T01.LMG(1:min_l);
EMG_LMG(2,:) = EMG_struct.T02.LMG(1:min_l);
EMG_LMG(3,:) = EMG_struct.T03.LMG(1:min_l);

EMG_RMG(1,:) = EMG_struct.T01.RMG(1:min_l);
EMG_RMG(2,:) = EMG_struct.T02.RMG(1:min_l);
EMG_RMG(3,:) = EMG_struct.T03.RMG(1:min_l);

EMG_LTA(1,:) = EMG_struct.T01.LTA(1:min_l);
EMG_LTA(2,:) = EMG_struct.T02.LTA(1:min_l);
EMG_LTA(3,:) = EMG_struct.T03.LTA(1:min_l);

EMG_RTA(1,:) = EMG_struct.T01.RTA(1:min_l);
EMG_RTA(2,:) = EMG_struct.T02.RTA(1:min_l);
EMG_RTA(3,:) = EMG_struct.T03.RTA(1:min_l);

% Computing the mean EMG signal
mean_EMG_LMG_signal = mean(EMG_LMG);
mean_EMG_RMG_signal = mean(EMG_RMG);
mean_EMG_LTA_signal = mean(EMG_LTA);
mean_EMG_RTA_signal = mean(EMG_RTA);

% We normalize the EMG signal according to the maximum contraction value
max_contraction_LMG = max(mean_EMG_LMG_signal);
max_contraction_RMG = max(mean_EMG_RMG_signal);
max_contraction_LTA = max(mean_EMG_LTA_signal);
max_contraction_RTA = max(mean_EMG_RTA_signal);

normalized_mean_LMG_EMG = mean_EMG_LMG_signal/max_contraction_LMG;
normalized_mean_RMG_EMG = mean_EMG_RMG_signal/max_contraction_RMG;
normalized_mean_LTA_EMG = mean_EMG_LTA_signal/max_contraction_LTA;
normalized_mean_RTA_EMG = mean_EMG_RTA_signal/max_contraction_RTA;

normalized_mean_EMG.LMG = normalized_mean_LMG_EMG;
normalized_mean_EMG.RMG = normalized_mean_RMG_EMG;
normalized_mean_EMG.LTA = normalized_mean_LTA_EMG;
normalized_mean_EMG.RTA = normalized_mean_RTA_EMG;

end


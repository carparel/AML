function [] = filter_and_plot_EMG(EMG_average_signals,fs,envelope)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

LMG_filtered = filtering_emg(EMG_average_signals.LMG,fs,envelope);
RMG_filtered = filtering_emg(EMG_average_signals.RMG,fs,envelope);
LTA_filtered = filtering_emg(EMG_average_signals.LTA,fs,envelope);
RTA_filtered = filtering_emg(EMG_average_signals.RTA,fs,envelope);

time_idx = 1:1:length(LMG_filtered);
time_points = time_idx/fs; %in seconds

% Plotting
subplot(2,2,1)
plot(time_points,LMG_filtered,'k','LineWidth',1.2);
xlabel('Time [s]');
ylabel('Arbitrary units');
title('LMG');

subplot(2,2,2)
plot(time_points,RMG_filtered,'k','LineWidth',1.2);
xlabel('Time [s]');
ylabel('Arbitrary units');
title('RMG');

subplot(2,2,3)
plot(time_points,LTA_filtered,'k','LineWidth',1.2);
xlabel('Time [s]');
ylabel('Arbitrary units');
title('LTA');

subplot(2,2,4)
plot(time_points,RTA_filtered,'k','LineWidth',1.2);
xlabel('Time [s]');
ylabel('Arbitrary units');
title('RTA');

end


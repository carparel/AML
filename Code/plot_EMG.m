function [] = plot_EMG(EMG_envelope, EMG_no_envelope,fs)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

LMG_filtered_env = EMG_envelope.LMG;
RMG_filtered_env = EMG_envelope.RMG;
LTA_filtered_env = EMG_envelope.LTA;
RTA_filtered_env = EMG_envelope.RTA;
LMG_filtered_noenv = EMG_no_envelope.LMG;
RMG_filtered_noenv = EMG_no_envelope.RMG;
LTA_filtered_noenv = EMG_no_envelope.LTA;
RTA_filtered_noenv = EMG_no_envelope.RTA;

time_idx = 1:1:length(LMG_filtered_noenv);
time_points = time_idx/fs; %in seconds

XMIN = 0;
XMAX = time_points(length(time_points));
YMIN = -1;
YMAX = +1;

% Plotting
subplot(2,2,1)
plot(time_points,LMG_filtered_noenv,'k','LineWidth',1.2);
hold on;
plot(time_points,LMG_filtered_env,'r','LineWidth',1.2);
xlabel('Time [s]');
ylabel('Arbitrary units');
title('LMG');
axis([XMIN XMAX YMIN YMAX]);

subplot(2,2,2)
plot(time_points,RMG_filtered_noenv,'k','LineWidth',1.2);
hold on;
plot(time_points,RMG_filtered_env,'r','LineWidth',1.2);
xlabel('Time [s]');
ylabel('Arbitrary units');
title('RMG');
axis([XMIN XMAX YMIN YMAX]);

subplot(2,2,3)
plot(time_points,LTA_filtered_noenv,'k','LineWidth',1.2);
hold on;
plot(time_points,LTA_filtered_env,'r','LineWidth',1.2);
xlabel('Time [s]');
ylabel('Arbitrary units');
title('LTA');
axis([XMIN XMAX YMIN YMAX]);

subplot(2,2,4)
plot(time_points,RTA_filtered_noenv,'k','LineWidth',1.2);
hold on;
plot(time_points,RTA_filtered_env,'r','LineWidth',1.2);
xlabel('Time [s]');
ylabel('Arbitrary units');
title('RTA');
axis([XMIN XMAX YMIN YMAX]);

end


function [] = plot_EMG(EMG_envelope, EMG_no_envelope,fs)
% This function plots the EMG for a certain trial for all the muscles
% (RTA,LTA,RGM,LGM) in a subplot. The non-envelope and the envelope signal
% are plotted in the same figure (hold on).
%
% INPUT: - EMG_envelope = the filtered signal with also the envelope (it is
%                         a structure containing the 4 muscles).
%        - EMG_no_envelope = the filtered signal without the envelope (it is
%                            a structure containing the 4 muscles).
%        - fs = sampling frequency for the EMG.
%
% OUTPUT: //

%% Defining all the different signals (from the given structures)
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

%% Plotting
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


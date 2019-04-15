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

time_idx_LMG = 1:1:length(LMG_filtered_noenv);
time_points_LMG = time_idx_LMG/fs; %in seconds

time_idx_RMG = 1:1:length(RMG_filtered_noenv);
time_points_RMG = time_idx_RMG/fs; %in seconds

time_idx_LTA = 1:1:length(LTA_filtered_noenv);
time_points_LTA = time_idx_LTA/fs; %in seconds

time_idx_RTA= 1:1:length(RTA_filtered_noenv);
time_points_RTA = time_idx_RTA/fs; %in seconds

XMIN = 0;
XMAX = time_points_LMG(length(time_points_LMG));
YMIN = -1;
YMAX = +1;

%% Plotting
subplot(2,2,1)
plot(time_points_LMG,LMG_filtered_noenv,'k','LineWidth',1.2);
hold on;
plot(time_points_LMG,LMG_filtered_env,'r','LineWidth',1.2);
xlabel('Time [s]');
ylabel('Arbitrary units');
title('LMG');
axis([XMIN XMAX YMIN YMAX]);

subplot(2,2,2)
plot(time_points_RMG,RMG_filtered_noenv,'k','LineWidth',1.2);
hold on;
plot(time_points_RMG,RMG_filtered_env,'r','LineWidth',1.2);
xlabel('Time [s]');
ylabel('Arbitrary units');
title('RMG');
axis([XMIN XMAX YMIN YMAX]);

subplot(2,2,3)
plot(time_points_LTA,LTA_filtered_noenv,'k','LineWidth',1.2);
hold on;
plot(time_points_LTA,LTA_filtered_env,'r','LineWidth',1.2);
xlabel('Time [s]');
ylabel('Arbitrary units');
title('LTA');
axis([XMIN XMAX YMIN YMAX]);

subplot(2,2,4)
plot(time_points_RTA,RTA_filtered_noenv,'k','LineWidth',1.2);
hold on;
plot(time_points_RTA,RTA_filtered_env,'r','LineWidth',1.2);
xlabel('Time [s]');
ylabel('Arbitrary units');
title('RTA');
axis([XMIN XMAX YMIN YMAX]);

end


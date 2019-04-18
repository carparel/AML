function [] = plot_raw_EMG_events(Healthy_subjects_19, subject, condition, trial, Fs_emg)
% This functions outputs a graph showing the two right muscles, RTA and
% RGM, superposed (in order to show the coordination between the two) and
% the strike events (to show how the muscle signals are divided into gait
% cycles). It is a function only for illustration purposes.
%
% INPUT: - Healthy_subjects_19 = structure containing all the data related
%                                to the healthy subjects of 2019.
%        - subject = a string parameter. It indicates the number of the
%                    subject. It should be something like 'S_1'.
%        - condition = a string parameter. It indicates the condition of
%                      the trial. It is either 'NO_FLOAT' or 'FLOAT'.
%        - trial = a string parameter. It indicates the trial of
%                      the subject. It should be something like 'T_01'.
%        - Fs_emg = sampling frequency for the EMG signals
%
% OUTPUT: \\


% Defining the signals to plot
raw_signal_EMG_RTA = Healthy_subjects_19.(subject).(condition).(trial).Raw.EMG.RTA;
raw_signal_EMG_RMG = Healthy_subjects_19.(subject).(condition).(trial).Raw.EMG.RMG;

% Defining the vector containing the strike events (for EMG)
events_heel_strike = Healthy_subjects_19.(subject).(condition).(trial).Event.Right.HS_emg;

% Computing the time points
time_idx = 1:1:length(raw_signal_EMG_RTA);
time_pnts = time_idx/Fs_emg;

%% Plotting

f = figure();

% Inserting a shift just to take a part of the signal also after the last
% heel strike detected.
% We plot until the last heel strike, because sometimes the signal was
% longer and not all the events were detected (in particular the last ones,
% because of the subsequent cut --> see cut_events() for example).
shift = 0.5;

XMIN = 0;
XMAX = time_pnts(events_heel_strike(end)) + shift;
YMIN = -inf;
YMAX = +inf;

plot(time_pnts,raw_signal_EMG_RTA,'b','LineWidth',1.2);
hold on;
plot(time_pnts,raw_signal_EMG_RMG,'k','LineWidth',1.2);
plot(time_pnts(events_heel_strike),raw_signal_EMG_RTA(events_heel_strike),'ro','MarkerSize',10,'MarkerFaceColor','r');
xlabel('Time [s]','FontSize',25);
ylabel('Signal amplitude [V]','FontSize',25);
title('Raw EMG of right TA and MG with Heel-strike events','FontSize',30);
legend({'RTA','RMG','Heel Strikes'},'FontSize',25);
axis([XMIN XMAX YMIN YMAX]);
ax = gca;
ax.FontSize = 20;
set(f,'Position',[0 0 1700 480]);
end


function [] = plot_extract_EMG(Healthy19)
% This function plots two graphs showing a correct and incorrect feature
% extraction of TA muscle. This function is only for illustration purposes.
%
% INPUT: - Healthy19 = struct containing data of the healthy subjects from
%                      2019.
%        
% OUTPUT: \\

% Figure 3a: detection on one Healthy TA muscle that worked well (we took subject 2 from 2019)

current_signal_1 = Healthy19.S_2.NO_FLOAT.T_03.Parsed{1,2}.Left.EMG.envelope.LTA;

movsignal = movmean(current_signal_1,400);
epsilon = 0.02;
idx = find(movsignal < min(movsignal)+epsilon);
onset1 = 1;
offset1 = idx(1);
onset2 = idx(end);
offset2 = length(current_signal_1);

f= figure();
XMIN = 0;
XMAX = length(current_signal_1);
YMIN = -inf;
YMAX = +inf;
plot(current_signal_1,'k','Linewidth',2.6);
hold on;
plot(movsignal,'k--');

scatter(onset1,current_signal_1(onset1),220,'filled','ro');
scatter(offset1,current_signal_1(offset1),220,'filled','bo');
scatter(offset2,current_signal_1(offset2),220,'filled','bo');
scatter(onset2,current_signal_1(onset2),220,'filled','ro');

axis([XMIN XMAX YMIN YMAX]);
legend({'EMG signal','Moving average of EMG','Activity onsets','Activity offsets'},'Fontsize',35,'Location','Best');
xlabel('Time (ms)');
ylabel('EMG signal (normalized)');
a = gca;
a.FontSize = 25;
title({'Correct detection of TA muscle activity on EMG signal'},'Fontsize',30);
set(f,'Position',[0 0 980 1920]);

% Figure 3b: detection on one Healthy TA muscle that didn't work well (we took subject 1 from 2019)

current_signal_2 = Healthy19.S_1.NO_FLOAT.T_02.Parsed{1,2}.Left.EMG.envelope.LTA;

movsignal = movmean(current_signal_2,400);
epsilon = 0.02;
idx = find(movsignal < min(movsignal)+epsilon);
onset1 = 1;
offset1 = idx(1);
onset2 = idx(end);
offset2 = length(current_signal_2);

h = figure();
XMIN = 0;
XMAX = length(current_signal_2);
YMIN = -inf;
YMAX = +inf;
plot(current_signal_2,'k','Linewidth',2.6);
hold on;
plot(movsignal,'k--');

scatter(onset1,current_signal_2(onset1),220,'filled','ro');
scatter(offset1,current_signal_2(offset1),220,'filled','bo');
scatter(offset2,current_signal_2(offset2),220,'filled','bo');
scatter(onset2,current_signal_2(onset2),220,'filled','ro');

axis([XMIN XMAX YMIN YMAX]);
legend({'EMG signal','Moving average of EMG','Activity onsets','Activity offsets'},'Fontsize',35,'Location','Best');
xlabel('Time (ms)');
ylabel('EMG signal (normalized)');
a = gca;
a.FontSize = 25;
title({'Incorrect detection of TA muscle activity on EMG signal'},'Fontsize',30);
set(h,'Position',[0 0 980 1920]);
end


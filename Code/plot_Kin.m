function [] = plot_Kin(marker_signal_table_SCI,marker_signal_table_Healthy,marker_SCI,marker_H,fs)



signal1 = marker_signal_table_SCI.(['L' marker_SCI]);
signal2 = marker_signal_table_SCI.(['R' marker_SCI]);
signal3 = marker_signal_table_Healthy.(['L' marker_H]);
signal4 = marker_signal_table_Healthy.(['R' marker_H]);

XMIN = 0;

% Maximum of signal
max1 = max(signal1(:,2));
max2 = max(signal2(:,2));
max3 = max(signal3(:,2));
max4 = max(signal4(:,2));

YMAX = max([max1,max2,max3,max4]);

% Minimum of signal
min1 = min(signal1(:,2));
min2 = min(signal2(:,2));
min3 = min(signal3(:,2));
min4 = min(signal4(:,2));

YMIN = min([min1,min2,min3,min4]);


% to find the time points in SCI
just_for_time = marker_signal_table_SCI.(['L' marker_SCI]);
nbr_points = length(just_for_time(:,2));
time_vector = 1:1:nbr_points;
time_points_SCI = time_vector/fs;
XMAX_SCI = time_points_SCI(nbr_points);

subplot(2,2,1)

plot(time_points_SCI, signal1(:,2),'LineWidth',1.2);
xlabel('Time [s]');
ylabel('Y kinetic coordinate');
title(['L' marker_SCI ' SCI'],'FontSize',12);
axis([XMIN XMAX_SCI YMIN YMAX]);

subplot(2,2,2)
plot(time_points_SCI, signal2(:,2),'LineWidth',1.2);
xlabel('Time [s]');
ylabel('Y kinetic coordinate');
title(['R' marker_SCI ' SCI'],'FontSize',12);
axis([XMIN XMAX_SCI YMIN YMAX]);

% to find the time points in Healthy
just_for_time = marker_signal_table_Healthy.(['L' marker_H]);
nbr_points = length(just_for_time(:,2));
time_vector = 1:1:nbr_points;
time_points_H = time_vector/fs;
XMAX_H = time_points_H(nbr_points);

subplot(2,2,3)
plot(time_points_H, signal3(:,2),'LineWidth',1.2);
xlabel('Time [s]');
ylabel('Y kinetic coordinate');
title(['L' marker_H ' Healthy'],'FontSize',12);
axis([XMIN XMAX_H YMIN YMAX]);

subplot(2,2,4)
plot(time_points_H, signal4(:,2),'LineWidth',1.2);
xlabel('Time [s]');
ylabel('Y kinetic coordinate');
title(['R' marker_H ' Healthy'],'FontSize',12);
axis([XMIN XMAX_H YMIN YMAX]);

end


function [] = plot_gait_events(Healthy_subjects,subject,condition,trial,marker,leg)

% This function plots the gait events together with the signal for ankle
% and toe only.

signal = Healthy_subjects.(subject).(condition).(trial).Filtered.Kin.(marker);
events = Healthy_subjects.(subject).(condition).(trial).Event;
figure;
plot(signal(:,2));
hold on;
    if (strcmp(marker,'LTOE') || strcmp(marker,'RTOE'))
        scatter(events.(leg).TS_marker,signal(events.(leg).TS_marker,2));
        scatter(events.(leg).TO_marker,signal(events.(leg).TO_marker,2));
    else
        scatter(events.(leg).HS_marker,signal(events.(leg).HS_marker,2));
        scatter(events.(leg).HO_marker,signal(events.(leg).HO_marker,2));
    end
end

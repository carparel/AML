function [] = plot_gait_events(Healthy_subjects,subject,condition,trial,marker)

% This function plots the gait events together with the signal for ankle
% and toe only.

signal = Healthy_subjects.(subject).(condition).(trial).Filtered.Kin.(marker);
events = Healthy_subjects.(subject).(condition).(trial).Event;
figure;
plot(signal(:,2));
hold on;
    if (strcmp(marker,'LTOE') || strcmp(marker,'RTOE'))
        scatter(events.TS,signal(events.TS,2));
        scatter(events.TO,signal(events.TO,2));
    else
        scatter(events.HS,signal(events.HS,2));
        scatter(events.HO,signal(events.HO,2));
    end
end

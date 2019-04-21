function [] = check_ground_truth_events(events_struct,Healthy18,Healthy19)
% To show all the graphs for all trials in order to check if the visually
% detected events make sense or not.
%
% INPUT: - events_struct = structure containing all the events (it is the
%                          output of the function visual_detection() )
%        - Healthy_2018 = structure containing all the data related to the
%                         healthy subjects of the year 2018.
%        - Healthy_2019 = structure containing all the data related to the
%                         healthy subjects of the year 2019.
%
% OUTPUT: //

years = {'2018','2019'};
conditions = {'FLOAT','NO_FLOAT'};
trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};

% for plot titles (in order to not have the boring underscores)
types = {'FLOAT', 'NO FLOAT'};
trials_title = {'Trial 1','Trial 2','Trial 3'};

for year = 1:length(years)
    
    if strcmp(years{year},'2018')
        data = Healthy18;
        subjects = 4;
    else
        data = Healthy19;
        subjects = [1,2,3];
    end
    
    for subject = 1:length(subjects)
        current_subject_event = events_struct.(['Year_' years{year}]).(['S_' num2str(subjects(subject))]);
        current_subject_signal = data.(['S_' num2str(subjects(subject))]);
        
        for condition = 1:length(conditions)
            for trial = 1:length(trials)
                current_trial_event = current_subject_event.(conditions{condition}).(trials{trial});
                current_trial_signal = current_subject_signal.(conditions{condition}).(trials{trial}).Filtered.Kin;
                for leg = 1:length(legs)
                    
                    if strcmp(legs{leg},'Right')
                        markers = {'RTOE','RANK'};
                    else
                        markers = {'LTOE','LANK'};
                    end
                    
                    for marker = 1:length(markers)                 
%% Figure for the report
                        
                        if year == 2
                            if subject == 2
                                if condition == 2
                                    if trial == 1
                                        if leg == 2
                                            if marker == 2
                                                current_marker_event = current_trial_event.Event.(legs{leg}).(markers{marker});
                                                current_marker_signal = current_trial_signal.(markers{marker});
                                                Y_coordinate = current_marker_signal(:,2);
                                                Z_coordinate = current_marker_signal(:,3);
                                                
                                                fs_Kin = 100;
                                                
                                                time_idx = 1:1:length(Y_coordinate);
                                                time_points = time_idx/fs_Kin; %in seconds
                                                
                                                XMIN = 0;
                                                XMAX = time_points(length(time_points));
                                                YMIN = -4500;
                                                YMAX = 3000;
                                                h = figure();
                                                
                                                plot(time_points,Y_coordinate,'k-','LineWidth',2.4);
                                                hold on;
                                                grid on;
                                                plot(time_points,Z_coordinate,'k-','LineWidth',2.4);
                                                
                                                scatter(time_points(current_marker_event.OFF),Z_coordinate(current_marker_event.OFF),160,'filled','bo');
                                                scatter(time_points(current_marker_event.STRIKE),Z_coordinate(current_marker_event.STRIKE),160,'filled','ro');
                                                
                                                scatter(time_points(current_marker_event.OFF),Y_coordinate(current_marker_event.OFF),160,'filled','bo');
                                                scatter(time_points(current_marker_event.STRIKE),Y_coordinate(current_marker_event.STRIKE),160,'filled','ro');
                                                
                                                legend({'signal Y','signal Z','Off','Strike'},'FontSize',40,'Location','Best');
                                                xlabel({'Time [s]'},'FontSize',30);
                                                ylabel({'Marker position [mm]'},'FontSize',30);
                                                axis([XMIN XMAX YMIN YMAX]);
                                                a = gca;
                                                a.FontSize = 38;
                                                title({'Events detection by visual inspection'},'Fontsize',45);
                                                set(h,'Position',[0 0 1920 820]);
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        
                        %% Comment all "if" conditions to check all the trials for all subjects
                        %current_marker_event = current_trial_event.Event.(legs{leg}).(markers{marker});
                        %current_marker_signal = current_trial_signal.(markers{marker});
                        %offset = 4000;
                        %Y_coordinate = current_marker_signal(:,2);
                        %Z_coordinate = current_marker_signal(:,3);
                        %figure();
                        %yyaxis left
                        %ylabel({'Ankle marker position (mm)'},'FontSize',16);
                        %plot(Y_coordinate+offset,'k-','LineWidth',1.2);
                        %hold on;
                        %yyaxis right
                        %plot(Z_coordinate,'k-','LineWidth',2.4);
                        %grid on;
                        
                        %scatter(current_marker_event.OFF,Z_coordinate(current_marker_event.OFF),'filled','bo');
                        %scatter(current_marker_event.STRIKE,Z_coordinate(current_marker_event.STRIKE),'filled','ro');
                        
                        %scatter(current_marker_event.OFF,Y_coordinate(current_marker_event.OFF)+offset,'filled','bo');
                        %scatter(current_marker_event.STRIKE,Y_coordinate(current_marker_event.STRIKE)+offset,'filled','ro');
                        
                        %legend({'signal Y','signal Z','Off','Strike'},'FontSize',14);
                        %title({'Events detection by visual inspection'},'Fontsize',18);
                        
                    end
                end
            end
        end
    end
end

end
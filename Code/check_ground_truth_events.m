function [] = check_ground_truth_events(events_struct,Healthy_2018,Healthy_2019)
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

% To plot titles (in order to not have the boring underscores)
types = {'FLOAT', 'NO FLOAT'};
trials_title = {'Trial 1','Trial 2','Trial 3'};

for year = 1:length(years)
    
    if strcmp(years{year},'2018')
        data = Healthy_2018;
        subjects = 4;
    else
        data = Healthy_2019;
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
                        % The signal and the events
                        current_marker_event = current_trial_event.Event.(legs{leg}).(markers{marker});
                        current_marker_signal = current_trial_signal.(markers{marker});
                        Y_coordinate = current_marker_signal(:,2);
                        Z_coordinate = current_marker_signal(:,3);
                        figure();             
                        plot(Y_coordinate,'k-','LineWidth',1.2);
                        hold on;
                        plot(Z_coordinate,'r-','LineWidth',1.2);
                        grid on;
                        
                        plot(current_marker_event.OFF,Z_coordinate(current_marker_event.OFF),'bo');
                        plot(current_marker_event.STRIKE,Z_coordinate(current_marker_event.STRIKE),'ro');
                        
                        plot(current_marker_event.OFF,Y_coordinate(current_marker_event.OFF),'bo');
                        plot(current_marker_event.STRIKE,Y_coordinate(current_marker_event.STRIKE),'ro');
                        
                        legend('signal Y','signal Z','Off','Strike');
                        title({[years{year} '; ' ['S_' num2str(subjects(subject))] ' ;'  types{condition} ' ; ' trials_title{trial} '; Leg = ' legs{leg} '; Marker =' markers{marker}],'Find the strike points'});
                    end
                end
            end
        end
    end
end

end


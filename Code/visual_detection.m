function [struct_events] = visual_detection(Healthy_2018,Healthy_2019)
% This function performs the visual detection of the events on all the
% signals for the Healthy subjects. The detection is performed manually and
% the indices are stocked into a structure. 
%
% INPUT: - Healthy_2018 = structure containing all the data related to the
%                         Healthy subjects 2018.
%        - Healthy_2019 = structure containing all the data related to the
%                         Healthy subjects 2019.
%
% OUTPUT: - struct_events = final structure containing all the gait events 
%                           for healthy subjects.

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
        current_subject = data.(['S_' num2str(subjects(subject))]);
        for condition = 1:length(conditions)
            for trial = 1:length(trials)
                current_trial = current_subject.(conditions{condition}).(trials{trial}).Filtered.Kin;
                for leg = 1:length(legs)
                    
                    if strcmp(legs{leg},'Right')
                        markers = {'RTOE','RANK'};
                    else
                        markers = {'LTOE','LANK'};
                    end
                    
                    for marker = 1:length(markers)
                        current_marker = current_trial.(markers{marker});
                        Z_coordinate = current_marker(:,3);
                        
                        % The first time is to find the strike events.
                        figure();
                        hold on;
                        grid on;
                        plot(Z_coordinate,'r-','LineWidth',1.2);
                        XMIN = 0;
                        XMAX = length(Z_coordinate);
                        YMIN = 0;
                        YMAX = 1000;
                        axis([XMIN XMAX YMIN YMAX]);
                        title({[years{year} '; ' ['S_' num2str(subjects(subject))] ' ;'  types{condition} ' ; ' trials_title{trial} '; Leg = ' legs{leg} '; Marker =' markers{marker}],'Find the strike points'});
                        % Press Return key to exit.
                        [struct_events.(['Year_' years{year}]).(['S_' num2str(subjects(subject))]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker}).STRIKE,~] = ginput();
                        struct_events.(['Year_' years{year}]).(['S_' num2str(subjects(subject))]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker}).STRIKE = round(struct_events.(['Year_' years{year}]).(['S_' num2str(subjects(subject))]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker}).STRIKE);
                        
                        % The second time is to find the off events.
                        figure();
                        hold on;
                        grid on;
                        plot(Z_coordinate,'r-','LineWidth',1.2);
                        XMIN = 0;
                        XMAX = length(Z_coordinate);
                        YMIN = 0;
                        YMAX = 1000;
                        axis([XMIN XMAX YMIN YMAX]);
                        title({[years{year} '; ' ['S_' num2str(subjects(subject))] ' ;' types{condition} ' ; ' trials_title{trial} '; Leg = ' legs{leg} '; Marker =' markers{marker}],'Find the OFF points'});
                        % Press Return key to exit.
                        [struct_events.(['Year_' years{year}]).(['S_' num2str(subjects(subject))]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker}).OFF,~] = ginput();
                        struct_events.(['Year_' years{year}]).(['S_' num2str(subjects(subject))]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker}).OFF = round(struct_events.(['Year_' years{year}]).(['S_' num2str(subjects(subject))]).(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker}).OFF);
                    end
                end
            end
        end
    end
    
% To save the events and to not have to repeat this procedure at every run!
save('Events.mat','struct_events');
end


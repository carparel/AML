% AML-Project 2 - Courtine part
%
% Group Members : - Giovanna Aiello
%                 - Gaia Carparelli 
%                 - Marion Claudet
%                 - Martina Morea 
%                 - Leonardo Pollina

clear;
clc;
addpath('Data');
addpath('Data/SCI');
addpath('Data/Healthy');
addpath('Code');
%% Loading the data for the SCI and creating the new useful structure

% ATTENTION: the first time the window will pop up select the folder
% containing the data of the SCI subjects. The second time select the
% folder containing the data of the Healthy subects.
[SCI_subjects, Healthy_subjects, csv_files_FLOAT_NO_CRUTCHES,csv_files_NO_FLOAT_CRUTCHES] = load_data();

% To stock the sampling frequency for the EMG
Fs_EMG = SCI_subjects.FLOAT.T_01.fsEMG;
% To stock the sampling frequency for the Kinetics
Fs_Kin = SCI_subjects.FLOAT.T_01.fsKIN;
%% Structuring the EMG data

[Healthy_subjects,SCI_subjects] = structureEMG(Healthy_subjects,SCI_subjects,Fs_EMG);

%% Plotting the filtered signal together with the raw
% Choose the subject, the trial and the condition you want to plot
subject = 'S_4';
condition = 'NO_FLOAT';
trial = 'T_01';

figure(1)
plot_EMG(SCI_subjects.(condition).(trial).Normalized.EMG.envelope,SCI_subjects.(condition).(trial).Normalized.EMG.noenvelope,Fs_EMG);

% int this plot we have the EMG signal for healthy subjects for the four
% muscles of interest
% you have to give to the function the struct.chosen_trial

figure(2)
plot_EMG(Healthy_subjects.(subject).(condition).(trial).Normalized.EMG.envelope,Healthy_subjects.(subject).(condition).(trial).Normalized.EMG.noenvelope,Fs_EMG);

%% Structuring the Kin data

[Healthy_subjects,SCI_subjects] = structureKin(Healthy_subjects,SCI_subjects,Fs_Kin);

%% Plot kin signals

% Choose what to plot
subject = 'S_4';
condition = 'NO_FLOAT';
trial = 'T_01';

% ATTENTION: Do not indicate the position R/L of the marker.
% If you want to plot the hip signal, you have to indicate ASI for SCI
% subjects and HIP for Healthy subjects

marker_SCI = 'TOE';
marker_Healthy = 'TOE';

figure(1);
plot_Kin(SCI_subjects.(condition).(trial).Filtered.Kin, ...
    Healthy_subjects.(subject).(condition).(trial).Filtered.Kin,marker_SCI,marker_Healthy,Fs_Kin);
hold on;

marker_SCI = 'ANK';
marker_Healthy = 'ANK';

figure(2);
plot_Kin(SCI_subjects.(condition).(trial).Filtered.Kin, ... 
    Healthy_subjects.(subject).(condition).(trial).Filtered.Kin,marker_SCI,marker_Healthy,Fs_Kin);
%% Detect gait events
% In order to detect the gait events we have considered the Y coordinate of
% the markers ANKLE and TOE. The Hill Strike (HS) will correspond to the
% first index of the plateau of the ankle, the Hill Off (HO) to the last
% index of the plateau of the ankle and the same for the Toe (Toe Strike
% and Toe Off).
% We will thus only consider ANKLE and TOE.

% Creation of the threshold structs - We saw that the thresholds must be
% empirically set -- 
    %[struct_threshold] = create_thresholds_struct;
    %threshold_to_consider = struct_threshold; 

% SCI subjects
[SCI_subjects] = detect_gait_events_SCI(SCI_subjects,csv_files_NO_FLOAT_CRUTCHES,csv_files_FLOAT_NO_CRUTCHES,Fs_Kin,Fs_EMG);

%Split into gaits
[SCI_subjects] = split_into_gaits_SCI(SCI_subjects);

% Healthy 
[Healthy_subjects]= append_gait_events(Healthy_subjects,Fs_Kin,Fs_EMG);
[Healthy_subjects]= append_gait_cycles(Healthy_subjects,Fs_Kin,Fs_EMG);

%% Visualising steps
% figure;
% plot(Healthy_subjects.S_4.FLOAT.T_02.Parsed{1, 3}.Right.Kin.RTOE)
%% EMG parameters detection

% DECISION:
% We are taking subject 4 for everything BUT NO_FLOAT LMG (is shit)
% We are taking subject 5 for this LMG muscle.

muscles_4 = {'RGM','RTA','LTA'};
muscle_5 = 'LGM';
conditions = {'NO_FLOAT','FLOAT'};
trials = {'T_01','T_02','T_03'};

for condition = 1:length(conditions)
    new_struct = Healthy_subjects.('S_4').(conditions{condition});
end

for trial = 1:length(trials)
    current = new_struct.(trials{trial}).Left.Parsed;
    for gait = 1:3
        current{1,gait}.EMG.envelope.LMG =  Healthy_subjects.S_5.NO_FLOAT.(trials{trial}).Left.Parsed{1,gait}.EMG.envelope.LMG;
    end
end
%% We started to think about onset-offeset detection in EMG (WORK IN PROGRESS)

trials = {'T_01','T_02','T_03'};
legs = {'Right','Left'};
muscles = {'RMG','LMG','RTA','LTA'};

    for trial = 1:length(trials)
        for leg = 1:length(legs)
            
            if strcmp(legs{leg},'Right')
                muscles = {'RMG','RTA'};
            else
                muscles = {'LMG','LTA'};
            end
            
            current = new_struct.(trials{trial}).(legs{leg}).Parsed;
            
            for gait = 1:length(current)
                for muscle = 1:length(muscles)
                    cavia2 = current{1,gait}.EMG.envelope.(muscles{muscle});
%                     movcavia = movmean(cavia2,800);
%                     mean_value = mean(movcavia);
%                     [~,idx] = min(abs(movcavia - mean_value));
                    figure();
                    plot(cavia2)
                    title([trials{trial} ' ' legs{leg} ' Gait = ' num2str(gait) ' ' muscles{muscle}]);
%                     hold on
%                     plot(idx, cavia2(idx),'o')
                end
            end
        end
    end
 


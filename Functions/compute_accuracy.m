function [accuracy] = compute_accuracy(algorithm_struct,gt_struct,year)
% This function computes the accuracy of our detection algorithm for S_4
% subject of 2018 (to have an estimation).
%
% INPUTS: - algorithm_struct = is the struct with all the events computed
%                              with the event detection algorithm.
%         - gt_struct = is the struct with all the events found by visual
%                       detection
% OUTPUT: - accuracy = this is our estimation of the accuracy of our
%                      algorithm.

conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
legs = {'Right','Left'};
markers = {'HS_marker','HO_marker','TS_marker','TO_marker'};

% To initialize the accuracy
partial_nbr_events_overall = 0;
total_nbr_events_overall = 0;

% Points of difference to still consider correct detection
threshold = 25;

if strcmp(year,'2018')
    
    data_ground_truth = gt_struct.S_4;
    data_algorithm = algorithm_struct.S_4;
    
    for condition = 1:length(conditions)
        
        for trial = 1:length(trials)
            
            for leg = 1:length(legs)
                
                for marker = 1:length(markers)
                    
                    % To stock the markers events for ground truth and the
                    % ones for the algorithm
                    marker_gt = data_ground_truth.(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker});
                    marker_alg = data_algorithm.(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker});
                    
                    % Total number of events in the ground truth
                    total_nbr_events = length(marker_gt);
                    total_nbr_events_overall = total_nbr_events_overall + total_nbr_events;
                    
                    % Total number of events correctly classified by the
                    % algorithm wrt the ground truth
                    for i = 1: length(marker_gt)
                        
                        partial_nbr_events = sum(length(find(abs(marker_gt(i)-marker_alg)<threshold)));
                        partial_nbr_events_overall = partial_nbr_events_overall + partial_nbr_events;
                        
                    end
                    
                end
            end
        end
    end
    
% For Healthy subjects 2019
else
    
    % For Healthy 2019 there are 3 subjects
    index_subject = 3;
    
    for s = 1:length(index_subject)
        
        subject = ['S_' num2str(index_subject(s))];
        data_ground_truth = gt_struct.(subject);
        data_algorithm = algorithm_struct.(subject);
        
        for condition = 1:length(conditions)
            
            for trial = 1:length(trials)
                
                for leg = 1:length(legs)
                    
                    for marker = 1:length(markers)
                        % To stock the markers events for ground truth and the
                        % ones for the algorithm
                        marker_gt = data_ground_truth.(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker});
                        marker_alg = data_algorithm.(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker});
                        
                        % Total number of events in the ground truth
                        total_nbr_events = length(marker_gt);
                        total_nbr_events_overall = total_nbr_events_overall + total_nbr_events;
                        
                        % Total number of events correctly classified by the
                        % algorithm wrt the ground truth
                        for i = 1: length(marker_gt)
                            
                            partial_nbr_events = sum(length(find(abs(marker_gt(i)-marker_alg)<threshold)));
                            partial_nbr_events_overall = partial_nbr_events_overall + partial_nbr_events;
                            
                        end
                        
                    end
                end
            end
        end
    end
end
accuracy = partial_nbr_events_overall/total_nbr_events_overall;
end

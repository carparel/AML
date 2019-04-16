function [accuracy] = compute_accuracy(algorithm_struct,gt_struct,year)

% This function computes the accuracy of our detection algorithm for S_4
% subject of 2018 (to have a general idea)
%
% INPUTS: -algorithm_struct: is the struct with .Events computed with the
%                            algorithm
%         -gt_struct: is the struct with .Events computed with the ground
%                     truth
% OUTPUT: -accuracy: this is the measure of our accuracy


conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
legs = {'Right','Left'};
markers = {'HS_marker','HO_marker','TS_marker','TO_marker'};
acc_partial_overall = 0;
acc_total_overall = 0;
threshold = 25; % points of difference to still consider correct detection

if year == '2018'
    
    data_ground_truth = gt_struct.S_4;
    data_algorithm = algorithm_struct.S_4;
    
    for condition = 1:length(conditions)
        for trial = 1:length(trials)
            for leg = 1:length(legs)
                for marker = 1:length(markers)
                    
                    marker_gt = data_ground_truth.(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker});
                    marker_alg = data_algorithm.(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker});
                    acc_total = length(marker_gt);
                    acc_total_overall = acc_total_overall + acc_total;
                    
                    for i = 1: length(marker_gt)
                        acc_partial = sum(length(find(abs(marker_gt(i)-marker_alg)<threshold)));
                        acc_partial_overall = acc_partial_overall + acc_partial;
                    end
                    
                    
                end
            end
        end
    end
    
else
    index_subject = 3;
    for s = 1:length(index_subject)
        subject = ['S_' num2str(index_subject(s))];
        data_ground_truth = gt_struct.(subject);
        data_algorithm = algorithm_struct.(subject);
        
        for condition = 1:length(conditions)
            for trial = 1:length(trials)
                for leg = 1:length(legs)
                    for marker = 1:length(markers)
                        
                        marker_gt = data_ground_truth.(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker});
                        marker_alg = data_algorithm.(conditions{condition}).(trials{trial}).Event.(legs{leg}).(markers{marker});
                        acc_total = length(marker_gt);
                        acc_total_overall = acc_total_overall + acc_total;
                        
                        for i = 1: length(marker_gt)
                            acc_partial = sum(length(find(abs(marker_gt(i)-marker_alg)<threshold)));
                            acc_partial_overall = acc_partial_overall + acc_partial;
                            
                        end
                        
                        
                    end
                end
            end
        end
    end
end
accuracy = acc_partial_overall/acc_total_overall;
end

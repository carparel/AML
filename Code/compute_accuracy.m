function [accuracy] = compute_accuracy(algorithm_struct,gt_struct)

% This function computes the accuracy of our detection algorithm for S_4
% subject of 2018 (to have a general idea)
%
% INPUTS: -algorithm_struct: is the struct with .Events computed with the
%                            algorithm
%         -gt_struct: is the struct with .Events computed with the ground
%                     truth
% OUTPUT: -accuracy: this is the measure of our accuracy

data = Healthy_subjects.S_4;

conditions = {'NO_FLOAT', 'FLOAT'};
trials = {'T_01', 'T_02', 'T_03'};
legs = {'Right','Left'};
markers = {'HS_marker','HO_marker','TS_marker','TO_marker'};

for condition = 1:length(conditions)
    for trial = 1:length(trials)
        for leg = 1:length(legs)
            for marker = 1:length(markers)
                
            end
        end
    end
end













end

function [struct_threshold] = create_thresholds_struct;

conditions = {'NO_FLOAT', 'FLOAT'};
legs = {'right', 'left'};
marker = {'ankle', 'toe'};
% thresholds = [ %... ];

struct_threshold.Healthy.NO_FLOAT.right.ankle = 8;
struct_threshold.Healthy.NO_FLOAT.right.toe = 8;
struct_threshold.Healthy.NO_FLOAT.left.ankle = 8;
struct_threshold.Healthy.NO_FLOAT.left.toe = 8;

struct_threshold.Healthy.FLOAT.right.ankle = 4;
struct_threshold.Healthy.FLOAT.right.toe = 4;
struct_threshold.Healthy.FLOAT.left.ankle = 4;
struct_threshold.Healthy.FLOAT.left.toe = 4;


% To check for all the subjects... Indeed, the threshold changes a bit with the trials
end
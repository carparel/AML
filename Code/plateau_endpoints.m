function [strike, off] = plateau_endpoints(signal,threshold)
% 
% This function is used in order to detect the first and the last points of
% a plateau in a graph 
% INPUT : - signal = vector 1xTimePoints
%         - threshold = threshold for the detection of the points
% OUPUT : vector containing the initial point (strike) and final point
%         (off)

slope = {'positive','negative'};

if signal(end)-signal(1)>0 % If the signal is upwards, the slope is positive
    s = slope{1}; 
else
    s = slope{2};
end


figure;
plot(signal);
hold on
index = [1]; 
idx_final = [];
idx_initial = [];

for i = 1:length(signal)-1
    if strcmp('positive',s)
        if signal(i+1)-signal(i) > threshold 
            index = [index i+1];
        end
    else
        if signal(i)-signal(i+1) > threshold
            index = [index i+1];
        end  
    end
end


for i = 1:length(index)-1
    if index(i+1)-index(i)>1
        idx_final = [idx_final index(i+1)];
        idx_initial = [idx_initial index(i)];
    end
end
scatter(idx_final,signal(idx_final));
scatter(idx_initial,signal(idx_initial));

strike = idx_initial;
off = idx_final;
end 
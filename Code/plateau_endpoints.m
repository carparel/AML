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

index = [1]; 
off = [];
strike = [];
dist_strikes = [];
dist_offs = [];

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
        off = [off index(i+1)];
        strike = [strike index(i)];
        if length(strike)>1
            dist_strikes = [dist_strikes strike(end)-strike(end-1)];
        end
        if length(off)>1
            dist_offs = [dist_offs off(end)-off(end-1)];
        end
    end
end

%the following part allows to remove the wrongly detected gait events, i.e.
%the points that are to close to each other and thus can't truely reflect 
%the position of a new gait cycle
mean_dist_strikes = mean(dist_strikes);
mean_dist_offs = mean(dist_offs);
sufficient_dist_strikes = (dist_strikes(:))>0.8*mean_dist_strikes;
sufficient_dist_offs = (dist_offs(:))>0.8*mean_dist_offs;

for i = 2:length(dist_strikes)
    if (dist_strikes(i))<0.8*mean_dist_strikes
        strike(i) = [];
    end
end

for i = 2:length(dist_offs)
    if (dist_offs(i))<0.8*mean_dist_offs
        off(i+1) = [];
    end
end

end 
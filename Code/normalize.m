function [normalized_EMG] = normalize(Data)

% This function normalizes the signal with its maximum

normalized_EMG = Data/max(Data);

end
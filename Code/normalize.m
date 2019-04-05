function [normalized_EMG] = normalize(Data)

% This function removes artifacts and normalizes the signal with its maximum

Th = max(Data)/10;
for i=1:length(Data)
    if (abs(Data(i))<Th)
        Data(i)=0;
    end
end

normalized_EMG = Data/max(Data);

end
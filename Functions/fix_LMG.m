function [filtered_EMG] = fix_LMG(current,Fs_EMG)
% This function is used to remove artifacts from the muscle LMG in the SCI
% subjects.
%
% INPUT: - current = current LMG signal, which means that it is already the
%                    signal belonging to a specific trials of a specific 
%                    subject.
%        - Fs_EMG = the sampling frequency of EMG signals.
%
% OUTPUT: -filtered_EMG = updated filtered signal (without artifacts).

[PKS,LOCS] = findpeaks(current, 'MinPeakHeight',0.05,'MinPeakDistance',0.07*Fs_EMG);

for i = 1:length(PKS)
    if LOCS(i)>300
        current(LOCS(i)-100:LOCS(i)+100) = 0;
    else
        current(1:LOCS(i)+100) = 0;
    end
end

filtered_EMG = current;

end
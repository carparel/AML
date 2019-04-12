function [filtered_EMG] = fix_LMG(current,Fs)

[PKS,LOCS] = findpeaks(current, 'MinPeakHeight',0.05,'MinPeakDistance',0.07*Fs);

for i = 1:length(PKS)
    if LOCS(i)>300
        current(LOCS(i)-100:LOCS(i)+100) = 0;
    else
        current(1:LOCS(i)+100) = 0;
    end
end

filtered_EMG = current;

figure;
plot(current);

end
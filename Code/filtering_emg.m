function [filtered_emg] = filtering_emg(EMG_data,Fs,envelope)

% this function applies a band pass to data together with a notch filter to
% the power frequency
% fs is the sampling frequence, we need it to filter the signal

EMG_data= double(EMG_data);

% prefiltering
% the meaningful information is between 50 and 300 Hz so we take it with
% some margin

low_pass_cutoff=20;
high_pass_cutoff=350;

% normalizing frequencies for fs/2

bandpass_window(1) = low_pass_cutoff/(Fs/2);
bandpass_window(2) = high_pass_cutoff/(Fs/2);

% choosing the order of the filter
order=4;
[bpB, bpA] = butter(order, bandpass_window, 'bandpass');
bandpassed_EMG = filtfilt(bpB,bpA,EMG_data);

%notch
notch_window(1) = (50-2)/(Fs/2);
notch_window(2) = (50+2)/(Fs/2);
[nB, nA] = butter(order, notch_window, 'stop');
notch_EMG = filtfilt(nB,nA,bandpassed_EMG);

% rectify
rectified_EMG = abs(notch_EMG);

%envelope
%low pass filter with lower frequency (5 Hz)
if envelope == true
    envelope_frequency = 5/(Fs/2);
    [envB,envA] =  butter(order, envelope_frequency);
    filtered_emg = filtfilt(envB,envA,rectified_EMG);
else
    filtered_emg = rectified_EMG;

end

end
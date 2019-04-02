function [filtered_EMG] = filtering_EMG(EMG_data,Fs,envelope)

% Function filtering the signal EMG
%
% INPUTS: - EMG_data = vector signal (1xTimePoints) representing the EMG
%           for the single muscle taken into account (either TA or GM, for
%           both Right and Left leg)
%         - Fs = sampling frequency of the EMG recording.
%         - envelope = logical value (true or false) indicating whether the
%           signal of the already filtered EMG will be rectified and
%           enveloped with a 5 Hz signal or not
%
%
% OUTPUTS: - filtered_emg = vector signal (1xTimePoints) being filtered
%            and - if required - enveloped


EMG_data = double(EMG_data); 

% The meaningful EMG information stays between 50 Hz and 300 Hz. We take it
% thus with some margins (20-350) in order not to lose any physiologically
% relevant info

low_pass_cutoff = 20;
high_pass_cutoff = 350;

% The bandpass window in input to the Butterworth filter needs to be
% normalized by half the value of the sampling frequency 

bandpass_window(1) = low_pass_cutoff/(Fs/2);
bandpass_window(2) = high_pass_cutoff/(Fs/2);

% Order of the Butterworth filter

% Literature-based choice
order = 4; 

% BandPass Filter

% butter() returns the transfer function H(z) coefficients of the filter B(z) and A(z) 
[coeff_num_bp, coeff_denum_bp] = butter(order, bandpass_window, 'bandpass');
bandpassed_EMG = filtfilt(coeff_num_bp,coeff_denum_bp,EMG_data);

% Rectification: useful to compute the amplitude (in
% absolute value) of the EMG signal, without considering its negative
% component 

rectified_EMG = abs(bandpassed_EMG);

% Envelope: made with a LowPass filter with a cut-off frequency of 5 Hz in order
% to simplify and detect potentially meaningful features of the EMG signal.
% Made only if requested by the input

if envelope == true
    envelope_frequency = 5/(Fs/2); % Again need to be normalized for Fs/2
    [coeff_num_env,coeff_denum_env] =  butter(order, envelope_frequency);
    filtered_EMG = filtfilt(coeff_num_env,coeff_denum_env,rectified_EMG);
else
    filtered_EMG = bandpassed_EMG;
end

end


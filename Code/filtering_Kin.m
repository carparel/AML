function [lowpassed_Kin] = filtering_Kin(Kin_data,Fs)
% This function filters the signal from kinetic markers. We apply a low pass 
% Butterworth filter of 4th order.
% 
% INPUT: - Kin_data = the signal corresponding to one marker. 
%        - Fs = sampling frequency for the kinetic signals. 
%
% OUTPUT: lowpassed_Kin = signal low-pass filtered. 

Kin_data = double(Kin_data); 

low_pass_cutoff = 10;

% The lowpass window in input to the Butterworth filter needs to be
% normalized by half the value of the sampling frequency 

lowpass_window = low_pass_cutoff/(Fs/2);

% Order of the Butterworth filter
% Literature-based choice
order = 4; 

% Lowpass filter

% butter() returns the transfer function H(z) coefficients of the filter B(z) and A(z) 
[coeff_num_lp,coeff_denum_lp] = butter(order,lowpass_window);
lowpassed_Kin = filtfilt(coeff_num_lp,coeff_denum_lp,Kin_data);

end
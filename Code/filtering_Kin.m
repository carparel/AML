function [lowpassed_Kin] = filtering_Kin(Kin_data,Fs)

% Function filtering the signal of the markers -> kinetics signals
%
% INPUTS: 
%
%
% OUTPUTS:

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
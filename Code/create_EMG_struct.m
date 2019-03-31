function [Struct_EMG] = create_EMG_struct(raw_struct,type)
% To have a more compact structure containing the EMG data (only the
% muscles we are interested in) 
%
%
% INPUTS : - raw_struct = the structure contianing all the fields. It's the
%            structure from which you want to sort some data.
%          - type = You can choose between 'SCI' and 'Healthy'.
%
if strcmp(type,'SCI')
    % EMG data for SCI Subjects FLOAT_NO_CRUTCHES
    T01_LMG = raw_struct.FLOAT_NO_CRUTCHES.T_01.Raw.EMG.LMG;
    T01_RMG = raw_struct.FLOAT_NO_CRUTCHES.T_01.Raw.EMG.RMG; 
    T01_LTA = raw_struct.FLOAT_NO_CRUTCHES.T_01.Raw.EMG.LTA; 
    T01_RTA = raw_struct.FLOAT_NO_CRUTCHES.T_01.Raw.EMG.RTA; 

    T02_LMG = raw_struct.FLOAT_NO_CRUTCHES.T_02.Raw.EMG.LMG;
    T02_RMG = raw_struct.FLOAT_NO_CRUTCHES.T_02.Raw.EMG.RMG; 
    T02_LTA = raw_struct.FLOAT_NO_CRUTCHES.T_02.Raw.EMG.LTA; 
    T02_RTA = raw_struct.FLOAT_NO_CRUTCHES.T_02.Raw.EMG.RTA; 

    T03_LMG = raw_struct.FLOAT_NO_CRUTCHES.T_03.Raw.EMG.LMG;
    T03_RMG = raw_struct.FLOAT_NO_CRUTCHES.T_03.Raw.EMG.RMG; 
    T03_LTA = raw_struct.FLOAT_NO_CRUTCHES.T_03.Raw.EMG.LTA; 
    T03_RTA = raw_struct.FLOAT_NO_CRUTCHES.T_03.Raw.EMG.RTA; 

    Struct_EMG.FLOAT_NO_CRUTCHES.T01.LMG = T01_LMG;
    Struct_EMG.FLOAT_NO_CRUTCHES.T01.RMG = T01_RMG;
    Struct_EMG.FLOAT_NO_CRUTCHES.T01.LTA = T01_LTA;
    Struct_EMG.FLOAT_NO_CRUTCHES.T01.RTA = T01_RTA;
    
    Struct_EMG.FLOAT_NO_CRUTCHES.T02.LMG = T02_LMG;
    Struct_EMG.FLOAT_NO_CRUTCHES.T02.RMG = T02_RMG;
    Struct_EMG.FLOAT_NO_CRUTCHES.T02.LTA = T02_LTA;
    Struct_EMG.FLOAT_NO_CRUTCHES.T02.RTA = T02_RTA;
    
    Struct_EMG.FLOAT_NO_CRUTCHES.T03.LMG = T03_LMG;
    Struct_EMG.FLOAT_NO_CRUTCHES.T03.RMG = T03_RMG;
    Struct_EMG.FLOAT_NO_CRUTCHES.T03.LTA = T03_LTA;
    Struct_EMG.FLOAT_NO_CRUTCHES.T03.RTA = T03_RTA;
    
    % EMG data for SCI Subjects NO_FLOAT_CRUTCHES
    T01_LMG = raw_struct.NO_FLOAT_CRUTCHES.T_01.Raw.EMG.LMG;
    T01_RMG = raw_struct.NO_FLOAT_CRUTCHES.T_01.Raw.EMG.RMG; 
    T01_LTA = raw_struct.NO_FLOAT_CRUTCHES.T_01.Raw.EMG.LTA; 
    T01_RTA = raw_struct.NO_FLOAT_CRUTCHES.T_01.Raw.EMG.RTA; 

    T02_LMG = raw_struct.NO_FLOAT_CRUTCHES.T_02.Raw.EMG.LMG;
    T02_RMG = raw_struct.NO_FLOAT_CRUTCHES.T_02.Raw.EMG.RMG; 
    T02_LTA = raw_struct.NO_FLOAT_CRUTCHES.T_02.Raw.EMG.LTA; 
    T02_RTA = raw_struct.NO_FLOAT_CRUTCHES.T_02.Raw.EMG.RTA; 

    T03_LMG = raw_struct.NO_FLOAT_CRUTCHES.T_03.Raw.EMG.LMG;
    T03_RMG = raw_struct.NO_FLOAT_CRUTCHES.T_03.Raw.EMG.RMG; 
    T03_LTA = raw_struct.NO_FLOAT_CRUTCHES.T_03.Raw.EMG.LTA; 
    T03_RTA = raw_struct.NO_FLOAT_CRUTCHES.T_03.Raw.EMG.RTA; 
    
    Struct_EMG.NO_FLOAT_CRUTCHES.T01.LMG = T01_LMG;
    Struct_EMG.NO_FLOAT_CRUTCHES.T01.RMG = T01_RMG;
    Struct_EMG.NO_FLOAT_CRUTCHES.T01.LTA = T01_LTA;
    Struct_EMG.NO_FLOAT_CRUTCHES.T01.RTA = T01_RTA;
    
    Struct_EMG.NO_FLOAT_CRUTCHES.T02.LMG = T02_LMG;
    Struct_EMG.NO_FLOAT_CRUTCHES.T02.RMG = T02_RMG;
    Struct_EMG.NO_FLOAT_CRUTCHES.T02.LTA = T02_LTA;
    Struct_EMG.NO_FLOAT_CRUTCHES.T02.RTA = T02_RTA;
    
    Struct_EMG.NO_FLOAT_CRUTCHES.T03.LMG = T03_LMG;
    Struct_EMG.NO_FLOAT_CRUTCHES.T03.RMG = T03_RMG;
    Struct_EMG.NO_FLOAT_CRUTCHES.T03.LTA = T03_LTA;
    Struct_EMG.NO_FLOAT_CRUTCHES.T03.RTA = T03_RTA;
end

if strcmp(type,'Healthy')
    % EMG data for Realthy Subjects FLOAT
    T01_LMG = raw_struct.FLOAT{4}.S4_FLOAT.T_01.Raw.EMG.LMG;
    T01_RMG = raw_struct.FLOAT{4}.S4_FLOAT.T_01.Raw.EMG.RMG;
    T01_LTA = raw_struct.FLOAT{4}.S4_FLOAT.T_01.Raw.EMG.LTA;
    T01_RTA = raw_struct.FLOAT{4}.S4_FLOAT.T_01.Raw.EMG.RTA;
    
    T02_LMG = raw_struct.FLOAT{4}.S4_FLOAT.T_02.Raw.EMG.LMG;
    T02_RMG = raw_struct.FLOAT{4}.S4_FLOAT.T_02.Raw.EMG.RMG;
    T02_LTA = raw_struct.FLOAT{4}.S4_FLOAT.T_02.Raw.EMG.LTA;
    T02_RTA = raw_struct.FLOAT{4}.S4_FLOAT.T_02.Raw.EMG.RTA;
    
    T03_LMG = raw_struct.FLOAT{4}.S4_FLOAT.T_03.Raw.EMG.LMG;
    T03_RMG = raw_struct.FLOAT{4}.S4_FLOAT.T_03.Raw.EMG.RMG;
    T03_LTA = raw_struct.FLOAT{4}.S4_FLOAT.T_03.Raw.EMG.LTA;
    T03_RTA = raw_struct.FLOAT{4}.S4_FLOAT.T_03.Raw.EMG.RTA;
    
    Struct_EMG.FLOAT.T01.LMG = T01_LMG;
    Struct_EMG.FLOAT.T01.RMG = T01_RMG;
    Struct_EMG.FLOAT.T01.LTA = T01_LTA;
    Struct_EMG.FLOAT.T01.RTA = T01_RTA;
    
    Struct_EMG.FLOAT.T02.LMG = T02_LMG;
    Struct_EMG.FLOAT.T02.RMG = T02_RMG;
    Struct_EMG.FLOAT.T02.LTA = T02_LTA;
    Struct_EMG.FLOAT.T02.RTA = T02_RTA;
    
    Struct_EMG.FLOAT.T03.LMG = T03_LMG;
    Struct_EMG.FLOAT.T03.RMG = T03_RMG;
    Struct_EMG.FLOAT.T03.LTA = T03_LTA;
    Struct_EMG.FLOAT.T03.RTA = T03_RTA;
    
    % EMG data for Realthy Subjects NO_FLOAT
    T01_LMG = raw_struct.NO_FLOAT{4}.S4_NO_FLOAT.T_01.Raw.EMG.LMG;
    T01_RMG = raw_struct.NO_FLOAT{4}.S4_NO_FLOAT.T_01.Raw.EMG.RMG;
    T01_LTA = raw_struct.NO_FLOAT{4}.S4_NO_FLOAT.T_01.Raw.EMG.LTA;
    T01_RTA = raw_struct.NO_FLOAT{4}.S4_NO_FLOAT.T_01.Raw.EMG.RTA;
    
    T02_LMG = raw_struct.NO_FLOAT{4}.S4_NO_FLOAT.T_02.Raw.EMG.LMG;
    T02_RMG = raw_struct.NO_FLOAT{4}.S4_NO_FLOAT.T_02.Raw.EMG.RMG;
    T02_LTA = raw_struct.NO_FLOAT{4}.S4_NO_FLOAT.T_02.Raw.EMG.LTA;
    T02_RTA = raw_struct.NO_FLOAT{4}.S4_NO_FLOAT.T_02.Raw.EMG.RTA;
    
    T03_LMG = raw_struct.NO_FLOAT{4}.S4_NO_FLOAT.T_03.Raw.EMG.LMG;
    T03_RMG = raw_struct.NO_FLOAT{4}.S4_NO_FLOAT.T_03.Raw.EMG.RMG;
    T03_LTA = raw_struct.NO_FLOAT{4}.S4_NO_FLOAT.T_03.Raw.EMG.LTA;
    T03_RTA = raw_struct.NO_FLOAT{4}.S4_NO_FLOAT.T_03.Raw.EMG.RTA;
    
    Struct_EMG.NO_FLOAT.T01.LMG = T01_LMG;
    Struct_EMG.NO_FLOAT.T01.RMG = T01_RMG;
    Struct_EMG.NO_FLOAT.T01.LTA = T01_LTA;
    Struct_EMG.NO_FLOAT.T01.RTA = T01_RTA;
    
    Struct_EMG.NO_FLOAT.T02.LMG = T02_LMG;
    Struct_EMG.NO_FLOAT.T02.RMG = T02_RMG;
    Struct_EMG.NO_FLOAT.T02.LTA = T02_LTA;
    Struct_EMG.NO_FLOAT.T02.RTA = T02_RTA;
    
    Struct_EMG.NO_FLOAT.T03.LMG = T03_LMG;
    Struct_EMG.NO_FLOAT.T03.RMG = T03_RMG;
    Struct_EMG.NO_FLOAT.T03.LTA = T03_LTA;
    Struct_EMG.NO_FLOAT.T03.RTA = T03_RTA;
end

end


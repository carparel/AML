function [Struct_EMG] = create_EMG_struct_filtered(EMG_signal,Fs,envelope)

    T01_LMG_F = filtering_emg(EMG_signal.FLOAT.T01.LMG,Fs,envelope);
    T01_RMG_F = filtering_emg(EMG_signal.FLOAT.T01.RMG,Fs,envelope);
    T01_LTA_F = filtering_emg(EMG_signal.FLOAT.T01.LTA,Fs,envelope);
    T01_RTA_F = filtering_emg(EMG_signal.FLOAT.T01.RTA,Fs,envelope);
    
    T02_LMG_F = filtering_emg(EMG_signal.FLOAT.T02.LMG,Fs,envelope);
    T02_RMG_F = filtering_emg(EMG_signal.FLOAT.T02.RMG,Fs,envelope);
    T02_LTA_F = filtering_emg(EMG_signal.FLOAT.T02.LTA,Fs,envelope);
    T02_RTA_F = filtering_emg(EMG_signal.FLOAT.T02.RTA,Fs,envelope);
    
    T03_LMG_F = filtering_emg(EMG_signal.FLOAT.T03.LMG,Fs,envelope);
    T03_RMG_F = filtering_emg(EMG_signal.FLOAT.T03.RMG,Fs,envelope);
    T03_LTA_F = filtering_emg(EMG_signal.FLOAT.T03.LTA,Fs,envelope);
    T03_RTA_F = filtering_emg(EMG_signal.FLOAT.T03.RTA,Fs,envelope);
    
    T01_LMG_NF = filtering_emg(EMG_signal.NO_FLOAT.T01.LMG,Fs,envelope);
    T01_RMG_NF = filtering_emg(EMG_signal.NO_FLOAT.T01.RMG,Fs,envelope);
    T01_LTA_NF = filtering_emg(EMG_signal.NO_FLOAT.T01.LTA,Fs,envelope);
    T01_RTA_NF = filtering_emg(EMG_signal.NO_FLOAT.T01.RTA,Fs,envelope);
    
    T02_LMG_NF = filtering_emg(EMG_signal.NO_FLOAT.T02.LMG,Fs,envelope);
    T02_RMG_NF = filtering_emg(EMG_signal.NO_FLOAT.T02.RMG,Fs,envelope);
    T02_LTA_NF = filtering_emg(EMG_signal.NO_FLOAT.T02.LTA,Fs,envelope);
    T02_RTA_NF = filtering_emg(EMG_signal.NO_FLOAT.T02.RTA,Fs,envelope);
    
    T03_LMG_NF = filtering_emg(EMG_signal.NO_FLOAT.T03.LMG,Fs,envelope);
    T03_RMG_NF = filtering_emg(EMG_signal.NO_FLOAT.T03.RMG,Fs,envelope);
    T03_LTA_NF = filtering_emg(EMG_signal.NO_FLOAT.T03.LTA,Fs,envelope);
    T03_RTA_NF = filtering_emg(EMG_signal.NO_FLOAT.T03.RTA,Fs,envelope);
    
    Struct_EMG.FLOAT.T01.LMG = T01_LMG_F;
    Struct_EMG.FLOAT.T01.RMG = T01_RMG_F;
    Struct_EMG.FLOAT.T01.LTA = T01_LTA_F;
    Struct_EMG.FLOAT.T01.RTA = T01_RTA_F;
    
    Struct_EMG.FLOAT.T02.LMG = T02_LMG_F;
    Struct_EMG.FLOAT.T02.RMG = T02_RMG_F;
    Struct_EMG.FLOAT.T02.LTA = T02_LTA_F;
    Struct_EMG.FLOAT.T02.RTA = T02_RTA_F;
    
    Struct_EMG.FLOAT.T03.LMG = T03_LMG_F;
    Struct_EMG.FLOAT.T03.RMG = T03_RMG_F;
    Struct_EMG.FLOAT.T03.LTA = T03_LTA_F;
    Struct_EMG.FLOAT.T03.RTA = T03_RTA_F;

    Struct_EMG.NO_FLOAT.T01.LMG = T01_LMG_NF;
    Struct_EMG.NO_FLOAT.T01.RMG = T01_RMG_NF;
    Struct_EMG.NO_FLOAT.T01.LTA = T01_LTA_NF;
    Struct_EMG.NO_FLOAT.T01.RTA = T01_RTA_NF;
    
    Struct_EMG.NO_FLOAT.T02.LMG = T02_LMG_NF;
    Struct_EMG.NO_FLOAT.T02.RMG = T02_RMG_NF;
    Struct_EMG.NO_FLOAT.T02.LTA = T02_LTA_NF;
    Struct_EMG.NO_FLOAT.T02.RTA = T02_RTA_NF;
    
    Struct_EMG.NO_FLOAT.T03.LMG = T03_LMG_NF;
    Struct_EMG.NO_FLOAT.T03.RMG = T03_RMG_NF;
    Struct_EMG.NO_FLOAT.T03.LTA = T03_LTA_NF;
    Struct_EMG.NO_FLOAT.T03.RTA = T03_RTA_NF;

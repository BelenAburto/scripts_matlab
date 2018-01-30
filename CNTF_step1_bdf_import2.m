function step1_bdf_import2

%% pabgaspar@gmail.com 5/08/10
%% updafunction installRes = plugin_askinstall(pluginName, pluginFunc, forceInstall)ted pgaspar & mbaburto 12/29/2014 epoch the data based on erplab bins and reref the channels and define the channels locations.
%% pgaspar 29/07/2015 import biosemi pdf data using biosig toolbox. To run you have to download first biosig plug in from eeglab -->> import data


clc
clear all

% variables
eeglab;
path = ('/home/psiquislab/Documents/Double_flash/DBF_tiempofrec/Patients/FEP/');
%path = ('/home/psiquislab/Documents/Double_flash/DBF/control/CNTF/');
%task = {'ATTFREQ_R1'};
name = {'FEP_010','FEP_011'};%'FEP_001','FEP_002','FEP_005','FEP_006','FEP_007'
%name = {'CNTF_007','CNTF_005','CNTF_006','CNTF_004','CNTF_001','CNTF_008','CNTF_009','CNTF_010'};
runs = 1;
%     EEG = [];
%     ALLEEG = [];
%     CURRENTEEG = [];

%for h=1:length(task);
    for n=1:length(name);
        for j=1:runs;
           path2= sprintf('%s%s/',path,name{n});
             cd (path2);
            name_bdf= sprintf('%s_DBF_R%d.bdf',name{n},j); % create a input_name (bdf name) and path
            name_set= sprintf('%s_DBF_R%d.set',name{n},j); % creat a output_name (set name)
            EEG = pop_biosig(name_bdf,'ref',65);
            EEG = eeg_checkset( EEG );
            EEG = pop_resample( EEG, 512);
            EEG = eeg_checkset( EEG );
            EEG = pop_basicfilter( EEG,  1:72 , 'Cutoff', [ 0 100], 'Design', 'butter', 'Filter', 'bandpass', 'Order',  2 ); % GUI: 10-Feb-2015 17:19:31
            EEG = eeg_checkset( EEG );
            EEG = pop_saveset( EEG, 'filename',name_set);
            EEG = eeg_checkset( EEG );
        end;
    end;
%     EEG = [];
%     ALLEEG = [];
%     CURRENTEEG = [];
%end;

function step3_DBF_Epoch

%% pablo.gaspar@gmail.com 5/08/10
%% updated pgaspar & mbaburto 12/29/2014 epoch the data based on erplab bins and reref the channels and define the channels locations.
%%update hay que poner en el path la carpeta donde salen los archivos tambien cambie el numero de runs (el mioo solo es uno)28/12/15
clc         
clear all
path ='/home/psiquislab/Documents/Double_flash/DBF/control/CNTA'; 
runs = 1;
name = {'CNTA_007'};%'CNTA_002','CNTA_001','CNTA_008','CNTA_005','CNTA_006'
%task = {'ATTFREQ'};
%for h=1:length(task);
    for n=1:length(name)
        for j=1:runs
            ext = {'.set'};
            base2= sprintf('%s%s/',path,name{n});
            A=sprintf('%s_DBF_R%d.set',name{n},j);
            EEG = pop_loadset( 'filename', A, 'filepath', base2);
            %ERPLAB functions
            EEG  = pop_creabasiceventlist( EEG , 'AlphanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' } ); % GUI: 29-Dec-2014 12:28:04
            EEG = eeg_checkset( EEG );
            EEG = pop_chanedit (EEG,  'load', {'/home/psiquislab/Documents/Double_flash/biosem72chan2.loc', 'filetype', 'loc'}); %GUI: 29-Dec-2015 12:43 Belén, no poner autodetect, sino el tipo de archivo
            EEG = eeg_checkset( EEG );
            %EEG = pop_reref( EEG, [], 'exclude', [65 66 67 68 69 70 71 72]);
            %EEG = eeg_checkset( EEG );(03-03-16)
            EEG  = pop_binlister( EEG , 'BDF', '/home/psiquislab/Documents/Double_flash/DFpostantigonapostmodificacion.txt', 'IndexEL',  1, 'SendEL2', 'Workspace&EEG', 'UpdateEEG', 'on', 'Voutput', 'EEG' ); % GUI: 29-Jul-2015 01:34:04
            EEG = eeg_checkset( EEG );
            EEG = pop_epochbin( EEG, [-200 1000],'pre');
            EEG = eeg_checkset( EEG );
            %    EEG.data = EEG.data([1:30 32:64],:,:);
            %   EEG = eeg_checkset( EEG );
            B= sprintf ('%s_ep_DBF_R%d.set',name{n},j);
            EEG = pop_saveset(EEG, 'filename', B, 'filepath', base2);
        end;
        EEG = [];
        ALLEEG = [];
        CURRENTEEG = [];
        disp('Ha finalizado');

    end;
            
%end;
%EEG= pop_basicfilter( EEG,1:72 , 'Boundary', 'boundary', 'Cutoff', [ 0.1 30], 'Design', 'butter', 'Filter', 'bandpass', 'Order',2 );% Script: 29-Jul-2015 01:07:07
% EEG = pop_loadset('filename','DSM_ATTFREQ_R1.set','filepath','/Users/Diego/Desktop/EEG/FONDECYT/Pacientes/DSM/');
% EEG = eeg_checkset( EEG );
% EEG  = pop_creabasiceventlist( EEG , 'AlpDFSYLhanumericCleaning', 'on', 'BoundaryNumeric', { -99 }, 'BoundaryString', { 'boundary' } ); % GUI: 29-Jul-2015 01:33:46
% EEG = eeg_checkset( EEG );
% EEG = eeg_checkset( EEG );
% EEG  = pop_binlister( EEG , 'BDF', '/Users/Diego/Dropbox/Academia/scripts/EEGLAB_scripts/bdf/attfreq-cue-bdf.txt', 'IndexEL',  1, 'SendEL2', 'Workspace&EEG', 'UpdateEEG', 'on', 'Voutput', 'EEG' ); % GUI: 29-Jul-2015 01:34:04
% EEG = eeg_checkset( EEG );
% EEG = pop_epochbin( EEG , [-250.0  500.0],  'pre'); % GUI: 29-Jul-2015 01:34:18
% EEG = eeg_checkset( EEG );

function step4_DBF_ArtRej

% This script runs an artifact rejection based on ArtRej script in ERPLAB. 
% Please read eeglab tutorial and ERPlab tutorial to change the settings.
% Output are two set files. The first one has all epochs, but flagged the bad epochs (AD = Artifact detection). The second output has only the cleanned epochs (artifact rejected). 
%% pablo.gaspar@gmail.com 3/09/11

clc
clear all
base = '/home/psiquislab/Documents/Double_flash/DBF/control/CNTA';

name = {'CNTA_007'};%'CNTA_006','CNTA_002','CNTA_001','CNTA_008','CNTA_005'
runs = 1;
tepoch = [-200 1000];
 ALLEEG = [];
 EEG= [];
 CURRENTSET = [];
   
for n=1:length(name)
    for j=1:runs
    base2= sprintf('%s/',base,name{n});
    A=sprintf('%s_ep_DBF_R%d.set',name{n},j);
    EEG = pop_loadset( 'filename', A, 'filepath', base2);
    
    
%         base2= sprintf('%s%s',base,name{n},j);
%         A=sprintf('%s_ICA_ep_ATTFREQ_R%d.set',name{n},j);
%         EEG = pop_loadset( 'filename', A, 'filepath', base2);
        [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
       % cd (path2);      
        %EEG = pop_select( EEG,'nochannel',{'EXG1' 'EXG2' 'EXG3' 'EXG4' 'EXG5' 'EXG6' 'EXG7' 'EXG8'});
        EEG = eeg_checkset( EEG );
        EEG  = pop_artstep( EEG , 'Channel',  1:64, 'Flag',  8, 'Threshold',  300, 'Twindow',tepoch, 'Windowsize',  200, 'Windowstep',  50 ); % GUI: 31-Jul-2015 20:50:09
       % EEG = pop_sincroartifacts(EEG, 1);
       
       
       
       
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
        EEG = eeg_checkset( EEG );
        EEG  = pop_artmwppth( EEG , 'Channel',  1:64, 'Flag',  8, 'Threshold',  400, 'Twindow', tepoch, 'Windowsize',  200, 'Windowstep',  100 ); % GUI: 31-Jul-2015 20:48:02 %modificado el tepoch por[-200 500]-cambie flag 1 por 8:30/12/15
      %  EEG = pop_sincroartifacts(EEG, 2);
      
      
       % [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
        
       
       
        EEG = eeg_checkset( EEG );
        
        EEG  = pop_artextval( EEG , 'Channel',  1:64, 'Flag',  8, 'Threshold', [-1000 1000], 'Twindow', tepoch); % GUI: 31-Jul-2015 20:47:16 %--cambie flag 1 por 8:30/12/15
      %  EEG = pop_sincroartifacts(EEG, 3);
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
        EEG = eeg_checkset( EEG );
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
        %EEG = pop_reref( EEG, [16 53] );
        % siguiente linea por EXG1 y EXG2: Modificado por RMT 1/1/16
        EEG = pop_reref( EEG, [], 'keepref','on' );%Vuelve a referenciar sin borrar los canales/ modificado por RMT 2/2/16
        EEG = eeg_checkset( EEG );
        [ALLEEG EEG CURRENTSET] = pop_newset(ALLEEG, EEG, 1,'overwrite','on','gui','off');
        %  pop_summary_AR_eeg_detection(EEG);
        B= sprintf ('%s_artWithout_ep_DBF_R%d.set',name{n}); %%%% ALL EPOCHS WITHOUT REJECTION
        EEG = pop_saveset(EEG, 'filename', B, 'filepath', base2);
        indexmepoch = detmarkedepoch(EEG); % make sure detmarkedepoch.m exists in /eeglab_xxx/plugins/erplab_xxx/functions
        EEG  = pop_rejepoch( EEG, indexmepoch, 0);
        EEG = eeg_checkset( EEG );
        C= sprintf ('%s_art_ep_DBF_R%d.set',name{n},j);  %%%% ONLY CLEANED EPOCHS
        EEG = pop_saveset(EEG, 'filename', C, 'filepath', base2);
        EEG = [];
        ALLEEG = [];
        CURRENTEEG = [];
    end;
    disp('Ha finalizado')

end;


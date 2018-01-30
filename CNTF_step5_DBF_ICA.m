
function step3_DBF_ICA

clc
clear all
%cd  /home/pablo/ANALISIS/EEG/COFREQ/CONTROLS/AJS
base = '/home/psiquislab/Documents/Double_flash/DBF/control/CNTF';

name = {'CNTF_006_inter'};%interpolacion antes y despues del artreject 'CNTF_007','CNTF_005_inter2','CNTF_001','CNTF_004','CNTF_008_inter','CNTF_009','CNTF_010_inter'
runs = 1;
 ALLEEG = [];
 EEG= [];
 CURRENTSET = [];
for n=1:length(name)
    for j=1:runs;
    ext = {'.set'};
    base2= sprintf('%s/',base,name{n});
    A=sprintf('%s_art_ep_DBF_R%d.set',name{n},j);
    EEG = pop_loadset( 'filename', A, 'filepath', base2);
    %EEG = pop_chanedit (EEG,  'load', {'/home/psiquislab/Documents/Double_flash/biosem72chan2.loc', 'filetype', 'loc'}); %GUI: 29-Dec-2015 12:43 Belén, no poner autodetect, sino el tipo de archivo
    %EEG=pop_chanedit(EEG, 'load',{'/Users/Diego/Dropbox/Academia/scripts/EEGLAB_scripts/attfreq/biosem72chan2.txt' 'filetype' 'loc'});
    [ALLEEG, EEG, CURRENTSET] = eeg_store( ALLEEG, EEG, 0 );
    EEG = eeg_checkset( EEG );
    EEG = pop_runica(EEG,  'icatype', 'runica','chanind',[1:72], 'options',{ 'extended',1});
    %EEG = pop_selectcomps(EEG, [1:20] );
    EEG = eeg_checkset( EEG );
    B= sprintf ('%s_ICA_art_ep_DBF_R%d.set',name{n},j);
    EEG = pop_saveset(EEG, 'filename', B, 'filepath', base2);
   % end
    EEG = [];
    ALLEEG = [];
    CURRENTEEG = [];
    end;
end

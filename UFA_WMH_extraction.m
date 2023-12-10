function UFA_WMH_extraction(studyDir,CNSP_path,spm12path,chos)

% Source code from UBO Detector
% Reference: 2018_NeuroImage_UBO Detector-A cluster-based, fully automated pipeline for extracting white matter hyperintensities
% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14

addpath(genpath(CNSP_path));

fprintf ('UBO Detector: Starting WMH extraction pipeline (with QC stops) ...\n');

% studyDir= 'xxx/test_WMH';
% CNSP_path = '/home/zhenggaoxing/Public/NeuroImage_toolbox/CNS';
% spm12path= '/home/zhenggaoxing/Public/Neuroimage_toolbox/spm12';


%% select the output format
% chos = input('please input the output format[0-web, 1-arch, 2-both]: ');

if isempty(chos),chos = 0;
end

if ismember(chos,[0 1 2]),valid = 1;
else
    disp('Enrty invalid, must be an integer 0, 1, 2')
end

switch chos
    case 0
        outputFormat = 'web';
    case 1
        outputFormat = 'arch';
    case 2
        outputFormat = 'web&arch';
    otherwise
        error ('Please specify how you want to perform the QC steps.');
end

%% copy the original T1 and FLAIR file into new folder

% if previously processed, copy T1 and FLAIR folders to studyFolder,
% delete subjects dir
if exist([studyDir '/originalImg'],'dir') == 7
    movefile ([studyDir '/originalImg/T1'], [studyDir '/T1']);
    movefile ([studyDir '/originalImg/FLAIR'], [studyDir '/FLAIR']);
    rmdir ([studyDir '/originalImg'],'s');
end

if exist ([studyDir '/subjects'],'dir') == 7
    rmdir ([studyDir '/subjects'],'s');
end

%% run the Stage 1 main script
progressOutput = WMHextraction_main_inGUI_Stage1 (studyDir, spm12path, outputFormat);

coregExcldList = '';
%% run the Stage 2 main script
progressOutput = WMHextraction_main_inGUI_Stage2 (studyDir, spm12path, progressOutput, coregExcldList, outputFormat);

dartelTemplate = 'existing template'; % other choice : 'creating template','native template'
k = 5;
PVWMH_magnitude = '12'; % mm
segExcldList = '';
classifier = 'built-in'; % other choice : 'customised'
ageRange = '70to80'; % other choice : 'lt55'; '65to75'
probThr = 0.7;
trainingFeatures1 = 1:9;
trainingFeatures2 = 10:12;

%% run the Stage 3 main script

progressOutput = WMHextraction_main_inGUI_Stage3 (studyDir, spm12path, CNSP_path, dartelTemplate, k, PVWMH_magnitude, progressOutput, coregExcldList, segExcldList, classifier, ageRange, probThr, trainingFeatures1, trainingFeatures2, outputFormat);

end
%% Stage 1

function progressOutput = WMHextraction_main_inGUI_Stage1 (studyFolder, spm12path, outputFormat)
    progressOutput = [];
    
    tic;
    nsegs=3;
    addpath (spm12path);

    progressOutputCellArray_Stage1 {:} = ''; % reset output
    progressOutputCellArray_Stage1 {1} = '*******************************************';
    progressOutputCellArray_Stage1 {end+1} = '        WMH extraction pipeline        ';
    progressOutputCellArray_Stage1 {end+1} = '*******************************************';
    progressOutputCellArray_Stage1 {end+1} = '           Neuroimaging Lab            ';
    progressOutputCellArray_Stage1 {end+1} = '   Centre for Healthy Brain Ageing   ';
    progressOutputCellArray_Stage1 {end+1} = '*******************************************';
    progressOutputCellArray_Stage1 {end+1} = '';
    
    progressOutput =  [progressOutput,progressOutputCellArray_Stage1];
    drawnow;
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    %% Organising folders %%
    %%%%%%%%%%%%%%%%%%%%%%%%

    progressOutputCellArray_Stage1 {end+1} = 'Organising folders ...';
    progressOutput = [progressOutput, progressOutputCellArray_Stage1];
    drawnow;

    % create originalImg folder, and move T1 and FLAIR to originalImg
    mkdir (studyFolder, 'originalImg');
    movefile (strcat (studyFolder,'/T1'), strcat (studyFolder,'/originalImg'), 'f'); % move T1 folder to originalImg folder
    movefile (strcat (studyFolder,'/FLAIR'), strcat (studyFolder,'/originalImg'), 'f'); % move FLAIR folder to originalImg folder
   
    % create subjects folder, 
    mkdir (studyFolder, 'subjects');
    
    % gunzip niftis
%     cmd_gunzip_T1 = ['gunzip ' studyFolder '/originalImg/T1/*'];
%     cmd_gunzip_FLAIR = ['gunzip ' studyFolder '/originalImg/FLAIR/*'];
%     system (cmd_gunzip_T1);
%     system (cmd_gunzip_FLAIR);


    % list all T1 and FLAIR (may be .nii.gz)
    T1folder = dir (strcat (studyFolder,'/originalImg/T1/*.nii*'));
    FLAIRfolder = dir (strcat (studyFolder,'/originalImg/FLAIR/*.nii*'));
    [Nsubj,n] = size (T1folder);
    
    % gunzip niftis
    parfor i = 1:Nsubj
        CNSP_gunzipnii ([studyFolder '/originalImg/T1/' T1folder(i).name]);
        CNSP_gunzipnii ([studyFolder '/originalImg/FLAIR/' FLAIRfolder(i).name]);
    end



    T1folder = dir (strcat (studyFolder,'/originalImg/T1/*.nii'));
    FLAIRfolder = dir (strcat (studyFolder,'/originalImg/FLAIR/*.nii'));
    [Nsubj,n] = size (T1folder);


    % create a folder for each subject under subjects
    % folder, using ID as folder name. Copy corresponding T1 and FLAIR to the
    % orig folder of each subject
    parfor i = 1:Nsubj
        T1imgNames = strsplit (T1folder(i).name, '_');   % split T1 image name, delimiter is underscore
        ID = T1imgNames{1};   % first section is ID
        mkdir (strcat(studyFolder,'/subjects/',ID,'/mri'),'orig');  % create orig folder under each subject folder
        copyfile (strcat (studyFolder,'/originalImg/T1/', T1folder(i).name), strcat(studyFolder,'/subjects/',ID,'/mri/orig/'));        % copy T1 to each subject folder
        copyfile (strcat (studyFolder,'/originalImg/FLAIR/', FLAIRfolder(i).name), strcat(studyFolder,'/subjects/',ID,'/mri/orig/'));  % copy FLAIR to each subject folder
    end



    %%%%%%%%%%%%%%%%%%%
    %% Run SPM steps %%
    %%%%%%%%%%%%%%%%%%%

    progressOutputCellArray_Stage1 {end+1} = 'Running SPM steps ...';
    progressOutput = [progressOutput, progressOutputCellArray_Stage1];
    drawnow;
    
    progressOutputCellArray_Stage1 {end+1} = 'Step 1: T1 & FLAIR coregistration ...';
    progressOutput = [progressOutput, progressOutputCellArray_Stage1];
    drawnow;
    WMHextraction_preprocessing_Step1 (studyFolder);
    
    progressOutputCellArray_Stage1 {end+1} = 'Generating coregistration QC images ...';
    progressOutput = [progressOutput, progressOutputCellArray_Stage1];
    drawnow;   
    WMHextraction_QC_1 (studyFolder, outputFormat); % coregistration QC
    
    switch outputFormat
        case 'web'
            % display on screen
        case 'arch'
            progressOutputCellArray_Stage1 {end+1} = ['Download link: ' studyFolder '/subjects/QC/QC_coreg/QC_coregistration.zip'];
        case 'web&arch'
            progressOutputCellArray_Stage1 {end+1} = ['Download link: ' studyFolder '/subjects/QC/QC_coreg/QC_coregistration.zip'];
    end
    
    progressOutputCellArray_Stage1 {end+1} = 'Please type in the IDs did not pass coregistration QC below ...';
    progressOutput = [progressOutput, progressOutputCellArray_Stage1];
    drawnow;
    
    stage1_time = toc/60; % in min
    fprintf ('');
    fprintf ('%.2f minutes elapsed so far.\n', stage1_time);
    fprintf ('');
    
    progressOutputCellArray_Stage1 {end+1} = [num2str(stage1_time) ' mins eclapsed so far.'];
    progressOutput = [progressOutput, progressOutputCellArray_Stage1];
    drawnow;
end


%% Stage 2
    
 function progressOutput = WMHextraction_main_inGUI_Stage2 (studyFolder, spm12path, progressOutput,coregExcldList, outputFormat)
     
    addpath (spm12path);
    nsegs=3;

    progressOutputCellArray_Stage2 = progressOutput;
    
    progressOutputCellArray_Stage2 {end+1} = 'Step 2: T1 segmentation ...';
    progressOutput = [progressOutput,progressOutputCellArray_Stage2];
    drawnow;
    WMHextraction_preprocessing_Step2 (studyFolder, spm12path, coregExcldList);
    
    progressOutputCellArray_Stage2 {end+1} = 'Generating segmentation QC images ...';
    progressOutput = [progressOutput,progressOutputCellArray_Stage2];
    drawnow;
    WMHextraction_QC_2 (studyFolder, coregExcldList, outputFormat); % segmentation QC
    
    switch outputFormat
        case 'web'
            % display on screen
        case 'arch'
            progressOutputCellArray_Stage2 {end+1} = ['Download link: ' studyFolder '/subjects/QC/QC_seg/QC_segmentation.zip'];
        case 'web&arch'
            progressOutputCellArray_Stage2 {end+1} = ['Download link: ' studyFolder '/subjects/QC/QC_seg/QC_segmentation.zip'];
    end
    
    progressOutputCellArray_Stage2 {end+1} = 'Please type in the IDs did not pass segmentation QC below ...';
    progressOutput = [progressOutput,progressOutputCellArray_Stage2];
    drawnow;
    
    stage2_time = toc/60; % in min
    fprintf ('');
    fprintf ('%.2f minutes elapsed so far.\n', stage2_time);
    fprintf ('');
    
    progressOutputCellArray_Stage2 {end+1} = [num2str(stage2_time) ' mins eclapsed so far.'];
    progressOutput = [progressOutput,progressOutputCellArray_Stage2];
    drawnow;
 end
 
 
 %% Stage 3

function progressOutput = WMHextraction_main_inGUI_Stage3 (studyFolder, spm12path, CNSP_path, dartelTemplate, k, PVWMH_magnitude, progressOutput, coregExcldList, segExcldList, classifier, ageRange, probThr, trainingFeatures1, trainingFeatures2, outputFormat)
    tic;
    nsegs=3;
    
    addpath (spm12path);

    excldList = [coregExcldList ' ' segExcldList];
    excldIDs = strsplit (excldList, ' ');
    
    T1folder = dir (strcat (studyFolder,'/originalImg/T1/*.nii'));
    FLAIRfolder = dir (strcat (studyFolder,'/originalImg/FLAIR/*.nii'));
    [Nsubj,n] = size (T1folder);
    
    
    progressOutputCellArray_Stage3 = progressOutput;
    progressOutputCellArray_Stage3 {end+1} = 'Step 3: Running DARTEL ...';
    progressOutput = [progressOutput, progressOutputCellArray_Stage3];
    drawnow;
    switch dartelTemplate
        case 'existing template'
            template = DartelTemplate(CNSP_path,ageRange,studyFolder);
        case 'creating template'
            template = CohortTemplate(strcat(studyFolder,'/subjects'));
        case 'native template'
            template = NativeTemplate(CNSP_path,ageRange,studyFolder);
    end 

    WMHextraction_preprocessing_Step3 (studyFolder, ...
                                        CNSP_path, ...
                                        template, ...
                                        coregExcldList, ...
                                        segExcldList, ...
                                        ageRange...
                                        );  % dartelTemplate specifies which set of templates to be used.

    progressOutputCellArray_Stage3 {end+1} = 'Step 4: Bring T1, FLAIR, as well as GM, WM and CSF segmentations to DARTEL ...';
    progressOutput = [progressOutput, progressOutputCellArray_Stage3];
    drawnow;
    WMHextraction_preprocessing_Step4 (studyFolder, template, coregExcldList, segExcldList, CNSP_path);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% non-brain tissue removal & FSL FAST %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    progressOutputCellArray_Stage3 {end+1} = 'Running non-brain tissue removal, and FSL FAST ...';
    progressOutput = [progressOutput, progressOutputCellArray_Stage3];
    drawnow;
    
%     cmd_skullStriping_FAST_1 = ['chmod +x ' CNSP_path '/WMH_extraction/WMHextraction/WMHextraction_SkullStriping_and_FAST.sh'];
%     system (cmd_skullStriping_FAST_1);


    
    parfor i = 1:Nsubj
        T1imgNames = strsplit (T1folder(i).name, '_');   % split T1 image name, delimiter is underscore
        ID = T1imgNames{1};   % first section is ID

        if ismember(ID, excldIDs) == 0
            subtemp = copy(template);
            if strcmp(template.name, 'native template')
                subtemp.subID = i; % need to set the template subject if native
            end

            cmd_skullStriping_FAST_2 = [CNSP_path '/WMH_extraction/WMHextraction/WMHextraction_SkullStriping_and_FAST.sh ' ...
                T1folder(i).name ' '...
                FLAIRfolder(i).name ' ' ...
                studyFolder '/subjects ' ...
                ID ' ' ...
                subtemp.brain_mask ' ' ...
                strrep(subtemp.name, ' ', '_') ' ' ...
                subtemp.gm_prob ' ' ...
                char(string(nsegs))];
            system (cmd_skullStriping_FAST_2); 

        end

    end




    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% kNN WMH discovery Step 1: Preprocessing %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    progressOutputCellArray_Stage3 {end+1} = 'Preprocessing for kNN ...';
    progressOutput = [progressOutput, progressOutputCellArray_Stage3];
    drawnow;
    
%     cmd_kNN_step1_1 = ['chmod +x ' CNSP_path '/WMH_extraction/WMHextraction/WMHextraction_kNNdiscovery_Step1.sh'];
%     system (cmd_kNN_step1_1);


    parfor i = 1:Nsubj
        T1imgNames = strsplit (T1folder(i).name, '_');   % split T1 image name, delimiter is underscore
        ID = T1imgNames{1};   % first section is ID

        if ismember(ID, excldIDs) == 0
            subtemp = copy(template);
            if strcmp(template.name, 'native template')
                subtemp.subID = i; % need to set the template subject if native
            end
            cmd_kNN_step1_2 = [CNSP_path '/WMH_extraction/WMHextraction/WMHextraction_kNNdiscovery_Step1.sh ' ...
                ID ' ' ...
                studyFolder '/subjects ' ...
                subtemp.wm_prob_thr ' ' ...
                strrep(subtemp.name, ' ', '_') ' ' ...
                char(string(nsegs))];
            system (cmd_kNN_step1_2);
        end
    end



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% kNN WMH discovery Step 2: kNN calculation %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    progressOutputCellArray_Stage3 {end+1} = 'kNN calculation ...';
    progressOutput = [progressOutput, progressOutputCellArray_Stage3];
    drawnow;
    
    parfor i = 1:Nsubj
        T1imgNames = strsplit (T1folder(i).name, '_');   % split T1 image name, delimiter is underscore
        ID = T1imgNames{1};   % first section is ID
        
        if ismember(ID, excldIDs) == 0
            subtemp = copy(template);
            if strcmp(template.name, 'native template')
                subtemp.subID = i; % need to set the template subject if native
            end
            WMHextraction_kNNdiscovery_Step2 (k, ...
                                              ID, ...
                                              classifier, ...
                                              subtemp, ...
                                              probThr, ...
                                              trainingFeatures1, ...
                                              trainingFeatures2, ...
                                              nsegs ...
                                              );
        end
    end


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% kNN WMH discovery Step 3: Postprocessing and cleanup %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    probThr_str = num2str (probThr, '%1.2f');
    progressOutputCellArray_Stage3 {end+1} = 'Generating image and text output, and cleanup ...';
    progressOutput = [progressOutput, progressOutputCellArray_Stage3];
    drawnow;
    
%     cmd_kNN_step3_1 = ['chmod +x ' CNSP_path '/WMH_extraction/WMHextraction/WMHextraction_kNNdiscovery_Step3.sh'];
%     system (cmd_kNN_step3_1);

    parfor i = 1:Nsubj
        T1imgNames = strsplit (T1folder(i).name, '_');   % split T1 image name, delimiter is underscore
        ID = T1imgNames{1};   % first section is ID

        if ismember(ID, excldIDs) == 0
            subtemp = copy(template);
            if strcmp(template.name, 'native template')
                subtemp.subID = i; % need to set the template subject if native
            end
            cmd_kNN_step3_2 = [CNSP_path '/WMH_extraction/WMHextraction/WMHextraction_kNNdiscovery_Step3.sh ' ...
                            ID ' ' ...
                            studyFolder '/subjects ' ...
                            CNSP_path '/WMH_extraction ' ...
                            PVWMH_magnitude ' ' ...
                            probThr_str ' ' ...
                            subtemp.wm_prob_thr ' ' ...
                            subtemp.ventricles ' ' ...
                            subtemp.lobar ' ' ...
                            subtemp.arterial ' '
                            ];
            system (cmd_kNN_step3_2);
        end
    end


    % merge WMH results into one spreadsheet.
    % cmd_merge_WMHresults_1 = ['if [ -f ' studyFolder '/subjects/WMH_spreadsheet.txt ];then rm -f ' studyFolder '/subjects/WMH_spreadsheet.txt;fi'];
    % system (cmd_merge_WMHresults_1);

    % cmd_merge_WMHresults_2 = ['echo "ID,wholeBrainWMHvol_mm3,PVWMHvol_mm3,DWMHvol_mm3,Lfrontal_WMHvol_mm3,Rfrontal_WMHvol_mm3,Ltemporal_WMHvol_mm3,Rtemporal_WMHvol_mm3,Lparietal_WMHvol_mm3,Rparietal_WMHvol_mm3,Loccipital_WMHvol_mm3,Roccipital_WMHvol_mm3,Lcerebellum_WMHvol_mm3,Rcerebellum_WMHvol_mm3,Brainstem_WMHvol_mm3" >> ' ...
    %                                 studyFolder '/subjects/WMH_spreadsheet.txt'];
    % system (cmd_merge_WMHresults_2);

%     cmd_merge_WMHresults_3 = ['chmod +x ' CNSP_path '/WMH_extraction/WMHextraction/WMHextraction_kNNdiscovery_Step4.sh'];
%     system (cmd_merge_WMHresults_3);


    system ([CNSP_path '/WMH_extraction/WMHextraction/WMHspreadsheetTitle.sh ' studyFolder '/subjects']);


    for i = 1:Nsubj
        T1imgNames = strsplit (T1folder(i).name, '_');   % split T1 image name, delimiter is underscore
        ID = T1imgNames{1};   % first section is ID

        if ismember(ID, excldIDs) == 0
            cmd_merge_WMHresults_4 = [CNSP_path '/WMH_extraction/WMHextraction/WMHextraction_kNNdiscovery_Step4.sh ' ID ' ' studyFolder '/subjects'];
            system (cmd_merge_WMHresults_4);
        end
    end                                



    %%%%%%%%%%%%%%%%%%%%%%%%
    %% QC_3: final output %%
    %%%%%%%%%%%%%%%%%%%%%%%%


    progressOutputCellArray_Stage3 {end+1} = 'Generating images for quality assurance of the final output ...';
    progressOutput = [progressOutput, progressOutputCellArray_Stage3];
    drawnow;
    
    WMHextraction_QC_3 (studyFolder, coregExcldList, segExcldList, outputFormat);
    
    switch outputFormat
        case 'web'
            % display on screen
        case 'arch'
            progressOutputCellArray_Stage3 {end+1} = ['Download link: ' studyFolder '/subjects/QC/QC_final/QC_final.zip'];
        case 'web&arch'
            progressOutputCellArray_Stage3 {end+1} = ['Download link: ' studyFolder '/subjects/QC/QC_final/QC_final.zip'];
    end




    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Bring back to native space %%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    progressOutputCellArray_Stage3 {end+1} = 'Bringing DARTEL space WMH mask to native space ...';
    progressOutput = [progressOutput, progressOutputCellArray_Stage3];
    drawnow;

    parfor i = 1:Nsubj
        T1imgNames = strsplit (T1folder(i).name, '_');   % split T1 image name, delimiter is underscore
        ID = T1imgNames{1};   % first section is ID
        
        if ismember(ID, excldIDs) == 0

            switch dartelTemplate
            case 'existing template'
                WMHresultsBack2NativeSpace (studyFolder, ID, spm12path);
            case 'creating template'
                WMHresultsBack2NativeSpace (studyFolder, ID, spm12path, '', 'creating template');
            end

        end
    end

    % webpage display
    % [~, NexcldIDs] = size (excldIDs);
    % indFLAIR_cellArr = cell ((Nsubj - NexcldIDs), 1);
    % indWMH_FLAIRspace_cellArr = cell ((Nsubj - NexcldIDs), 1);
    indFLAIR_cellArr = cell (Nsubj, 1);
    indWMH_FLAIRspace_cellArr = cell (Nsubj, 1);

    for i = 1:Nsubj
        T1imgNames = strsplit (T1folder(i).name, '_');   % split T1 image name, delimiter is underscore
        ID = T1imgNames{1};   % first section is ID
        
        if ismember (ID, excldIDs) == 0
            indFLAIR_cellArr{i,1} = strcat (studyFolder,'/originalImg/FLAIR/', FLAIRfolder(i).name);
            
            indWMH_FLAIRspace_cellArr{i,1} = [studyFolder '/subjects/' ID '/mri/extractedWMH/' ID '_WMH_FLAIRspace.nii.gz'];
            
        else % if ID is excluded, display the FLAIR image twice
            indFLAIR_cellArr{i,1} = strcat (studyFolder,'/originalImg/FLAIR/', FLAIRfolder(i).name);
            
            indWMH_FLAIRspace_cellArr{i,1} = strcat (studyFolder,'/originalImg/FLAIR/', FLAIRfolder(i).name);
        end
    end

    if exist ([studyFolder '/subjects/QC/QC_final_native'], 'dir') ~= 7
        mkdir ([studyFolder '/subjects/QC'], 'QC_final_native');
    end

    CNSP_webViewSlices_overlay (indFLAIR_cellArr, ...
                                indWMH_FLAIRspace_cellArr, ...
                                [studyFolder '/subjects/QC/QC_final_native'], ...
                                'QC_final_native', ...
                                'web');





    %%%%%%%%%%%%%%%%%%%%%%
    %% "finish" message %%
    %%%%%%%%%%%%%%%%%%%%%%

    progressOutputCellArray_Stage3 {end+1} = '*** FINISHED ! ***';
    progressOutput = [progressOutput, progressOutputCellArray_Stage3];
    drawnow;
    
    stage3_time = toc/3600; % in hrs
    fprintf ('');
    fprintf ('%.2f hours elapsed to finish the extraction procedures.\n', stage3_time);
    fprintf ('');
    
    
    progressOutputCellArray_Stage3 {end+1} = [num2str(stage3_time) ' hrs eclapsed to finish.'];
    progressOutput = [progressOutput, progressOutputCellArray_Stage3];
    drawnow;
end

function UFA_T1T2Flair_alignDWI(Input_Folder)

% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14

unix(['mkdir ',[Input_Folder,'/T1T2Flair_alignDWI']]);

Output_Folder = [Input_Folder,'/T1T2Flair_alignDWI'];

T2_flair = [Input_Folder,'/T2Flair/T2Flair.nii.gz'];

unix(['bet ',T2_flair,' ',Output_Folder,'/bet_FLAIR.nii.gz -m -f 0.3']);

unix(['N4BiasFieldCorrection -d 3 -x ' Output_Folder,'/bet_FLAIR_mask.nii.gz -i ',T2_flair,' -o ',Output_Folder,'/Flair_after_bfc.nii.gz']);

unix(['dwiextract ' [Input_Folder,'/DWI/Tracking/DWI_preproc_biascorr.mif'],' -bzero - | mrmath -axis 3 - mean ',[Input_Folder,'/T1T2Flair_alignDWI/DWI_b0.nii.gz'],' -force']);

T1w_brain = [Input_Folder,'/T1/T1w-deGibbs-BiasCo-Brain.nii.gz'];

T1w = [Input_Folder,'/T1/T1w-deGibbs-BiasCo.nii.gz'];

% co-registration to T1w and T2 Flair to DWI image through FSL FLIRT

% linear registration with 6 dof and the transformation matrix output

unix(['flirt -ref ',T1w_brain,' -in ',Output_Folder,'/DWI_b0.nii.gz -dof 6 -omat ',Output_Folder,'/transform_flirt_dwi2t1_init.mat -cost mutualinfo -interp nearestneighbour']);   % corratio  -> mutualinfo

unix(['flirt -ref ',T1w,' -in ',Output_Folder,'/DWI_b0.nii.gz -dof 6 -init ',Output_Folder,'/transform_flirt_dwi2t1_init.mat',' -omat ',Output_Folder,'/transform_flirt_dwi2t1.mat',' -cost bbr -wmseg ',Input_Folder,'/T1/WMseg.nii.gz',' -interp nearestneighbour -schedule ${FSLDIR}/etc/flirtsch/bbr.sch']);

unix(['convert_xfm ',Output_Folder,'/transform_flirt_dwi2t1.mat -omat ',Output_Folder,'/transform_flirt_t12dwi.mat -inverse']);

unix(['flirt -ref ',Output_Folder,'/bet_FLAIR.nii.gz',' -in ',Output_Folder,'/DWI_b0.nii.gz -dof 6 -omat ',Output_Folder,'/transform_flirt_dwi2t2flair_init.mat -cost mutualinfo -interp nearestneighbour']);

unix(['flirt -ref ',Output_Folder,'/Flair_after_bfc.nii.gz',' -in ',Output_Folder,'/DWI_b0.nii.gz -dof 6 -init ',Output_Folder,'/transform_flirt_dwi2t2flair_init.mat',' -omat ',Output_Folder,'/transform_flirt_dwi2t2flair.mat -cost mutualinfo -interp nearestneighbour']);

unix(['convert_xfm ',Output_Folder,'/transform_flirt_dwi2t2flair.mat -omat ',Output_Folder,'/transform_flirt_t2flair2dwi.mat -inverse']);

% apply the linear transformation to the T2flair image

unix(['transformconvert ',Output_Folder,'/transform_flirt_t12dwi.mat ',T1w,' ',Output_Folder,'/DWI_b0.nii.gz flirt_import ',Output_Folder,'/transform_mrtrix_t1w2dwi.txt -force']);

unix(['transformconvert ',Output_Folder,'/transform_flirt_t2flair2dwi.mat ',Output_Folder,'/Flair_after_bfc.nii.gz',' ',Output_Folder,'/DWI_b0.nii.gz ','flirt_import ',Output_Folder,'/transform_mrtrix_t2falir2dwi.txt -force']);

unix(['mrtransform ',T1w,' -linear ',Output_Folder,'/transform_mrtrix_t1w2dwi.txt ',Output_Folder,'/T1_coreg.nii.gz -force']);

unix(['mrtransform ',Output_Folder,'/Flair_after_bfc.nii.gz -linear ',Output_Folder,'/transform_mrtrix_t2falir2dwi.txt',' -template ',Output_Folder,'/T1_coreg.nii.gz',' ',Output_Folder,'/T2flair_coreg.nii.gz -force']);

unix(['cp ',Output_Folder,'/T1_coreg.nii.gz ',[Input_Folder,'/T1/']]);

unix(['cp ',Output_Folder,'/T2flair_coreg.nii.gz ',[Input_Folder,'/T2Flair/']]);

WMH_Folder = [Input_Folder,'/WMH_extraction/subjects/Patient/mri/extractedWMH'];

unix(['mrtransform ',WMH_Folder,'/Patient_WMH_FLAIRspace.nii.gz -linear ',Output_Folder,'/transform_mrtrix_t2falir2dwi.txt',' -template ',Output_Folder,'/T1_coreg.nii.gz',' ',WMH_Folder,'/Patient_WMH_FLAIRspace_coreg.nii.gz -force']);

unix('echo The T1/T2Flair registration to DWI process already ends!');

#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14

UFA_Superficial_filter(){

FastSurferFolder="$1"

OutputFolder="$2"

export FASTSURFER_HOME="$1"

# bash ${FastSurferFolder}/run_fastsurfer.sh --t1 ${OutputFolder}/T1/T1w2dwispace_no_negative.nii.gz --sd ${OutputFolder}/DWI/Tracking/ --sid T1 --seg_only --seg_with_cc_only --py python3 --batch 4 --ignore_fs_version

# bash ${FastSurferFolder}/run_fastsurfer.sh --t1 ${OutputFolder}/T1/T1w2dwispace_no_negative.nii.gz --sd ${OutputFolder}/DWI/Tracking/ --sid T1 --seg_with_cc_only --py python3 --batch 4 --ignore_fs_version

bash ${FastSurferFolder}/run_fastsurfer.sh --t1 ${OutputFolder}/T1/T1w2dwispace_no_negative.nii.gz --sd ${OutputFolder}/DWI/Tracking/ --sid T1 --fsaparc --py python3 --batch 4 --ignore_fs_version

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 7 -eq ${OutputFolder}/DWI/Tracking/T1/mri/L_CER.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 16 -eq ${OutputFolder}/DWI/Tracking/T1/mri/BrainStem.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 46 -eq ${OutputFolder}/DWI/Tracking/T1/mri/R_CER.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 251 -eq ${OutputFolder}/DWI/Tracking/T1/mri/CC_P.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 252 -eq ${OutputFolder}/DWI/Tracking/T1/mri/CC_MP.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 253 -eq ${OutputFolder}/DWI/Tracking/T1/mri/CC_C.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 254 -eq ${OutputFolder}/DWI/Tracking/T1/mri/CC_MA.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 255 -eq ${OutputFolder}/DWI/Tracking/T1/mri/CC_A.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/L_CER.mif ${OutputFolder}/DWI/Tracking/T1/mri/BrainStem.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/R_CER.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/CC_P.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/CC_MP.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/CC_C.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/CC_MA.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/CC_A.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/excluded_ROI.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 4 -eq ${OutputFolder}/DWI/Tracking/T1/mri/L_Lateral_Ventricle.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 5 -eq ${OutputFolder}/DWI/Tracking/T1/mri/L_Inf_Lat_Vent.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 8 -eq ${OutputFolder}/DWI/Tracking/T1/mri/L_CER_gm.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 10 -eq ${OutputFolder}/DWI/Tracking/T1/mri/L_Thalamus.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 11 -eq ${OutputFolder}/DWI/Tracking/T1/mri/L_Caudate.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 12 -eq ${OutputFolder}/DWI/Tracking/T1/mri/L_Putamen.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 13 -eq ${OutputFolder}/DWI/Tracking/T1/mri/L_Palidum.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 14 -eq ${OutputFolder}/DWI/Tracking/T1/mri/3rd_Ventricle.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 15 -eq ${OutputFolder}/DWI/Tracking/T1/mri/4th_Ventricle.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 17 -eq ${OutputFolder}/DWI/Tracking/T1/mri/L_Hippocampus.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 18 -eq ${OutputFolder}/DWI/Tracking/T1/mri/L_Amygdala.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 26 -eq ${OutputFolder}/DWI/Tracking/T1/mri/L_Accumbens.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 28 -eq ${OutputFolder}/DWI/Tracking/T1/mri/L_VentralDC.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 31 -eq ${OutputFolder}/DWI/Tracking/T1/mri/L_choroid-plexus.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 43 -eq ${OutputFolder}/DWI/Tracking/T1/mri/R_Lateral_Ventricle.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 44 -eq ${OutputFolder}/DWI/Tracking/T1/mri/R_Inf_Lat_Vent.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 47 -eq ${OutputFolder}/DWI/Tracking/T1/mri/R_CER_gm.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 49 -eq ${OutputFolder}/DWI/Tracking/T1/mri/R_Thalamus.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 50 -eq ${OutputFolder}/DWI/Tracking/T1/mri/R_Caudate.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 51 -eq ${OutputFolder}/DWI/Tracking/T1/mri/R_Putamen.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 52 -eq ${OutputFolder}/DWI/Tracking/T1/mri/R_Palidum.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 53 -eq ${OutputFolder}/DWI/Tracking/T1/mri/R_Hippocampus.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 54 -eq ${OutputFolder}/DWI/Tracking/T1/mri/R_Amygdala.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 58 -eq ${OutputFolder}/DWI/Tracking/T1/mri/R_Accumbens.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 60 -eq ${OutputFolder}/DWI/Tracking/T1/mri/R_VentralDC.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/aparc.DKTatlas+aseg.deep.withCC.mgz 63 -eq ${OutputFolder}/DWI/Tracking/T1/mri/R_choroid-plexus.mif -force


mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/L_Lateral_Ventricle.mif ${OutputFolder}/DWI/Tracking/T1/mri/L_Inf_Lat_Vent.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/L_CER_gm.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/L_Thalamus.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/L_Caudate.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/L_Putamen.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/L_Palidum.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/3rd_Ventricle.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/4th_Ventricle.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/L_Hippocampus.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/L_Amygdala.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/L_Accumbens.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/L_VentralDC.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/L_choroid-plexus.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/R_Lateral_Ventricle.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/R_Inf_Lat_Vent.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/R_CER_gm.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/R_Thalamus.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/R_Caudate.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/R_Putamen.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/R_Palidum.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/R_Hippocampus.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/R_Amygdala.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/R_Accumbens.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/R_VentralDC.mif \
-add ${OutputFolder}/DWI/Tracking/T1/mri/R_choroid-plexus.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/excluded_ROI_next.mif -force

mrcalc ${OutputFolder}/DWI/Tracking/T1/mri/excluded_ROI.mif ${OutputFolder}/DWI/Tracking/T1/mri/excluded_ROI_next.mif -add ${OutputFolder}/DWI/Tracking/T1/mri/excluded_ROI_total.mif -force

rm ${OutputFolder}/DWI/Tracking/T1/mri/L_*

rm ${OutputFolder}/DWI/Tracking/T1/mri/R_*

rm ${OutputFolder}/DWI/Tracking/T1/mri/CC_*

rm ${OutputFolder}/DWI/Tracking/T1/mri/BrainStem.mif

rm ${OutputFolder}/DWI/Tracking/T1/mri/4th_Ventricle.mif

rm ${OutputFolder}/DWI/Tracking/T1/mri/3rd_Ventricle.mif

# tckedit U_fiber_tractography.tck -exclude excluded_ROI.mif filtered_U_fiber_remove_subwm.tck -force

# tckedit U_fiber_tractography.tck -exclude excluded_ROI_next.mif filtered_U_fiber_remove_subgm.tck -force

tckedit U_fiber_tractography.tck -exclude ${OutputFolder}/DWI/Tracking/T1/mri/excluded_ROI_total.mif U_fiber_tractography.tck -force

}

UFA_Superficial_filter $1 $2

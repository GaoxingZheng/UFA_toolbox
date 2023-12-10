#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14
### REFERENCE: Hsu, C. C. H., Chong, S. T., Kung, Y. C., Kuo, K. T., Huang, C. C., & Lin, C. P. (2023).
# Integrated diffusion image operator (iDIO): A pipeline for automated configuration and processing of diffusion MRI data
# (Vol. 44, No. 7, pp. 2669-2683). Hoboken, USA: John Wiley & Sons, Inc..
### STATEMENT: This code is from https://github.com/iDIO4dMRI/iDIO. If it's useful in your study, please cite the above reference.

UFA_T1registrationDWI(){

OutputFolder="$1"

# bbr-linear registration of DWI_b0 to T1

echo Registrating DWI to T1

mkdir ${OutputFolder}/T1/Reg_matrix

dwiextract ${OutputFolder}/DWI/Tracking/DWI_preproc_biascorr.mif -bzero - | mrmath -axis 3 - mean ${OutputFolder}/DWI/Tracking/DWI_preproc_b0.nii.gz -force

cp ${OutputFolder}/DWI/Tracking/DWI_preproc_b0.nii.gz ${OutputFolder}/T1/DWI_b0.nii.gz

bet ${OutputFolder}/T1/DWI_b0.nii.gz ${OutputFolder}/T1/DWI_b0_brain.nii.gz -f 0.2 -m

flirt -in ${OutputFolder}/T1/DWI_b0_brain.nii.gz -ref ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Brain.nii.gz -dof 6 -cost mutualinfo -omat ${OutputFolder}/T1/Reg_matrix/epi2str_init.mat

flirt -ref ${OutputFolder}/T1/T1w-deGibbs-BiasCo.nii.gz -in ${OutputFolder}/T1/DWI_b0_brain.nii.gz -dof 6 -cost bbr -wmseg ${OutputFolder}/T1/WMseg.nii.gz -init ${OutputFolder}/T1/Reg_matrix/epi2str_init.mat -omat ${OutputFolder}/T1/Reg_matrix/epi2str.mat -schedule ${FSLDIR}/etc/flirtsch/bbr.sch

convert_xfm ${OutputFolder}/T1/Reg_matrix/epi2str.mat -omat ${OutputFolder}/T1/Reg_matrix/str2epi.mat -inverse

#convert tranformation matrix in to mrtrix format

transformconvert ${OutputFolder}/T1/Reg_matrix/str2epi.mat ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Brain.nii.gz ${OutputFolder}/T1/DWI_b0_brain.nii.gz flirt_import ${OutputFolder}/T1/Reg_matrix/str2epi.txt -force

mrtransform ${OutputFolder}/T1/5tt.nii.gz ${OutputFolder}/T1/5tt2dwispace.nii.gz -linear ${OutputFolder}/T1/Reg_matrix/str2epi.txt -force

# convert T1brain masks and T1 to DWI space

flirt -in ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Mask.nii.gz -ref ${OutputFolder}/T1/DWI_b0_brain.nii.gz -out ${OutputFolder}/T1/T1maskindwispace.nii.gz -init ${OutputFolder}/T1/Reg_matrix/str2epi.mat -applyxfm -cost mutualinfo -interp nearestneighbour
flirt -in ${OutputFolder}/T1/T1w-deGibbs-BiasCo.nii.gz -ref ${OutputFolder}/T1/DWI_b0_brain.nii.gz -out ${OutputFolder}/T1/T1w2dwispace.nii.gz -init ${OutputFolder}/T1/Reg_matrix/str2epi.mat -applyxfm -cost mutualinfo -interp nearestneighbour

# mrtransform ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Mask.nii.gz ${OutputFolder}/T1/T1maskindwispace.nii.gz -linear ${OutputFolder}/T1/Reg_matrix/str2epi.txt
# mrtransform ${OutputFolder}/T1/T1w-deGibbs-BiasCo.nii.gz ${OutputFolder}/T1/T1w2dwispace.nii.gz -linear ${OutputFolder}/T1/Reg_matrix/str2epi.txt

# fslmaths ${OutputFolder}/T1/T1w-deGibbs-BiasCo.nii.gz -thr 0 ${OutputFolder}/T1/T1w_preprocessed.nii.gz
fslmaths ${OutputFolder}/T1/T1w2dwispace.nii.gz -thr 0 ${OutputFolder}/T1/T1w2dwispace_no_negative.nii.gz 

cp ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Mask.nii.gz ${OutputFolder}/DWI/Tracking/T1w_mask.nii.gz
cp ${OutputFolder}/T1/T1maskindwispace.nii.gz ${OutputFolder}/DWI/Tracking/T1w_mask_inDWIspace.nii.gz

}

UFA_T1registrationDWI $1 

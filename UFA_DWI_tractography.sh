#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14
### REFERENCE: https://blog.csdn.net/weixin_51192938/article/details/130431572

UFA_DWI_tractography(){

OutputFolder="$1"

Tractography_cutoff="$2"

Tractography_angle="$3"

Tractography_minlength="$4"

Tractography_maxlength="$5"

Tractography_total_fibers="$6"

# 4. Whole Brain White Matter Fibre Tractograhy

# 4.1 5tt GM/WM interface generation

5tt2gmwmi ${OutputFolder}/T1/5tt2dwispace.nii.gz ${OutputFolder}/DWI/Tracking/5tt_gmwmi.mif -force

# 4.2 diffusion tensor imaging
 
# create a mask
# dwi2mask DWI/Tracking/DWI_preproc_biascorr.mif - | maskfilter - dilate DWI/Tracking/dwi_mask.mif -force

# create diffusion tensor
dwi2tensor -mask ${OutputFolder}/DWI/Tracking/T1w_mask_inDWIspace.nii.gz ${OutputFolder}/DWI/Tracking/DWI_preproc_biascorr.mif ${OutputFolder}/DWI/Tracking/dt.mif -force

# calculate eigenvectors and scalar metrics from tensor
tensor2metric ${OutputFolder}/DWI/Tracking/dt.mif -fa ${OutputFolder}/DWI/Tracking/dt_fa.mif -ad ${OutputFolder}/DWI/Tracking/dt_ad.mif -adc ${OutputFolder}/DWI/Tracking/dt_md.mif -rd ${OutputFolder}/DWI/Tracking/dt_rd.mif -force

# 4.3 constrained spherical deconvolution (CSD) 

# estimate response function for wm, gm, csf

dwi2response msmt_5tt ${OutputFolder}/DWI/Tracking/DWI_preproc_biascorr.mif ${OutputFolder}/T1/5tt2dwispace.nii.gz ${OutputFolder}/DWI/Tracking/ms_5tt_wm.txt ${OutputFolder}/DWI/Tracking/ms_5tt_gm.txt ${OutputFolder}/DWI/Tracking/ms_5tt_csf.txt \
	-voxels ${OutputFolder}/DWI/Tracking/ms_5tt_voxels.mif -nthreads 3 -force 

# estimate fiber orientation distribution FoD

# -mask mask.mif

dwi2fod msmt_csd ${OutputFolder}/DWI/Tracking/DWI_preproc_biascorr.mif \
	${OutputFolder}/DWI/Tracking/ms_5tt_wm.txt ${OutputFolder}/DWI/Tracking/dwi_wmCsd.mif \
	${OutputFolder}/DWI/Tracking/ms_5tt_gm.txt ${OutputFolder}/DWI/Tracking/dwi_gmCsd.mif \
	${OutputFolder}/DWI/Tracking/ms_5tt_csf.txt ${OutputFolder}/DWI/Tracking/dwi_csfCsd.mif -force 

mrthreshold --abs 0.2 ${OutputFolder}/DWI/Tracking/dt_fa.mif - | mrcalc - ${OutputFolder}/DWI/Tracking/DWI_preproc_biascorr_mask.mif -mult ${OutputFolder}/DWI/Tracking/dwi_wmMask.mif -force

# 4.4  whole brain tractography

#tckgen -algo iFOD2 -act ${OutputFolder}/T1/5tt2dwispace.nii.gz -backtrack -crop_at_gmwmi \
#	-cutoff 0.05 -angle 20 -minlength 20 -maxlength 200 \
#	-seed_image ${OutputFolder}/DWI/Tracking/dwi_wmMask.mif -select 200k \
#	${OutputFolder}/DWI/Tracking/dwi_wmCsd.mif \
#	${OutputFolder}/DWI/Tracking/fibs_200k_angle20_maxlen200_act.tck

tckgen -algo iFOD2 -act ${OutputFolder}/T1/5tt2dwispace.nii.gz -backtrack -crop_at_gmwmi \
	-cutoff ${Tractography_cutoff} -angle ${Tractography_angle} -minlength ${Tractography_minlength} -maxlength ${Tractography_maxlength} \
	-seed_gmwmi ${OutputFolder}/DWI/Tracking/5tt_gmwmi.mif -mask ${OutputFolder}/DWI/Tracking/dwi_wmMask.mif -select ${Tractography_total_fibers} \
	${OutputFolder}/DWI/Tracking/dwi_wmCsd.mif \
	${OutputFolder}/DWI/Tracking/fibs_${Tractography_total_fibers}_angle${Tractography_angle}_minlen${Tractography_minlength}_maxlen${Tractography_maxlength}_act.tck -nthreads 4 -force

# 4.5 Visualize the tractography

# tckmap -vox 1,1,1 ${OutputFolder}/DWI/Tracking/fibs_200k_angle20_maxlen200_act.tck ${OutputFolder}/DWI/Tracking/map.nii.gz

# mrview -load DWI/Tracking/map.nii.gz -imagevisible false -tractography.load DWI/Tracking//fibs_200k_angle20_maxlen200_act.tck

# mrview -load T1/T1.nii.gz -overlay.load DWI/Tracking/map.nii.gz -imagevisible false -tractography.load DWI/Tracking//fibs_200k_angle20_maxlen200_act.tck

## mrview -load WMH_extraction/subjects/QC/QC_final_native/*.nii.gz -imagevisible true -tractography.load DWI/Tracking//fibs_200k_angle20_maxlen200_act.tck -tractography.opacity 1 -tractography.thickness 0 -mode 2 -voxel 128,215,242 -capture.folder ./ -capture.prefix 'Whole_WMH' -capture.grab

# .vtk file can be viewed by trackvis

# tckconvert DWI/Tracking/fibs_200k_angle20_maxlen200_act.tck DWI/Tracking/whole_tract.vtk

}

UFA_DWI_tractography $1 $2 $3 $4 $5 $6

#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14

UFA_DWI_denoise(){

OutputFolder="$1"

DWI_Image="$2"

# 1 transform the .nii.gz into .mif file

if [[ $DWI_Image =~ "AP"  &&  $DWI_Image =~ "PA" ]];then
	
	if [ ! -f ${OutputFolder}/DWI/AP/*.bvec ]; then
		
		echo "No b vector exist!"
		
		mrconvert -json_import ${OutputFolder}/DWI/AP/*.json ${OutputFolder}/DWI/AP/*.nii.gz ${OutputFolder}/DWI/Tracking/DWI_AP.mif -force
	
	else
		
		mrconvert -fslgrad ${OutputFolder}/DWI/AP/*.bvec ${OutputFolder}/DWI/AP/*.bval -json_import ${OutputFolder}/DWI/AP/*.json ${OutputFolder}/DWI/AP/*.nii.gz ${OutputFolder}/DWI/Tracking/DWI_AP.mif -force
	
	fi
	
	if [ ! -f ${OutputFolder}/DWI/PA/*.bvec ]; then
		
		echo "No b vector exist!"
		
		mrconvert -json_import ${OutputFolder}/DWI/PA/*.json ${OutputFolder}/DWI/PA/*.nii.gz ${OutputFolder}/DWI/Tracking/DWI_PA.mif -force
	
	else
		
		mrconvert -fslgrad ${OutputFolder}/DWI/PA/*.bvec ${OutputFolder}/DWI/PA/*.bval -json_import ${OutputFolder}/DWI/PA/*.json ${OutputFolder}/DWI/PA/*.nii.gz ${OutputFolder}/DWI/Tracking/DWI_PA.mif -force
	
	fi
	
	DWI_AP_dim=`mrinfo -ndim ${OutputFolder}/DWI/AP/DWI_AP.mif`

	DWI_PA_dim=`mrinfo -ndim ${OutputFolder}/DWI/PA/DWI_PA.mif`

	if [[ $DWI_AP_dim -eq 4 ]];then
		
		AP_dim4=`mrinfo ${OutputFolder}/DWI/AP/DWI_AP.mif -size | cut -d " " -f 4-$n`
	
	else
		
		AP_dim4=0
	
	fi

	if [[ $DWI_PA_dim -eq 4 ]];then
		
		PA_dim4=`mrinfo ${OutputFolder}/DWI/PA/DWI_PA.mif -size | cut -d " " -f 4-$n`

	else
		
		PA_dim4=0
	
	fi
	
	if [[ $AP_dim4 -gt $PA_dim4 ]];then
		
		mrgrid ${OutputFolder}/DWI/Tracking/DWI_PA.mif regrid -template ${OutputFolder}/DWI/Tracking/DWI_AP.mif ${OutputFolder}/DWI/Tracking/DWI_PA_resampled.mif -force
		
		mrconvert ${OutputFolder}/DWI/Tracking/DWI_AP.mif ${OutputFolder}/DWI/Tracking/dwi.mif -force
	
	else
		
		mrgrid ${OutputFolder}/DWI/Tracking/DWI_AP.mif regrid -template ${OutputFolder}/DWI/Tracking/DWI_PA.mif ${OutputFolder}/DWI/Tracking/DWI_AP_resampled.mif -force
		
		mrconvert ${OutputFolder}/DWI/Tracking/DWI_PA.mif ${OutputFolder}/DWI/Tracking/dwi.mif -force
	
	fi

elif [[ $DWI_Image =~ "AP" &&  $DWI_Image != "PA" ]];then
	
	mrconvert -fslgrad ${OutputFolder}/DWI/AP/*.bvec ${OutputFolder}/DWI/AP/*.bval -json_import ${OutputFolder}/DWI/AP/*.json ${OutputFolder}/DWI/AP/*.nii.gz ${OutputFolder}/DWI/Tracking/DWI_AP.mif -force
	
	mrconvert ${OutputFolder}/DWI/Tracking/DWI_AP.mif ${OutputFolder}/DWI/Tracking/dwi.mif -force

elif [[ $DWI_Image != "AP" &&  $DWI_Image =~ "PA" ]];then
	
	mrconvert -fslgrad ${OutputFolder}/DWI/PA/*.bvec ${OutputFolder}/DWI/PA/*.bval -json_import ${OutputFolder}/DWI/PA/*.json ${OutputFolder}/DWI/PA/*.nii.gz ${OutputFolder}/DWI/Tracking/DWI_PA.mif -force
	
	mrconvert ${OutputFolder}/DWI/Tracking/DWI_PA.mif ${OutputFolder}/DWI/Tracking/dwi.mif -force

fi

# 2. creat a mask

dwi2mask ${OutputFolder}/DWI/Tracking/dwi.mif - | maskfilter - dilate ${OutputFolder}/DWI/Tracking/preproc_mask.mif -npass 3 -force

# 3. Denoising if diffusion MRI using random matrix theory. 2016

dwidenoise ${OutputFolder}/DWI/Tracking/dwi.mif ${OutputFolder}/DWI/Tracking/denoise.mif -noise ${OutputFolder}/DWI/Tracking/noiselevel.mif -mask ${OutputFolder}/DWI/Tracking/preproc_mask.mif -force

}

UFA_DWI_denoise $1 $2

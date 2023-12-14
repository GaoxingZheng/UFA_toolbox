#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14

DWI_eddy_correction(){

OutputFolder="$1"

DWI_Image="$2"

if [[ $DWI_Image =~ "AP"  &&  $DWI_Image =~ "PA" ]];then
       
	# 1. motion and distortion correction
       
	# Efficient correction of inhomogeneous static magnetic field-induced distortion in Echo Planar Imaging. 2010
	
	DWI_AP_dim=`mrinfo -ndim ${OutputFolder}/DWI/Tracking/DWI_AP.mif`
	
	if [[ $DWI_AP_dim -eq 4 ]];then
		
		if [ ! -f ${OutputFolder}/DWI/AP/*.bval ]; then
			
			mrmath ${OutputFolder}/DWI/Tracking/DWI_AP.mif mean ${OutputFolder}/DWI/Tracking/b0_AP.mif -axis 3 -force
		
		else
			
			dwiextract ${OutputFolder}/DWI/Tracking/DWI_AP.mif - -bzero | mrconvert - -coord 3 0 ${OutputFolder}/DWI/Tracking/b0_AP.mif -force
		
		fi
	
	elif [[ $DWI_AP_dim -eq 3 ]];then
		
		mrconvert ${OutputFolder}/DWI/Tracking/DWI_AP.mif ${OutputFolder}/DWI/Tracking/b0_AP.mif -force
	
	fi
       
	DWI_PA_dim=`mrinfo -ndim ${OutputFolder}/DWI/Tracking/DWI_PA.mif`
	
	if [[ $DWI_PA_dim -eq 4 ]];then
		
		if [ ! -f ${OutputFolder}/DWI/PA/*.bval ]; then
			
			mrmath ${OutputFolder}/DWI/Tracking/DWI_PA.mif mean ${OutputFolder}/DWI/Tracking/b0_PA.mif -axis 3 -force
		
		else
			
			dwiextract ${OutputFolder}/DWI/Tracking/DWI_PA.mif - -bzero | mrconvert - -coord 3 0 ${OutputFolder}/DWI/Tracking/b0_PA.mif -force
		
		fi
	
	elif [[ $DWI_PA_dim -eq 3 ]];then
		
		mrconvert ${OutputFolder}/DWI/Tracking/DWI_PA.mif ${OutputFolder}/DWI/Tracking/b0_PA.mif -force
	
	fi
	
	if [[ $DWI_AP_dim -eq 4 ]];then
		
		AP_dim4=`mrinfo ${OutputFolder}/DWI/Tracking/DWI_AP.mif -size | cut -d " " -f 4-$n`

	else
		AP_dim4=0
	
	fi
	
	if [[ $DWI_PA_dim -eq 4 ]];then
		
		PA_dim4=`mrinfo ${OutputFolder}/DWI/Tracking/DWI_PA.mif -size | cut -d " " -f 4-$n`

	else
		PA_dim4=0

	fi

	if [[ $AP_dim4 -gt $PA_dim4 ]];then
		
		mrgrid ${OutputFolder}/DWI/Tracking/b0_PA.mif regrid -template ${OutputFolder}/DWI/Tracking/b0_AP.mif ${OutputFolder}/DWI/Tracking/b0_PA_resampled.mif -force
		
		mrcat ${OutputFolder}/DWI/Tracking/b0_AP.mif ${OutputFolder}/DWI/Tracking/b0_PA_resampled.mif -axis 3 ${OutputFolder}/DWI/Tracking/b0_pair.mif -force

		# 2. eddy current correction
		
		dwifslpreproc ${OutputFolder}/DWI/Tracking/degibbs.mif ${OutputFolder}/DWI/Tracking/DWI_preproc.mif -pe_dir AP -rpe_pair -se_epi ${OutputFolder}/DWI/Tracking/b0_pair.mif -nthreads 4 -eddy_options " --data_is_shelled --slm=linear --niter=5 " -force
	
	else
		
		mrgrid ${OutputFolder}/DWI/Tracking/b0_AP.mif regrid -template ${OutputFolder}/DWI/Tracking/b0_PA.mif ${OutputFolder}/DWI/Tracking/b0_AP_resampled.mif -force
		
		mrcat ${OutputFolder}/DWI/Tracking/b0_PA.mif ${OutputFolder}/DWI/Tracking/b0_AP_resampled.mif -axis 3 ${OutputFolder}/DWI/Tracking/b0_pair.mif -force
		
		dwifslpreproc ${OutputFolder}/DWI/Tracking/degibbs.mif ${OutputFolder}/DWI/Tracking/DWI_preproc.mif -pe_dir PA -rpe_pair -se_epi ${OutputFolder}/DWI/Tracking/b0_pair.mif -nthreads 4 -eddy_options " --data_is_shelled --slm=linear --niter=5 " -force
	
	fi

elif [[ $DWI_Image =~ "AP" &&  $DWI_Image != "PA" ]];then
	
	dwiextract ${OutputFolder}/DWI/Tracking/DWI_AP.mif - -bzero | mrconvert - -coord 3 0 ${OutputFolder}/DWI/Tracking/b0_AP.mif -force
	
	dwifslpreproc ${OutputFolder}/DWI/Tracking/degibbs.mif ${OutputFolder}/DWI/Tracking/DWI_preproc.mif -pe_dir AP -rpe_none -nthreads 4 -eddy_options " --data_is_shelled --slm=linear --niter=5 " -force

elif [[ $DWI_Image != "AP" &&  $DWI_Image =~ "PA" ]];then
	
	dwiextract ${OutputFolder}/DWI/Tracking/DWI_PA.mif - -bzero | mrconvert - -coord 3 0 ${OutputFolder}/DWI/Tracking/b0_PA.mif -force
	
	dwifslpreproc ${OutputFolder}/DWI/Tracking/degibbs.mif ${OutputFolder}/DWI/Tracking/DWI_preproc.mif -pe_dir PA -rpe_none -nthreads 4 -eddy_options " --data_is_shelled --slm=linear --niter=5 " -force

fi

# 3. check the eddy quality

# mrview ${OutputFolder}/DWI/Tracking/DWI_preproc.mif -overlay.load ${OutputFolder}/DWI/Tracking/dwi.mif

}

DWI_eddy_correction $1 $2

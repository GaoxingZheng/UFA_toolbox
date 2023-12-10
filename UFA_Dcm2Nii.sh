#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14

UFA_Dcm2Nii_sh() {

InputFolder="$1"

OutputFolder="$2"

T1_Image="$3"

T2Flair_Image="$4"

DWI_Image="$5"

# 1. build new folder DWI, T1, T2Flair

# 1.1 DWI folder

if [ ! -d "DWI" ];then
	
	mkdir ${OutputFolder}/DWI
	echo "We create DWI folder successfully!"
else
	echo "The folder DWI already existed!"
fi

# 1.2 T1 folder

if [ ! -d "T1" ];then
	
	mkdir ${OutputFolder}/T1
	echo "We create T1 folder successfully!"
else
	echo "The folder T1 already existed!"
fi

# 1.3 T2Flair folder

if [ ! -d "T2Flair" ];then
	
	mkdir ${OutputFolder}/T2Flair
	echo "We create T2Flair folder successfully!"
else
	echo "The folder T2Flair already existed!"
fi

# 2. transform the dicom file into nifti file

# 2.1 DWI folder --- convert dicom file into nifti file

mkdir ${OutputFolder}/DWI/Tracking

if [[ $DWI_Image =~ "AP"  &&  $DWI_Image =~ "PA" ]];then
	
	mkdir ${OutputFolder}/DWI/AP
	mkdir ${OutputFolder}/DWI/PA
	dcm2niix -f AP -o ${OutputFolder}/DWI/AP -z y ${InputFolder}/*DTI_AP*
	dcm2niix -f PA -o ${OutputFolder}/DWI/PA -z y ${InputFolder}/*DTI_PA*

elif [[ $DWI_Image =~ "AP" &&  $DWI_Image != "PA" ]];then
	
	mkdir ${OutputFolder}/DWI/AP
	dcm2niix -f AP -o ${OutputFolder}/DWI/AP -z y ${InputFolder}/*${DWI_Image}*

elif [[ $DWI_Image != "AP" &&  $DWI_Image =~ "PA" ]];then
	
	mkdir ${OutputFolder}/DWI/PA
	dcm2niix -f PA -o ${OutputFolder}/DWI/PA -z y ${InputFolder}/*${DWI_Image}*

fi


# 2.2 T1 folder --- convert dicom file into nifti file

dcm2niix -f T1 -o ${OutputFolder}/T1/ -z y ${InputFolder}/*${T1_Image}*

# dcm2niix -f T1 -o ${OutputFolder}/T1/ -z y ${InputFolder}/*FSPGR*

# 2.3 T2Flair folder --- convert dicom file into nifti file

dcm2niix -f T2Flair -o ${OutputFolder}/T2Flair/ -z y ${InputFolder}/*${T2Flair_Image}*

#dcm2niix -f T2Flair -o ${OutputFolder}/T2Flair/ -z y ${InputFolder}/*T2_FLAIR*

}

UFA_Dcm2Nii_sh $1 $2 $3 $4 $5

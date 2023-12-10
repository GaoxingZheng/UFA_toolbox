#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14

UFA_T1T2Flair_copy(){

OutputFolder="$1"

SPM12_path="$2"  # '/home/zhenggaoxing/Public/Neuroimage_toolbox/spm12'

# T2Flair preprocessing

# CNS toolbox 

mkdir ${OutputFolder}/WMH_extraction/
mkdir ${OutputFolder}/WMH_extraction/T1
mkdir ${OutputFolder}/WMH_extraction/FLAIR

cp ${OutputFolder}/T1/T1.nii.gz ${OutputFolder}/WMH_extraction/T1/Patient_T1.nii.gz
cp ${OutputFolder}/T1/T1.json ${OutputFolder}/WMH_extraction/T1/Patient_T1.json

cp ${OutputFolder}/T2Flair/T2Flair.nii.gz ${OutputFolder}/WMH_extraction/FLAIR/Patient_FLAIR.nii.gz
cp ${OutputFolder}/T2Flair/T2Flair.json ${OutputFolder}/WMH_extraction/FLAIR/Patient_FLAIR.json

# /usr/local/Polyspace/R2019b/bin/matlab -nodisplay -r "studyDir='${OutputFolder}/WMH_extraction';spm12path=${SPM12_path};chos=0;run('./UFA_WMH_extraction(studyDir,spm12path,chos).m');exit;"

}

UFA_T1T2Flair_copy $1 $2
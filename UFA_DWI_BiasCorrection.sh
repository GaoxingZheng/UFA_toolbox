#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14


UFA_DWI_BiasCorrection(){

OutputFolder="$1"

# bias field correction

dwibiascorrect ants ${OutputFolder}/DWI/Tracking/DWI_preproc.mif ${OutputFolder}/DWI/Tracking/DWI_preproc_biascorr.mif -bias ${OutputFolder}/DWI/Tracking/DWI_preproc_biasfield.mif -force

dwi2mask ${OutputFolder}/DWI/Tracking/DWI_preproc_biascorr.mif ${OutputFolder}/DWI/Tracking/DWI_preproc_biascorr_mask.mif -force

dwiextract ${OutputFolder}/DWI/Tracking/DWI_preproc_biascorr.mif -bzero - | mrmath -axis 3 - mean ${OutputFolder}/DWI/Tracking/DWI_preproc_b0.nii -force

}

UFA_DWI_BiasCorrection $1

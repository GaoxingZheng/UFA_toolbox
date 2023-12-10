#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14
### REFERENCE: Hsu, C. C. H., Chong, S. T., Kung, Y. C., Kuo, K. T., Huang, C. C., & Lin, C. P. (2023).
# Integrated diffusion image operator (iDIO): A pipeline for automated configuration and processing of diffusion MRI data
# (Vol. 44, No. 7, pp. 2669-2683). Hoboken, USA: John Wiley & Sons, Inc..
### STATEMENT: This code is from https://github.com/iDIO4dMRI/iDIO. If it's useful in your study, please cite the above reference.

UFA_T1_tissue_seg(){

OutputFolder="$1"

# using 5tt seg to replace bet and fast, and save the scratch file
# 5ttgen fsl -nocrop -sgm_amyg_hipp ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Brain.nii.gz ${OutputFolder}/T1/5tt.nii.gz -nocleanup -premasked -scratch ${OutputFolder}/T1/T1tmp/ -quiet -force
# 5ttgen fsl -nocrop -sgm_amyg_hipp ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Brain.nii.gz ${OutputFolder}/T1/5tt.nii.gz -nocleanup -premasked -scratch ${OutputFolder}/T1/T1tmp/ -force
5ttgen fsl -nocrop ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Brain.nii.gz ${OutputFolder}/T1/5tt.nii.gz -nocleanup -premasked -scratch ${OutputFolder}/T1/T1tmp/ -force

cp ${OutputFolder}/T1/T1tmp/T1_pve*.nii.gz ${OutputFolder}/T1/
rm -r ${OutputFolder}/T1/T1tmp

for i in ${OutputFolder}/T1/T1_pve*;do
    tem_name=${i##*/}
    tem_name=${tem_name:6}
    mv ${i} ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Brain_pve$tem_name
done

#extract WMseg for bbr
fslmaths ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Brain_pveseg.nii.gz -thr 3 -bin ${OutputFolder}/T1/WMseg.nii.gz

}

UFA_T1_tissue_seg $1
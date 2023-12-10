#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14

UFA_T1_degibbs(){

# degibbs

OutputFolder="$1"

mrdegibbs ${OutputFolder}/T1/T1.nii.gz ${OutputFolder}/T1/T1w-deGibbs.nii.gz -quiet -force

echo 'The degibbsed T1 image is already generated!'

}

UFA_T1_degibbs $1
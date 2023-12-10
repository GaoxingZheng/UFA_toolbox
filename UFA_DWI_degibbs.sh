#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14


UFA_DWI_degibbs(){

OutputFolder="$1"

# Gibbs-Ring artifact Removal Based on Local Subvoxel-Shifts. 2016

mrdegibbs ${OutputFolder}/DWI/Tracking/denoise.mif ${OutputFolder}/DWI/Tracking/degibbs.mif -force

}

UFA_DWI_degibbs $1
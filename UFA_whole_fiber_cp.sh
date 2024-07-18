#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14

UFA_whole_fiber_cp(){

whole_fiber_folder="$1"

whole_fiber_name=$(ls ${whole_fiber_folder} | grep '\.tck$')

# Whole fiber White matter clustering analysis

cp ${whole_fiber_folder}/${whole_fiber_name} ./WMA_clustering_SWM/whole_fibers.tck

tckconvert ./WMA_clustering_SWM/whole_fibers.tck ./WMA_clustering_SWM/whole_tract.vtk -force

}

UFA_whole_fiber_cp $1
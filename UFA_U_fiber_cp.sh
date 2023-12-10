#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14

UFA_U_fiber_cp(){

U_fibers_folder="$1"

# U fiber White matter clustering analysis

cp ${U_fibers_folder}/U_fibers.tck ./WMA_clustering_SWM/U_fibers.tck

tckconvert ./WMA_clustering_SWM/U_fibers.tck ./WMA_clustering_SWM/whole_tract.vtk -force

}

UFA_U_fiber_cp $1
#!/bin/bash

WMA_clustering_SWM(){

CurrentFolder="$1"

OutputFolder="$2"

SlicerPath="$3" #/home/zhenggaoxing/Public/NeuroImage_toolbox/Slicer-4.8.1-linux-amd64

min_len="$4" #20

max_len="$5" #80

num_of_processor=`cat /proc/cpuinfo | grep processor | wc -l`

wm_quality_control_tractography.py ${CurrentFolder}/ ${CurrentFolder}/QC/InputTractography/

wm_quality_control_tract_overlap.py ${CurrentFolder}/ORG-Atlases-1.1.1/ORG-800FC-100HCP/atlas.vtp ${CurrentFolder}/U_fibers.vtk ${CurrentFolder}/QC/InputTractOverlap/

wm_register_to_atlas_new.py -mode rigid_affine_fast -l ${min_len} -lmax ${max_len} ${CurrentFolder}/whole_tract.vtk ${CurrentFolder}/ORG-Atlases-1.1.1/ORG-RegAtlas-100HCP/registration_atlas.vtk ${CurrentFolder}/TractRegistration/

rm -rf ${CurrentFolder}/whole_tract.vtk
rm -rf ${CurrentFolder}/whole_fibers.tck
rm -rf ${CurrentFolder}/U_fibers.tck
rm -rf ${CurrentFolder}/TractRegistration/whole_tract/output_tractography/whole_tract_reg.vtk

wm_harden_transform.py -t ${CurrentFolder}/TractRegistration/whole_tract/output_tractography/itk_txform_whole_tract.tfm ${CurrentFolder}/ ${CurrentFolder}/TractRegistration/whole_tract/output_tractography/ ${SlicerPath}/Slicer

wm_quality_control_tract_overlap.py ${CurrentFolder}/ORG-Atlases-1.1.1/ORG-800FC-100HCP/atlas.vtp ${CurrentFolder}/TractRegistration/whole_tract/output_tractography/U_fibers.vtk ${CurrentFolder}/QC/RegTractOverlap/

wm_cluster_from_atlas.py -l ${min_len} -j ${num_of_processor} ${CurrentFolder}/TractRegistration/whole_tract/output_tractography/U_fibers.vtk ${CurrentFolder}/ORG-Atlases-1.1.1/ORG-800FC-100HCP/ ${CurrentFolder}/FiberClustering/InitialClusters/

wm_quality_control_tractography.py ${CurrentFolder}/FiberClustering/InitialClusters/U_fibers/ ${CurrentFolder}/QC/FiberCluster-Initial/

wm_cluster_remove_outliers.py ${CurrentFolder}/FiberClustering/InitialClusters/U_fibers/ ${CurrentFolder}/ORG-Atlases-1.1.1/ORG-800FC-100HCP/ ${CurrentFolder}/FiberClustering/OutlierRemovedClusters/

wm_quality_control_tractography.py ${CurrentFolder}/FiberClustering/OutlierRemovedClusters/U_fibers_outlier_removed/ ${CurrentFolder}/QC/FiberCluster-OutlierRemoved/

wm_assess_cluster_location_by_hemisphere.py ${CurrentFolder}/FiberClustering/OutlierRemovedClusters/U_fibers_outlier_removed/ -clusterLocationFile ${CurrentFolder}/ORG-Atlases-1.1.1/ORG-800FC-100HCP/cluster_hemisphere_location.txt

wm_harden_transform.py -i -t ${CurrentFolder}/TractRegistration/whole_tract/output_tractography/itk_txform_whole_tract.tfm ${CurrentFolder}/FiberClustering/OutlierRemovedClusters/U_fibers_outlier_removed/ ${CurrentFolder}/FiberClustering/TransformedClusters/U_fibers/ ${SlicerPath}/Slicer

wm_separate_clusters_by_hemisphere.py ${CurrentFolder}/FiberClustering/TransformedClusters/U_fibers/ ${CurrentFolder}/FiberClustering/SeparatedClusters/

wm_append_clusters_to_anatomical_tracts.py ${CurrentFolder}/FiberClustering/SeparatedClusters/ ${CurrentFolder}/ORG-Atlases-1.1.1/ORG-800FC-100HCP/ ${CurrentFolder}/AnatomicalTracts/

wm_quality_control_tractography.py ${CurrentFolder}/AnatomicalTracts/ ${CurrentFolder}/QC/AnatomicalTracts/

Filtered_SubFolder=`ls $CurrentFolder | grep -v "ORG-Atlases-1.1.1" | grep -v "WMA_clustering_SWM.sh" | grep -v "UFA_vtp2tck.py" | grep -v "WMA_clustering.sh"`

for i in ${Filtered_SubFolder}
do
   mv ${CurrentFolder}/${i} ${OutputFolder}
done

cp ${CurrentFolder}/UFA_vtp2tck.py ${OutputFolder}/

cd ${OutputFolder}/

echo `python -c 'import UFA_vtp2tck'`

rm ${OutputFolder}/UFA_vtp2tck.py

}

WMA_clustering_SWM $1 $2 $3 $4 $5

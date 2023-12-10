#!bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14


UFA_neighbor_gyri(){

Input_dir="$1"

Output_dir="$2"

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11115 -eq ${Output_dir}/lh_G_front_middle.mif -force

mrconvert ${Output_dir}/lh_G_front_middle.mif ${Output_dir}/lh_G_front_middle.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11116 -eq ${Output_dir}/lh_G_front_sup.mif -force

mrconvert ${Output_dir}/lh_G_front_sup.mif ${Output_dir}/lh_G_front_sup.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11106 -eq ${Output_dir}/lh_G_S_cingul_Ant.mif -force

mrconvert ${Output_dir}/lh_G_S_cingul_Ant.mif ${Output_dir}/lh_G_S_cingul_Ant.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11129 -eq ${Output_dir}/lh_G_precentral.mif -force

mrconvert ${Output_dir}/lh_G_precentral.mif ${Output_dir}/lh_G_precentral.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11128 -eq ${Output_dir}/lh_G_postcentral.mif -force

mrconvert ${Output_dir}/lh_G_postcentral.mif ${Output_dir}/lh_G_postcentral.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11146 -eq ${Output_dir}/lh_S_central.mif -force

mrconvert ${Output_dir}/lh_S_central.mif ${Output_dir}/lh_S_central.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11153 -eq ${Output_dir}/lh_S_front_inf.mif -force

mrconvert ${Output_dir}/lh_S_front_inf.mif ${Output_dir}/lh_S_front_inf.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11154 -eq ${Output_dir}/lh_S_front_middle.mif -force

mrconvert ${Output_dir}/lh_S_front_middle.mif ${Output_dir}/lh_S_front_middle.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11155 -eq ${Output_dir}/lh_S_front_sup.mif -force

mrconvert ${Output_dir}/lh_S_front_sup.mif ${Output_dir}/lh_S_front_sup.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11165 -eq ${Output_dir}/lh_S_orbital_H_Shaped.mif -force

mrconvert ${Output_dir}/lh_S_orbital_H_Shaped.mif ${Output_dir}/lh_S_orbital_H_Shaped.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11167 -eq ${Output_dir}/lh_S_pericallosal.mif -force

mrconvert ${Output_dir}/lh_S_pericallosal.mif ${Output_dir}/lh_S_pericallosal.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11169 -eq ${Output_dir}/lh_S_precentral_inf_part.mif -force

mrconvert ${Output_dir}/lh_S_precentral_inf_part.mif ${Output_dir}/lh_S_precentral_inf_part.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11170 -eq ${Output_dir}/lh_S_precentral_sup_part.mif -force

mrconvert ${Output_dir}/lh_S_precentral_sup_part.mif ${Output_dir}/lh_S_precentral_sup_part.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12115 -eq ${Output_dir}/rh_G_front_middle.mif -force

mrconvert ${Output_dir}/rh_G_front_middle.mif ${Output_dir}/rh_G_front_middle.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12116 -eq ${Output_dir}/rh_G_front_sup.mif -force

mrconvert ${Output_dir}/rh_G_front_sup.mif ${Output_dir}/rh_G_front_sup.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12106 -eq ${Output_dir}/rh_G_S_cingul_Ant.mif -force

mrconvert ${Output_dir}/rh_G_S_cingul_Ant.mif ${Output_dir}/rh_G_S_cingul_Ant.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12124 -eq ${Output_dir}/rh_G_orbital.mif -force

mrconvert ${Output_dir}/rh_G_orbital.mif ${Output_dir}/rh_G_orbital.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12129 -eq ${Output_dir}/rh_G_precentral.mif -force

mrconvert ${Output_dir}/rh_G_precentral.mif ${Output_dir}/rh_G_precentral.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12146 -eq ${Output_dir}/rh_S_central.mif -force

mrconvert ${Output_dir}/rh_S_central.mif ${Output_dir}/rh_S_central.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12153 -eq ${Output_dir}/rh_S_front_inf.mif -force

mrconvert ${Output_dir}/rh_S_front_inf.mif ${Output_dir}/rh_S_front_inf.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12154 -eq ${Output_dir}/rh_S_front_middle.mif -force

mrconvert ${Output_dir}/rh_S_front_middle.mif ${Output_dir}/rh_S_front_middle.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12155 -eq ${Output_dir}/rh_S_front_sup.mif -force

mrconvert ${Output_dir}/rh_S_front_sup.mif ${Output_dir}/rh_S_front_sup.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12165 -eq ${Output_dir}/rh_S_orbital_H_shaped.mif -force

mrconvert ${Output_dir}/rh_S_orbital_H_shaped.mif ${Output_dir}/rh_S_orbital_H_shaped.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12169 -eq ${Output_dir}/rh_S_precentral_inf_part.mif -force

mrconvert ${Output_dir}/rh_S_precentral_inf_part.mif  ${Output_dir}/rh_S_precentral_inf_part.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12170 -eq ${Output_dir}/rh_S_precentral_sup_part.mif -force

mrconvert ${Output_dir}/rh_S_precentral_sup_part.mif ${Output_dir}/rh_S_precentral_sup_part.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11125 -eq ${Output_dir}/lh_G_pariet_inf_Angular.mif -force

mrconvert ${Output_dir}/lh_G_pariet_inf_Angular.mif ${Output_dir}/lh_G_pariet_inf_Angular.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11126 -eq ${Output_dir}/lh_G_pariet_inf_Supramar.mif -force

mrconvert ${Output_dir}/lh_G_pariet_inf_Supramar.mif ${Output_dir}/lh_G_pariet_inf_Supramar.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11127 -eq ${Output_dir}/lh_G_parietal_sup.mif -force

mrconvert ${Output_dir}/lh_G_parietal_sup.mif ${Output_dir}/lh_G_parietal_sup.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11128 -eq ${Output_dir}/lh_G_postcentral.mif -force

mrconvert ${Output_dir}/lh_G_postcentral.mif ${Output_dir}/lh_G_postcentral.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11157 -eq ${Output_dir}/lh_S_intrapariet_P_trans.mif -force

mrconvert ${Output_dir}/lh_S_intrapariet_P_trans.mif ${Output_dir}/lh_S_intrapariet_P_trans.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11168 -eq ${Output_dir}/lh_S_postcentral.mif -force

mrconvert ${Output_dir}/lh_S_postcentral.mif ${Output_dir}/lh_S_postcentral.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12125 -eq  ${Output_dir}/rh_G_pariet_inf_Angular.mif -force

mrconvert ${Output_dir}/rh_G_pariet_inf_Angular.mif ${Output_dir}/rh_G_pariet_inf_Angular.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12126 -eq ${Output_dir}/rh_G_pariet_inf_Supramar.mif -force

mrconvert ${Output_dir}/rh_G_pariet_inf_Supramar.mif ${Output_dir}/rh_G_pariet_inf_Supramar.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12127 -eq ${Output_dir}/rh_G_parietal_sup.mif -force

mrconvert ${Output_dir}/rh_G_parietal_sup.mif ${Output_dir}/rh_G_parietal_sup.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12141 -eq ${Output_dir}/rh_Lat_Fis_post.mif -force

mrconvert ${Output_dir}/rh_Lat_Fis_post.mif ${Output_dir}/rh_Lat_Fis_post.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12157 -eq ${Output_dir}/rh_S_intrapariet_P_trans.mif -force

mrconvert ${Output_dir}/rh_S_intrapariet_P_trans.mif ${Output_dir}/rh_S_intrapariet_P_trans.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12166 -eq ${Output_dir}/rh_S_parieto_occipital.mif -force

mrconvert ${Output_dir}/rh_S_parieto_occipital.mif ${Output_dir}/rh_S_parieto_occipital.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12168 -eq ${Output_dir}/rh_S_postcentral.mif -force

mrconvert ${Output_dir}/rh_S_postcentral.mif ${Output_dir}/rh_S_postcentral.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12128 -eq ${Output_dir}/rh_G_postcentral.mif -force

mrconvert ${Output_dir}/rh_G_postcentral.mif ${Output_dir}/rh_G_postcentral.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11122 -eq ${Output_dir}/lh_G_oc_temp_med_Lingual.mif -force

mrconvert ${Output_dir}/lh_G_oc_temp_med_Lingual.mif ${Output_dir}/lh_G_oc_temp_med_Lingual.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11158 -eq ${Output_dir}/lh_S_oc_middle_Lunatus.mif -force

mrconvert ${Output_dir}/lh_S_oc_middle_Lunatus.mif ${Output_dir}/lh_S_oc_middle_Lunatus.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11119 -eq ${Output_dir}/lh_G_occipital_middle.mif -force

mrconvert ${Output_dir}/lh_G_occipital_middle.mif ${Output_dir}/lh_G_occipital_middle.nii

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11159 -eq ${Output_dir}/lh_S_oc_sup_transversal.mif -force

mrconvert ${Output_dir}/lh_S_oc_sup_transversal.mif ${Output_dir}/lh_S_oc_sup_transversal.nii

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11166 -eq ${Output_dir}/lh_S_parieto_occipital.mif -force

mrconvert ${Output_dir}/lh_S_parieto_occipital.mif ${Output_dir}/lh_S_parieto_occipital.nii

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12111 -eq ${Output_dir}/rh_G_cuneus.mif -force

mrconvert ${Output_dir}/rh_G_cuneus.mif ${Output_dir}/rh_G_cuneus.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12119 -eq ${Output_dir}/rh_G_occipital_middle.mif -force

mrconvert ${Output_dir}/rh_G_occipital_middle.mif ${Output_dir}/rh_G_occipital_middle.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12122 -eq ${Output_dir}/rh_G_oc_temp_med_Lingual.mif -force

mrconvert ${Output_dir}/rh_G_oc_temp_med_Lingual.mif ${Output_dir}/rh_G_oc_temp_med_Lingual.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12143 -eq ${Output_dir}/rh_Pole_occipital.mif -force

mrconvert ${Output_dir}/rh_Pole_occipital.mif ${Output_dir}/rh_Pole_occipital.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12158 -eq ${Output_dir}/rh_S_oc_middle_Lunatus.mif -force

mrconvert ${Output_dir}/rh_S_oc_middle_Lunatus.mif ${Output_dir}/rh_S_oc_middle_Lunatus.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12159 -eq ${Output_dir}/rh_S_oc_sup_transveral.mif -force

mrconvert ${Output_dir}/rh_S_oc_sup_transveral.mif ${Output_dir}/rh_S_oc_sup_transveral.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12120 -eq ${Output_dir}/rh_G_occipital_sup.mif -force

mrconvert ${Output_dir}/rh_G_occipital_sup.mif ${Output_dir}/rh_G_occipital_sup.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11174 -eq ${Output_dir}/lh_S_temporal_sup.mif -force

mrconvert ${Output_dir}/lh_S_temporal_sup.mif ${Output_dir}/lh_S_temporal_sup.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 11138 -eq ${Output_dir}/lh_G_temporal_middle.mif -force

mrconvert ${Output_dir}/lh_G_temporal_middle.mif ${Output_dir}/lh_G_temporal_middle.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12138 -eq ${Output_dir}/rh_G_temporal_middle.mif -force

mrconvert ${Output_dir}/rh_G_temporal_middle.mif ${Output_dir}/rh_G_temporal_middle.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12141 -eq ${Output_dir}/rh_Lat_Fis_post.mif -force

mrconvert ${Output_dir}/rh_Lat_Fis_post.mif ${Output_dir}/rh_Lat_Fis_post.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12174 -eq ${Output_dir}/rh_S_temporal_sup.mif -force

mrconvert ${Output_dir}/rh_S_temporal_sup.mif ${Output_dir}/rh_S_temporal_sup.nii -force

mrcalc ${Input_dir}/mri/aparc.a2009s+aseg.mgz 12108 -eq ${Output_dir}/rh_G_S_cingul_Mid_Post.mif -force

mrconvert ${Output_dir}/rh_G_S_cingul_Mid_Post.mif ${Output_dir}/rh_G_S_cingul_Mid_Post.nii -force

}

UFA_neighbor_gyri $1 $2




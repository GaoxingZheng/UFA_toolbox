function UFA_U_fiber_filter(SWM_folder,Gyrus_folder)

% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14


% addpath('/home/zhenggaoxing/Public/U_fiber_Analysis/U_fiber_generate');
% 
% SWM_folder = '/home/zhenggaoxing/Public/FastSurfer/Tutorial/data';
% 
% Gyrus_folder = '/home/zhenggaoxing/Public/FastSurfer/Tutorial/output/U_fiber_filter';

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_G_front_middle.nii','lh_G_front_middle.nii','lh_G_front_middle_2_G_front_middle.tck',SWM_folder,Gyrus_folder) % (1) 11,115 : 11,115

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_G_front_sup.nii','lh_G_S_cingul_Ant.nii','lh_G_front_sup_2_G_S_cingul_Ant.tck',SWM_folder,Gyrus_folder) % (2) 11,116 : 11,106

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_G_front_sup.nii','lh_G_front_middle.nii','lh_G_front_sup_2_G_front_middle.tck',SWM_folder,Gyrus_folder) % (3) 11,116 : 11,115

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_G_front_sup.nii','lh_G_front_sup.nii','lh_G_front_sup_2_G_front_sup.tck',SWM_folder,Gyrus_folder) % (4) 11,116 : 11,116

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_G_precentral.nii','lh_G_postcentral.nii','lh_G_precentral_2_G_postcentral.tck',SWM_folder,Gyrus_folder) % (5) 11,129 : 11,128

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_G_precentral.nii','lh_G_precentral.nii','lh_G_precentral_2_G_precentral.tck',SWM_folder,Gyrus_folder) % (6) 11,129 : 11,129

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_central.nii','lh_G_precentral.nii','lh_S_central_2_G_precentral.tck',SWM_folder,Gyrus_folder) % (7) 11,146 : 11,129

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_central.nii','lh_S_central.nii','lh_S_central_2_S_central.tck',SWM_folder,Gyrus_folder) % (8) 11,146 : 11,146

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_front_inf.nii','lh_G_front_middle.nii','lh_S_front_inf_2_G_front_middle.tck',SWM_folder,Gyrus_folder) % (9) 11,153 : 11,115

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_front_inf.nii','lh_S_front_inf.nii','lh_S_front_inf_2_S_front_inf.tck',SWM_folder,Gyrus_folder) % (10) 11,153 : 11,153

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_front_middle.nii','lh_G_front_middle.nii','lh_S_front_middle_2_G_front_middle.tck',SWM_folder,Gyrus_folder) % (11) 11,154 : 11,115

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_front_sup.nii','lh_G_front_middle.nii','lh_S_front_sup_2_G_front_middle.tck',SWM_folder,Gyrus_folder) % (12) 11,155 : 11,115

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_front_sup.nii','lh_G_front_sup.nii','lh_S_front_sup_2_G_front_sup.tck',SWM_folder,Gyrus_folder) % (13) 11,155 : 11,116

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_front_sup.nii','lh_S_front_sup.nii','lh_S_front_sup_2_S_front_sup.tck',SWM_folder,Gyrus_folder) % (14) 11,155 : 11,155

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_orbital_H_Shaped.nii','lh_S_orbital_H_Shaped.nii','lh_S_orbital_H_Shaped_2_S_orbital_H_Shaped.tck',SWM_folder,Gyrus_folder) % (15) 11,165 : 11,165

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_pericallosal.nii','lh_G_front_sup.nii','lh_S_pericallosal_2_G_front_sup.tck',SWM_folder,Gyrus_folder) % (16) 11,167 : 11,116

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_precentral_inf_part.nii','lh_S_front_inf.nii','lh_S_precentral_inf_part_2_S_front_inf.tck',SWM_folder,Gyrus_folder) % (17) 11,169 : 11,153

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_precentral_inf_part.nii','lh_S_precentral_inf_part.nii','lh_S_precentral_inf_part_2_S_precentral_inf_part.tck',SWM_folder,Gyrus_folder) % (18) 11,169 : 11,1169

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_precentral_sup_part.nii ','lh_G_precentral.nii','lh_S_precentral_sup_part_2_G_precentral.tck',SWM_folder,Gyrus_folder) % (19) 11,170 : 11,129

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_precentral_sup_part.nii ','lh_S_precentral_sup_part.nii','lh_S_precentral_sup_part_2_S_precentral_sup_part.tck',SWM_folder,Gyrus_folder) % (20) 11,170 : 11,170

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_front_middle.nii','rh_G_front_middle.nii','rh_G_front_middle_2_G_front_middle.tck',SWM_folder,Gyrus_folder) % (21) 12,115 : 12,115

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_front_sup.nii','rh_G_S_cingul_Ant.nii','rh_G_front_sup_2_G_S_cingul_Ant.tck',SWM_folder,Gyrus_folder) % (22) 12,116 : 12,106

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_front_sup.nii','rh_G_front_middle.nii','rh_G_front_sup_2_rh_G_front_middle.tck',SWM_folder,Gyrus_folder) % (23) 12,116 : 12,115

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_front_sup.nii','rh_G_front_sup.nii','rh_G_front_sup_2_G_front_sup.tck',SWM_folder,Gyrus_folder) % (24) 12,116 : 12,116

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_orbital.nii','rh_G_orbital.nii','rh_G_orbital_2_G_orbital.tck',SWM_folder,Gyrus_folder) % (25) 12,124 : 12,124

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_precentral.nii','rh_G_precentral.nii','rh_G_precentral_2_G_precentral.tck',SWM_folder,Gyrus_folder) % (26) 12,129 : 12,129

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_central.nii','rh_G_precentral.nii','rh_S_central_2_G_precentral.tck',SWM_folder,Gyrus_folder) % (27) 12,146 : 12,129

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_front_inf.nii','rh_G_front_middle.nii','rh_S_front_inf_2_G_front_middle.tck',SWM_folder,Gyrus_folder) % (28) 12,153 : 12,115

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_front_inf.nii','rh_S_front_inf.nii','rh_S_front_inf_2_S_front_inf.tck',SWM_folder,Gyrus_folder) % (29) 12,153 : 12,153

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_front_middle.nii','rh_G_front_middle.nii','rh_S_front_middle_2_G_front_middle.tck',SWM_folder,Gyrus_folder) % (30) 12,154 : 12,115

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_front_middle.nii','rh_S_front_middle.nii','rh_S_front_middle_2_S_front_middle.tck',SWM_folder,Gyrus_folder) % (31) 12,154 : 12,154

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_front_sup.nii','rh_G_front_middle.nii','rh_S_front_sup_2_G_front_middle.tck',SWM_folder,Gyrus_folder) % (32) 12,155 : 12,115

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_front_sup.nii','rh_G_front_sup.nii','rh_S_front_sup_2_G_front_sup.tck',SWM_folder,Gyrus_folder) % (33) 12,155 : 12,116

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_front_sup.nii','rh_S_front_sup.nii','rh_S_front_sup_2_S_front_sup.tck',SWM_folder,Gyrus_folder) % (34) 12,155 : 12,155

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_orbital_H_shaped.nii','rh_G_orbital.nii','rh_S_orbital_H_shaped_2_G_orbital.tck',SWM_folder,Gyrus_folder) % (35) 12,165 : 12,124

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_S_cingul_Mid_Post.nii','rh_G_front_sup.nii','rh_G_S_cingul_Mid_Post_2_G_front_sup.tck',SWM_folder,Gyrus_folder) %%%%%% (36) 12,167 : 12,116

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_precentral_inf_part.nii','rh_S_front_inf.nii','rh_S_precentral_inf_part_2_S_front_inf.tck',SWM_folder,Gyrus_folder) % (37) 12,169 : 12,153

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_precentral_inf_part.nii','rh_S_precentral_inf_part.nii','rh_S_precentral_inf_part_2_S_precentral_inf_part.tck',SWM_folder,Gyrus_folder) % (38) 12,169 : 12,169

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_precentral_sup_part.nii','rh_G_precentral.nii','rh_S_precentral_sup_part_2_G_precentral.tck',SWM_folder,Gyrus_folder) % (39) 12,170 : 12,129

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_precentral_sup_part.nii','rh_S_precentral_sup_part.nii','rh_S_precentral_sup_part_2_S_precentral_sup_part.tck',SWM_folder,Gyrus_folder) % (40) 12,170 : 12,170

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_G_pariet_inf_Angular.nii','lh_G_pariet_inf_Angular.nii','lh_G_pariet_inf_Angular_2_G_pariet_inf_Angular.tck',SWM_folder,Gyrus_folder) % (41) 11,125 : 11,125

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_G_pariet_inf_Supramar.nii','lh_G_pariet_inf_Supramar.nii','lh_G_pariet_inf_Supramar_2_G_pariet_inf_Supramar.tck',SWM_folder,Gyrus_folder) % (42) 11,126 : 11,126

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_G_parietal_sup.nii','lh_G_parietal_sup.nii','lh_G_parietal_sup_2_G_parietal_sup.tck',SWM_folder,Gyrus_folder) % (43) 11,127 : 11,127

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_G_postcentral.nii','lh_G_postcentral.nii','lh_G_postcentral_2_G_postcentral.tck',SWM_folder,Gyrus_folder) % (44) 11,128 : 11,128

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_intrapariet_P_trans.nii','lh_G_pariet_inf_Angular.nii','lh_S_intrapariet_P_trans_2_G_pariet_inf_Angular.tck',SWM_folder,Gyrus_folder) % (45) 11,157 : 11,125

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_intrapariet_P_trans.nii','lh_G_parietal_sup.nii','lh_S_intrapariet_P_trans_2_lh_G_parietal_sup.tck',SWM_folder,Gyrus_folder) % (46) 11,157 : 11,127

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_intrapariet_P_trans.nii','lh_S_intrapariet_P_trans.nii','lh_S_intrapariet_P_trans_2_S_intrapariet_P_trans.tck',SWM_folder,Gyrus_folder) % (47) 11,157 : 11,157

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_postcentral.nii','lh_G_postcentral.nii','lh_S_postcentral_2_G_postcentral.tck',SWM_folder,Gyrus_folder) % (48) 11,168 : 11,128

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_postcentral.nii','lh_S_postcentral.nii','lh_S_postcentral_2_S_postcentral.tck',SWM_folder,Gyrus_folder) % (49) 11,168 : 11,168

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_pariet_inf_Angular.nii','rh_G_pariet_inf_Angular.nii','rh_G_pariet_inf_Angular_2_G_pariet_inf_Angular.tck',SWM_folder,Gyrus_folder) % (50) 12,125 : 12,125

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_pariet_inf_Supramar.nii','rh_G_pariet_inf_Supramar.nii','rh_G_pariet_inf_Supramar_2_G_pariet_inf_Supramar.tck',SWM_folder,Gyrus_folder) % (51) 12,126 : 12,126

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_parietal_sup.nii','rh_G_parietal_sup.nii','rh_G_parietal_sup_2_G_parietal_sup.tck',SWM_folder,Gyrus_folder) % (52) 12,127 : 12,127

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_Lat_Fis_post.nii','rh_G_pariet_inf_Supramar.nii','rh_Lat_Fis_post_2_G_pariet_inf_Supramar.tck',SWM_folder,Gyrus_folder) % (53) 12,141 : 12,126

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_central.nii','rh_S_central.nii','rh_S_central_2_S_central.tck',SWM_folder,Gyrus_folder) % (54) 12,146 : 12,146

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_intrapariet_P_trans.nii','rh_G_pariet_inf_Angular.nii','rh_S_intrapariet_P_trans_2_G_pariet_inf_Angular.tck',SWM_folder,Gyrus_folder) % (55) 12,157 : 12,125

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_intrapariet_P_trans.nii','rh_G_parietal_sup.nii','rh_S_intrapariet_P_trans_2_G_parietal_sup.tck',SWM_folder,Gyrus_folder) % (56) 12,157 : 12,127

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_intrapariet_P_trans.nii','rh_S_intrapariet_P_trans.nii','rh_S_intrapariet_P_trans_2_S_intrapariet_P_trans.tck',SWM_folder,Gyrus_folder) % (57) 12,157 : 12,157

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_parieto_occipital.nii','rh_S_parieto_occipital.nii','rh_S_parieto_occipital_2_S_parieto_occipital..tck',SWM_folder,Gyrus_folder) % (58) 12,166 : 12,166

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_postcentral.nii','rh_G_postcentral.nii','rh_S_postcentral_2_G_postcentral.tck',SWM_folder,Gyrus_folder) % (59) 12,168 : 12,128

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_postcentral.nii','rh_S_intrapariet_P_trans.nii','rh_S_postcentral_2_S_intrapariet_P_trans.tck',SWM_folder,Gyrus_folder) % (60) 12,168 : 12,157

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_postcentral.nii','rh_S_postcentral.nii','rh_S_postcentral_2_S_postcentral.tck',SWM_folder,Gyrus_folder) % (61) 12,168 : 12,168

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_G_oc_temp_med_Lingual.nii','lh_G_oc_temp_med_Lingual.nii','lh_G_oc_temp_med_Lingual_2_G_oc_temp_med_Lingual.tck',SWM_folder,Gyrus_folder) % (62) 11,122 : 11,122

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_oc_middle_Lunatus.nii','lh_G_occipital_middle.nii','lh_S_oc_middle_Lunatus_2_G_occipital_middle.tck',SWM_folder,Gyrus_folder) % (63) 11,158 : 11,119

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_oc_sup_transversal.nii','lh_S_oc_sup_transversal.nii','lh_S_oc_sup_transversal_2_S_oc_sup_transversal.tck',SWM_folder,Gyrus_folder) % (64) 11,159 : 11,159

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_parieto_occipital.nii','lh_S_parieto_occipital.nii','lh_S_parieto_occipita_2_S_parieto_occipita.tck',SWM_folder,Gyrus_folder) % (65) 11,166 : 11,166

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_cuneus.nii','rh_G_cuneus.nii','rh_G_cuneus_2_G_cuneus.tck',SWM_folder,Gyrus_folder) % (66) 12,111 : 12,111

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_occipital_middle.nii','rh_G_occipital_middle.nii','rh_G_occipital_middle_2_G_occipital_middle.tck',SWM_folder,Gyrus_folder) % (67) 12,119 : 12,119

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_oc_temp_med_Lingual.nii','rh_G_oc_temp_med_Lingual.nii','rh_G_oc_temp_med_Lingual_2_G_oc_temp_med_Lingual.tck',SWM_folder,Gyrus_folder) % (68) 12,122 : 12,122

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_Pole_occipital.nii','rh_Pole_occipital.nii','rh_Pole_occipital_2_Pole_occipital.tck',SWM_folder,Gyrus_folder) % (69) 12,143 : 12,143

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_oc_middle_Lunatus.nii','rh_G_occipital_middle.nii','rh_S_oc_middle_Lunatus_2_G_occipital_middle.tck',SWM_folder,Gyrus_folder) % (70) 12,158 : 12,119

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_oc_sup_transveral.nii','rh_G_occipital_sup.nii','rh_S_oc_sup_transveral_2_G_occipital_sup.tck',SWM_folder,Gyrus_folder) % (71) 12,159 : 12,120

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_oc_sup_transveral.nii','rh_S_oc_sup_transveral.nii','rh_S_oc_sup_transveral_2_S_oc_sup_transveral.tck',SWM_folder,Gyrus_folder) % (72) 12,159 : 12,159

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_temporal_sup.nii','lh_G_pariet_inf_Angular.nii','lh_S_temporal_sup_2_G_pariet_inf_Angular.tck',SWM_folder,Gyrus_folder) % (73) 11,174 : 11,125

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_temporal_sup.nii','lh_G_temporal_middle.nii','lh_S_temporal_sup_2_G_temporal_middle.tck',SWM_folder,Gyrus_folder) % (74) 11,174 : 11,138

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_S_temporal_sup.nii','lh_S_temporal_sup.nii','lh_S_temporal_sup_2_S_temporal_sup.tck',SWM_folder,Gyrus_folder) % (75) 11,174 : 11,174

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_temporal_middle.nii','rh_G_temporal_middle.nii','rh_G_temporal_middle_2_G_temporal_middle.tck',SWM_folder,Gyrus_folder) % (76) 12,138 : 12,138

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_Lat_Fis_post.nii','rh_Lat_Fis_post.nii','rh_Lat_Fis_post_2_Lat_Fis_post.tck',SWM_folder,Gyrus_folder) % (77) 12,141 : 12,141

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_temporal_sup.nii','rh_G_pariet_inf_Angular.nii','rh_S_temporal_sup_2_G_pariet_inf_Angular.tck',SWM_folder,Gyrus_folder) % (78) 12,174 : 12,125

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_temporal_sup.nii','rh_G_temporal_middle.nii','rh_S_temporal_sup_2_G_temporal_middle.tck',SWM_folder,Gyrus_folder) % (79) 12,174 : 12,138

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_S_temporal_sup.nii','rh_S_temporal_sup.nii','rh_S_temporal_sup_2_S_temporal_sup.tck',SWM_folder,Gyrus_folder) % (80) 12,174 : 12,174

UFA_negibor_gyri_filter('U_fiber_tractography.tck','lh_G_S_cingul_Ant.nii','lh_G_S_cingul_Ant.nii','lh_G_S_cingul_Ant_2_G_S_cingul_Ant.tck',SWM_folder,Gyrus_folder) % (81) 11,106 : 11,106

UFA_negibor_gyri_filter('U_fiber_tractography.tck','rh_G_S_cingul_Ant.nii','rh_G_S_cingul_Ant.nii','rh_G_S_cingul_Ant_2_G_S_cingul_Ant.tck',SWM_folder,Gyrus_folder) % (82) 12,106 : 12,106

end









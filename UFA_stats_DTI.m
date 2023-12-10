function UFA_stats_DTI(Input_Folder,view_direction)

% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14

SWM_Path = [Input_Folder,'/WMA_clustering_SWM'];

DWI_Path = [Input_Folder,'/DWI/Tracking'];

if exist([SWM_Path,'/Stats_DTI'],'dir') == 0
    
    mkdir([SWM_Path,'/Stats_DTI'])
    
end

unix(['tcksample ',[SWM_Path,'/AnatomicalTracts/',view_direction,'.tck'],' ',[DWI_Path,'/dt_fa.mif'],' ',[SWM_Path,'/Stats_DTI/FA_',view_direction,'.txt'],' -stat_tck mean -force']);

unix(['tcksample ',[SWM_Path,'/AnatomicalTracts/',view_direction,'.tck'],' ',[DWI_Path,'/dt_md.mif'],' ',[SWM_Path,'/Stats_DTI/MD_',view_direction,'.txt'],' -stat_tck mean -force']);

unix(['tcksample ',[SWM_Path,'/AnatomicalTracts/',view_direction,'.tck'],' ',[DWI_Path,'/dt_ad.mif'],' ',[SWM_Path,'/Stats_DTI/AD_',view_direction,'.txt'],' -stat_tck mean -force']);

unix(['tcksample ',[SWM_Path,'/AnatomicalTracts/',view_direction,'.tck'],' ',[DWI_Path,'/dt_rd.mif'],' ',[SWM_Path,'/Stats_DTI/RD_',view_direction,'.txt'],' -stat_tck mean -force']);

% unix(['tcksample ',[SWM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_fa.mif'],' ',[SWM_Path,'/Stats_DTI/FA_',view_direction,'.txt'],' -stat_tck mean -force']);
% 
% unix(['tcksample ',[SWM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_md.mif'],' ',[SWM_Path,'/Stats_DTI/MD_',view_direction,'.txt'],' -stat_tck mean -force']);
% 
% unix(['tcksample ',[SWM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_ad.mif'],' ',[SWM_Path,'/Stats_DTI/AD_',view_direction,'.txt'],' -stat_tck mean -force']);
% 
% unix(['tcksample ',[SWM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_rd.mif'],' ',[SWM_Path,'/Stats_DTI/RD_',view_direction,'.txt'],' -stat_tck mean -force']);

FA = importdata([SWM_Path,'/Stats_DTI/FA_',view_direction,'.txt']);

MD = importdata([SWM_Path,'/Stats_DTI/MD_',view_direction,'.txt']);

AD = importdata([SWM_Path,'/Stats_DTI/AD_',view_direction,'.txt']);

RD = importdata([SWM_Path,'/Stats_DTI/RD_',view_direction,'.txt']);

figure,subplot(221),plot(FA.data),ylabel('FA')

subplot(222),plot(MD.data),ylabel('MD')

subplot(223),plot(AD.data),ylabel('AD')

subplot(224),plot(RD.data),ylabel('RD')
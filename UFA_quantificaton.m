function UFA_quantificaton(UFA_Folder,minlen,maxlen)

% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14


WM_tck_files = dir(fullfile(UFA_Folder,'/WMA_clustering_SWM/*.tck'));

U_fiber_name = {};

U_fiber_couts = [];

U_fiber_len = [];

for flag = 1:length(WM_tck_files)
    
    fiber_name = WM_tck_files(flag).name;
    
    fiber_name = fiber_name(1:length(fiber_name)-4);
    
    if contains(fiber_name,'Sup')
        
        unix(['tckstats ', [UFA_Folder,'/WMA_clustering_SWM/',fiber_name,'.tck'],' -dump ',[UFA_Folder,'/WMA_clustering_SWM/',fiber_name,'.txt'],'  -force']);
        
        fiber_txt = importdata([UFA_Folder,'/WMA_clustering_SWM/',fiber_name,'.txt']);
        
        if ~isempty(fiber_txt)
            
            U_fiber_name = [U_fiber_name; fiber_name];
            
            U_fiber_couts = [U_fiber_couts, length(fiber_txt)];
            
            U_fiber_len = [U_fiber_len, mean(fiber_txt)];
            
        end
    end
    
end

limit1 = ones(length(U_fiber_name),2); limit1(:,1) = 0; limit1(:,2) = ceil(max(U_fiber_couts)/10)*10;

prefer1 = ones(length(U_fiber_name),2); prefer1(:,1) = 10; prefer1(:,2) = 20;

prefer2 = ones(length(U_fiber_name),2); prefer2(:,1) = minlen+20; prefer2(:,2) = maxlen-20;

limit2 = ones(length(U_fiber_name),2); limit2(:,1) = minlen; limit2(:,2) = maxlen;

figure('Name','Number of fibers','NumberTitle','off'),UFA_draw_radar(U_fiber_couts,limit1,prefer1,U_fiber_name);

figure('Name','Mean fiber length','NumberTitle','off'),UFA_draw_radar(U_fiber_len,limit2,prefer2,U_fiber_name);

SWM_Path = [UFA_Folder,'/WMA_clustering_SWM'];

DWI_Path = [UFA_Folder,'/DWI/Tracking'];

if exist([SWM_Path,'/Stats_DTI_SWM'],'dir') == 0
    
    mkdir([SWM_Path,'/Stats_DTI_SWM'])
    
end


SWM_FA = zeros(length(U_fiber_name),1);

SWM_MD = zeros(length(U_fiber_name),1);

SWM_AD = zeros(length(U_fiber_name),1);

SWM_RD = zeros(length(U_fiber_name),1);


for label = 1:length(U_fiber_name)
    
    view_direction = U_fiber_name{label};
    
    unix(['tcksample ',[SWM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_fa.mif'],' ',[SWM_Path,'/Stats_DTI_SWM/FA_',view_direction,'.txt'],' -stat_tck mean -force']);
    
    unix(['tcksample ',[SWM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_md.mif'],' ',[SWM_Path,'/Stats_DTI_SWM/MD_',view_direction,'.txt'],' -stat_tck mean -force']);
    
    unix(['tcksample ',[SWM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_ad.mif'],' ',[SWM_Path,'/Stats_DTI_SWM/AD_',view_direction,'.txt'],' -stat_tck mean -force']);
    
    unix(['tcksample ',[SWM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_rd.mif'],' ',[SWM_Path,'/Stats_DTI_SWM/RD_',view_direction,'.txt'],' -stat_tck mean -force']);
    
%     unix(['tcksample ',[SWM_Path,'/AnatomicalTracts/',view_direction,'.tck'],' ',[DWI_Path,'/dt_fa.mif'],' ',[SWM_Path,'/Stats_DTI_SWM/FA_',view_direction,'.txt'],' -stat_tck mean -force']);
%     
%     unix(['tcksample ',[SWM_Path,'/AnatomicalTracts/',view_direction,'.tck'],' ',[DWI_Path,'/dt_md.mif'],' ',[SWM_Path,'/Stats_DTI_SWM/MD_',view_direction,'.txt'],' -stat_tck mean -force']);
%     
%     unix(['tcksample ',[SWM_Path,'/AnatomicalTracts/',view_direction,'.tck'],' ',[DWI_Path,'/dt_ad.mif'],' ',[SWM_Path,'/Stats_DTI_SWM/AD_',view_direction,'.txt'],' -stat_tck mean -force']);
%     
%     unix(['tcksample ',[SWM_Path,'/AnatomicalTracts/',view_direction,'.tck'],' ',[DWI_Path,'/dt_rd.mif'],' ',[SWM_Path,'/Stats_DTI_SWM/RD_',view_direction,'.txt'],' -stat_tck mean -force']);

    FA = importdata([SWM_Path,'/Stats_DTI_SWM/FA_',view_direction,'.txt']);
    
    MD = importdata([SWM_Path,'/Stats_DTI_SWM/MD_',view_direction,'.txt']);
    
    AD = importdata([SWM_Path,'/Stats_DTI_SWM/AD_',view_direction,'.txt']);
    
    RD = importdata([SWM_Path,'/Stats_DTI_SWM/RD_',view_direction,'.txt']);
    
    SWM_FA(label) = nanmean(FA.data);
    
    SWM_MD(label) = nanmean(MD.data);
    
    SWM_AD(label) = nanmean(AD.data);
    
    SWM_RD(label) = nanmean(RD.data);
    
end

colors = colormap(hsv);

figure,ha = UFA_tightPlots(2, 2, 25, [1.3 1.3], [1.3 1.3], [1.3 1.3], [2 1.3], 'centimeters');

axes(ha(1)),

for i = 1:length(SWM_FA)
    
    bar(i, SWM_FA(i),0.5,'facecolor',colors(i*12+10,:));hold on
    
end

set(gca,'XTickLabel',[])

hold off

ylabel('mean FA')

ylim([0.2 0.6])

axes(ha(2)),

for i = 1:length(SWM_MD)
    
    bar(i,SWM_MD(i),0.5,'facecolor',colors(i*12 + 10,:));hold on
    
end

set(gca,'XTickLabel',[])

hold off

ylabel('mean MD')

ylim([4*10^(-4) 10*10^(-4)])

axes(ha(3)),

for i = 1:length(SWM_AD)
    
    bar(i,SWM_AD(i),0.5,'facecolor',colors(i*12 + 10,:));hold on
    
end

xtextp = 1:length(SWM_AD);

ytextp = 0.59*10^(-3)*ones(1,length(xtextp));

text(xtextp, ytextp, U_fiber_name,'HorizontalAlignment','right','rotation',30,'Interpreter','none');

set(gca,'XTickLabel',[])

hold off

ylabel('mean AD')

ylim([0.6*10^(-3) 1.4*10^(-3)])

axes(ha(4)),

for i = 1:length(SWM_RD)
    
    bar(i,SWM_RD(i),0.5,'facecolor',colors(i*12 + 10,:));hold on
    
end

xtextp = 1:length(SWM_RD);

ytextp = 2.9*10^(-4)*ones(1,length(xtextp));

text(xtextp, ytextp, U_fiber_name,'HorizontalAlignment','right','rotation',30,'Interpreter','none');

set(gca,'XTickLabel',[])

hold off

ylabel('mean RD')

ylim([3*10^(-4) 8*10^(-4)])
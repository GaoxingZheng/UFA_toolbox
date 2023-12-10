function UFA_WMHplot_lobe(WMH_file_path)

% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14

WMH_table = importdata([WMH_file_path,'/','WMH_spreadsheet.txt'],',',1);

for m = 1:length(WMH_table.textdata(1,2:end))
    
    WMH_var = cell2mat(WMH_table.textdata(1,m+1));
    
    eval([WMH_var,'=','[]',';'])
    
    eval([WMH_var,'= [',WMH_var,';',num2str(WMH_table.data(1,m)),'];']);
    
end

barmap = [[114 147 203]/255; [225 151 76]/255; [132 186 91]/255; [211 94 96]/255];

WMH_whole_PV_Deep_vol = [wholeBrainWMHvol_mm3, PVWMHvol_mm3, DWMHvol_mm3];

figure,bar(WMH_whole_PV_Deep_vol,'facecolor',[30,144,255]/255,'LineWidth',1,'BarWidth',0.5),alpha(0.5)
title('WMH volume (mm^3)','Interpreter','none')
ax = gca;
set(ax,'XTick',[1 2 3],'XTickLabel',{'whole','PV', 'Deep'},'fontsize',14)
ax.XTickLabelRotation = 45;
ylabel('WMH volume (mm^3)')

pause(2)
WMH_whole_PV_noc_size = [wholeBrain_WMHnoc_punctuate, wholeBrain_WMHnoc_focal, wholeBrain_WMHnoc_medium, wholeBrain_WMHnoc_confluent;
    PV_WMHnoc_punctuate, PV_WMHnoc_focal, PV_WMHnoc_medium, PV_WMHnoc_confluent];

figure,ha1 = bar(WMH_whole_PV_noc_size,'LineWidth',1,'BarWidth',1);
set(ha1(1),'facecolor',barmap(1,:))
set(ha1(2),'facecolor',barmap(2,:))
set(ha1(3),'facecolor',barmap(3,:))
set(ha1(4),'facecolor',barmap(4,:))
legend({'punctuate (< 10.125 mm^3)','focal (< 30.375 mm^3)','medium (< 50.625 mm^3)','confluent (> 50.625 mm^3)'})
legend('boxoff')
set(gca,'fontsize',16)
ax = gca;
set(ax,'XTick',[1 2],'XTickLabel',{'whole','PV'},'fontsize',14)
ax.XTickLabelRotation = 45;
ylabel('WMH clusters size')

Left_vol = [Lfrontal_WMHvol_mm3,Ltemporal_WMHvol_mm3,Lparietal_WMHvol_mm3,Loccipital_WMHvol_mm3,Lcerebellum_WMHvol_mm3];
Right_vol = [Rfrontal_WMHvol_mm3,Rtemporal_WMHvol_mm3,Rparietal_WMHvol_mm3,Roccipital_WMHvol_mm3,Rcerebellum_WMHvol_mm3];

YLabel = {'frontal','temporal','parietal','occipital','cerebellum'};
color_pair = {[0 102 204]/255,[205 92 92]/255};

pause(2)
figure,UFA_Bihemisphere_plot(Left_vol,Right_vol,YLabel,color_pair)
title('WMH volume in different lobes (mm^3)','Interpreter','none')
%{
posSmall = [0.7 0.6 0.2 0.2];
hAxS = axes('Position',posSmall);
[Img, map, alpha]  = imread('Brain_lobes.png'); 
imshow(Img);
set(hAxS , 'Color','none', 'XAxisLocation','top', 'YAxisLocation','right');
%}

Left_noc = [Lfontal_WMHnoc_total,Ltemporal_WMHnoc_total,Lparietal_WMHnoc_total,Loccipital_WMHnoc_total,Lcerebellum_WMHnoc_total];
Right_noc = [Rfontal_WMHnoc_total,Rtemporal_WMHnoc_total,Rparietal_WMHnoc_total,Roccipital_WMHnoc_total,Rcerebellum_WMHnoc_total];

pause(2)

figure,UFA_Bihemisphere_plot(Left_noc,Right_noc,YLabel,color_pair)
title('WMH clusters in different lobes','Interpreter','none')
%{
hAxS = axes('Position',posSmall);
[Img, map, alpha]  = imread('Brain_lobes.png'); 
imshow(Img);
set(hAxS , 'Color','none', 'XAxisLocation','top', 'YAxisLocation','right');
%}


Left_vol_subcortical = [lAAH_WMHvol_mm3, lAAC_WMHvol_mm3, lAAML_WMHvol_mm3, lMAH_WMHvol_mm3, lMALL_WMHvol_mm3, lPAH_WMHvol_mm3, lPAC_WMHvol_mm3, lPATMP_WMHvol_mm3];
Right_vol_subcortical = [rAAH_WMHvol_mm3, rAAC_WMHvol_mm3, rAAML_WMHvol_mm3, rMAH_WMHvol_mm3, rMALL_WMHvol_mm3, rPAH_WMHvol_mm3, rPAC_WMHvol_mm3, rPATMP_WMHvol_mm3];

YLabel_subcortical = {'A.A.H.','A.A.C.', 'A.A.M.L.','M.A.H.','M.A.L.L.', 'P.A.H.', 'P.A.C.', 'P.A.T.M.P.'};
pause(2)

figure,UFA_Bihemisphere_plot(Left_vol_subcortical,Right_vol_subcortical,YLabel_subcortical,color_pair)
title('WMH volume in different arterial territories (mm^3)','Interpreter','none')
%{
posSmall = [0.7 0.6 0.2 0.2];
hAxS = axes('Position',posSmall);
[Img, map, alpha]  = imread('Brain_lobes.png'); 
imshow(Img);
set(hAxS , 'Color','none', 'XAxisLocation','top', 'YAxisLocation','right');
%}
pause(2)
Left_noc_subcortical = [lAAH_WMHnoc_total, lAAC_WMHnoc_total, lAAML_WMHnoc_total, lMAH_WMHnoc_total, lMALL_WMHnoc_total, lPAH_WMHnoc_total, lPAC_WMHnoc_total, lPATMP_WMHnoc_total];
Right_noc_subcortical = [rAAH_WMHnoc_total, rAAC_WMHnoc_total,  rAAML_WMHnoc_total, rMAH_WMHnoc_total, rMALL_WMHnoc_total, rPAH_WMHnoc_total, rPAC_WMHnoc_total, rPATMP_WMHnoc_total];

figure,UFA_Bihemisphere_plot(Left_noc_subcortical,Right_noc_subcortical,YLabel_subcortical,color_pair)
title('WMH clusters in different arterial territories','Interpreter','none')
%{
posSmall = [0.7 0.6 0.2 0.2];
hAxS = axes('Position',posSmall);
[Img, map, alpha]  = imread('Brain_lobes.png'); 
imshow(Img);
set(hAxS , 'Color','none', 'XAxisLocation','top', 'YAxisLocation','right');
%}
pause(2)
Left_noc_subcortical_size = [lAAH_WMHnoc_punctuate, lAAC_WMHnoc_punctuate, lAAML_WMHnoc_punctuate, lMAH_WMHnoc_punctuate, lMALL_WMHnoc_punctuate, lPAH_WMHnoc_punctuate, lPAC_WMHnoc_punctuate, lPATMP_WMHnoc_punctuate;
    lAAH_WMHnoc_focal, lAAC_WMHnoc_focal, lAAML_WMHnoc_focal, lMAH_WMHnoc_focal, lMALL_WMHnoc_focal, lPAH_WMHnoc_focal, lPAC_WMHnoc_focal, lPATMP_WMHnoc_focal;
    lAAH_WMHnoc_medium, lAAC_WMHnoc_medium, lAAML_WMHnoc_medium, lMAH_WMHnoc_medium, lMALL_WMHnoc_medium, lPAH_WMHnoc_medium, lPAC_WMHnoc_medium, lPATMP_WMHnoc_medium;
    lAAH_WMHnoc_confluent, lAAC_WMHnoc_confluent, lAAML_WMHnoc_confluent, lMAH_WMHnoc_confluent, lMALL_WMHnoc_confluent, lPAH_WMHnoc_confluent, lPAC_WMHnoc_confluent, lPATMP_WMHnoc_confluent];

figure,ha = UFA_tightPlots(1,2,30,[1.3 1],[1 2],[2 1],[3 0.2], 'centimeters');
axes(ha(1)),
h1 = bar(Left_noc_subcortical_size','LineWidth',1,'BarWidth',1);
set(h1(1),'facecolor',barmap(1,:))
set(h1(2),'facecolor',barmap(2,:))
set(h1(3),'facecolor',barmap(3,:))
set(h1(4),'facecolor',barmap(4,:))

legend({'punctuate (< 10.125 mm^3)','focal (< 30.375 mm^3)','medium (< 50.625 mm^3)','confluent (> 50.625 mm^3)'})
legend('boxoff')
ylim([0 max(Left_noc_subcortical_size(:))+5])
ax = gca;
set(ax,'XTick',[1 2 3 4 5 6 7 8],'XTickLabel',{'A.A.H.','A.A.C.', 'A.A.M.L.','M.A.H.','M.A.L.L.', 'P.A.H.', 'P.A.C.', 'P.A.T.M.P.'},'fontsize',14)
ax.XTickLabelRotation = 45;
ylabel('WMH clusters size')
title('Left arterial territories')

Right_noc_subcortical_size = [rAAH_WMHnoc_punctuate, rAAC_WMHnoc_punctuate, rAAML_WMHnoc_punctuate, rMAH_WMHnoc_punctuate, rMALL_WMHnoc_punctuate, rPAH_WMHnoc_punctuate, rPAC_WMHnoc_punctuate, rPATMP_WMHnoc_punctuate;
    rAAH_WMHnoc_focal, rAAC_WMHnoc_focal, rAAML_WMHnoc_focal,rMAH_WMHnoc_focal,  rMALL_WMHnoc_focal, rPAH_WMHnoc_focal, rPAC_WMHnoc_focal, rPATMP_WMHnoc_focal;
    rAAH_WMHnoc_medium, rAAC_WMHnoc_medium, rAAML_WMHnoc_medium, rMAH_WMHnoc_medium, rMALL_WMHnoc_medium, rPAH_WMHnoc_medium, rPAC_WMHnoc_medium, rPATMP_WMHnoc_medium;
    rAAH_WMHnoc_confluent, rAAC_WMHnoc_confluent, rAAML_WMHnoc_confluent, rMAH_WMHnoc_confluent, rMALL_WMHnoc_confluent, rPAH_WMHnoc_confluent, rPAC_WMHnoc_confluent, rPATMP_WMHnoc_confluent];

axes(ha(2)),
h2 = bar(Right_noc_subcortical_size','LineWidth',1,'BarWidth',1);
set(h2(1),'facecolor',barmap(1,:))
set(h2(2),'facecolor',barmap(2,:))
set(h2(3),'facecolor',barmap(3,:))
set(h2(4),'facecolor',barmap(4,:))

% legend({'punctuate (< 10.125 mm^3)','focal (< 30.375 mm^3)','medium (< 50.625 mm^3)','confluent (> 50.625 mm^3)'})
% legend('boxoff')

ylim([0 max(Right_noc_subcortical_size(:))+2])
ax = gca;
set(ax,'XTick',[1 2 3 4 5 6 7 8],'XTickLabel',{'A.A.H.','A.A.C.', 'A.A.M.L.','M.A.H.','M.A.L.L.', 'P.A.H.', 'P.A.C.', 'P.A.T.M.P.'},'fontsize',14)
ax.XTickLabelRotation = 45;
title('Right arterial territories')


pause(2)
Left_noc_size = [Lfrontal_WMHnoc_punctuate,Ltemporal_WMHnoc_punctuate, Lparietal_WMHnoc_punctuate, Loccipital_WMHnoc_punctuate, Lcerebellum_WMHnoc_punctuate;
    Lfrontal_WMHnoc_focal,Ltemporal_WMHnoc_focal, Lparietal_WMHnoc_focal, Loccipital_WMHnoc_focal, Lcerebellum_WMHnoc_focal;
    Lfrontal_WMHnoc_medium,Ltemporal_WMHnoc_medium, Lparietal_WMHnoc_medium, Loccipital_WMHnoc_medium, Lcerebellum_WMHnoc_medium;
    Lfrontal_WMHnoc_confluent,Ltemporal_WMHnoc_confluent, Lparietal_WMHnoc_confluent, Loccipital_WMHnoc_confluent, Lcerebellum_WMHnoc_confluent];

figure,ha = UFA_tightPlots(1,2,30,[1.3 1],[1.5 1.5],[2.5 1],[2 1], 'centimeters');
axes(ha(1)),
h3 = bar(Left_noc_size','LineWidth',1,'BarWidth',1);
set(h3(1),'facecolor',barmap(1,:))
set(h3(2),'facecolor',barmap(2,:))
set(h3(3),'facecolor',barmap(3,:))
set(h3(4),'facecolor',barmap(4,:))

% legend({'punctuate (< 10.125 mm^3)','focal (< 30.375 mm^3)','medium (< 50.625 mm^3)','confluent (> 50.625 mm^3)'})
% legend('boxoff')

ylim([0 max(Left_noc_size(:))+2])
ax = gca;
set(ax,'XTick',[1 2 3 4 5],'XTickLabel',{'frontal','temporal','parietal','occipital','cerebellum'},'fontsize',14)

ax.XTickLabelRotation = 45;
ylabel('WMH clusters size')
title('Left lobes')

Right_noc_size = [Rfrontal_WMHnoc_punctuate,Rtemporal_WMHnoc_punctuate, Rparietal_WMHnoc_punctuate, Roccipital_WMHnoc_punctuate, Rcerebellum_WMHnoc_punctuate;
    Rfrontal_WMHnoc_focal,Rtemporal_WMHnoc_focal, Rparietal_WMHnoc_focal, Roccipital_WMHnoc_focal, Rcerebellum_WMHnoc_focal;
    Rfrontal_WMHnoc_medium,Rtemporal_WMHnoc_medium, Rparietal_WMHnoc_medium, Roccipital_WMHnoc_medium, Rcerebellum_WMHnoc_medium;
    Rfrontal_WMHnoc_confluent,Rtemporal_WMHnoc_confluent, Rparietal_WMHnoc_confluent, Roccipital_WMHnoc_confluent, Rcerebellum_WMHnoc_confluent];

axes(ha(2)),
h4 = bar(Right_noc_size','LineWidth',1,'BarWidth',1);
set(h4(1),'facecolor',barmap(1,:))
set(h4(2),'facecolor',barmap(2,:))
set(h4(3),'facecolor',barmap(3,:))
set(h4(4),'facecolor',barmap(4,:))

% legend({'punctuate (< 10.125 mm^3)','focal (< 30.375 mm^3)','medium (< 50.625 mm^3)','confluent (> 50.625 mm^3)'})
% legend('boxoff')

ylim([0 max(Right_noc_size(:))+2])
ax = gca;
set(ax,'XTick',[1 2 3 4 5],'XTickLabel',{'frontal','temporal','parietal','occipital','cerebellum'},'fontsize',14)
ax.XTickLabelRotation = 45;
title('Right lobes')
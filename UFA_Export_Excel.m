% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14

function UFA_Export_Excel(OutputFolder)

%% WMHs metrics

Splited_string = strsplit(OutputFolder,'/');

Total_Result_WMHs = [];

Var_Name_WMHs = {};

WMH_table = importdata([OutputFolder,'/WMH_extraction/subjects/','WMH_spreadsheet.txt'],',',1);

for m = 1:length(WMH_table.textdata(1,2:end))
    
    WMH_var = cell2mat(WMH_table.textdata(1,m+1));
    
    eval([WMH_var,'=','[]',';'])
    
    eval([WMH_var,'= [',WMH_var,';',num2str(WMH_table.data(1,m)),'];']);
    
    Var_Name_WMHs = [Var_Name_WMHs, WMH_var];
    
    Total_Result_WMHs = [Total_Result_WMHs,num2cell(WMH_table.data(1,m))];
    
end

%% U fiber metrics

WM_tck_files = dir(fullfile(OutputFolder,'/WMA_clustering_SWM/*.tck'));

SWM_fiber_name = {};

SWM_fiber_couts = [];

SWM_fiber_len = [];

for flag = 1:length(WM_tck_files)
    
    fiber_name = WM_tck_files(flag).name;
    
    fiber_name = fiber_name(1:length(fiber_name)-4);
    
    if contains(fiber_name,'Sup')
        
        unix(['tckstats ', [OutputFolder,'/WMA_clustering_SWM/',fiber_name,'.tck'],' -dump ',[OutputFolder,'/WMA_clustering_SWM/',fiber_name,'.txt'],'  -force']);
        
        fiber_txt = importdata([OutputFolder,'/WMA_clustering_SWM/',fiber_name,'.txt']);
        
        if ~isempty(fiber_txt)
            
            SWM_fiber_name = [SWM_fiber_name; fiber_name];
            
            SWM_fiber_couts = [SWM_fiber_couts, length(fiber_txt)];
            
            SWM_fiber_len = [SWM_fiber_len, mean(fiber_txt)];
            
        end
    end
    
end


SWM_Path = [OutputFolder,'/WMA_clustering_SWM'];

DWI_Path = [OutputFolder,'/DWI/Tracking'];

if exist([SWM_Path,'/Stats_DTI_SWM'],'dir') == 0
    
    mkdir([SWM_Path,'/Stats_DTI_SWM'])
    
end


SWM_FA = zeros(length(SWM_fiber_name),1);

SWM_MD = zeros(length(SWM_fiber_name),1);

SWM_AD = zeros(length(SWM_fiber_name),1);

SWM_RD = zeros(length(SWM_fiber_name),1);

for label = 1:length(SWM_fiber_name)
    
    view_direction = SWM_fiber_name{label};
    
    unix(['tcksample ',[SWM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_fa.mif'],' ',[SWM_Path,'/Stats_DTI_SWM/FA_',view_direction,'.txt'],' -stat_tck mean -force']);
    
    unix(['tcksample ',[SWM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_md.mif'],' ',[SWM_Path,'/Stats_DTI_SWM/MD_',view_direction,'.txt'],' -stat_tck mean -force']);
    
    unix(['tcksample ',[SWM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_ad.mif'],' ',[SWM_Path,'/Stats_DTI_SWM/AD_',view_direction,'.txt'],' -stat_tck mean -force']);
    
    unix(['tcksample ',[SWM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_rd.mif'],' ',[SWM_Path,'/Stats_DTI_SWM/RD_',view_direction,'.txt'],' -stat_tck mean -force']);
    
    FA = importdata([SWM_Path,'/Stats_DTI_SWM/FA_',view_direction,'.txt']);
    
    MD = importdata([SWM_Path,'/Stats_DTI_SWM/MD_',view_direction,'.txt']);
    
    AD = importdata([SWM_Path,'/Stats_DTI_SWM/AD_',view_direction,'.txt']);
    
    RD = importdata([SWM_Path,'/Stats_DTI_SWM/RD_',view_direction,'.txt']);
    
    if ~isempty(FA) && ~isempty(MD) && ~isempty(AD) && ~isempty(RD)
        
        SWM_FA(label) = nanmean(FA.data);
        
        SWM_MD(label) = nanmean(MD.data);
        
        SWM_AD(label) = nanmean(AD.data);
        
        SWM_RD(label) = nanmean(RD.data);
        
    else
        
        SWM_FA(label) = nan;
        
        SWM_MD(label) = nan;
        
        SWM_AD(label) = nan;
        
        SWM_RD(label) = nan;
        
    end
    
end

Var_Name_WMHs = ['Subject_Name_and_ID', Var_Name_WMHs];

Total_Result_WMHs = [Splited_string{end-1}, Total_Result_WMHs];

Var_Name_DTI = ['Subject_Name_and_ID', strcat(SWM_fiber_name','_FA'), strcat(SWM_fiber_name','_MD'), strcat(SWM_fiber_name','_AD'), strcat(SWM_fiber_name','_RD'), strcat(SWM_fiber_name','_Numbers'), strcat(SWM_fiber_name','_Mean_Length')];

Total_Result_DTI = [Splited_string{end-1}, num2cell(SWM_FA'), num2cell(SWM_MD'), num2cell(SWM_AD'), num2cell(SWM_RD'), num2cell(SWM_fiber_couts), num2cell(SWM_fiber_len)];

writecell([Var_Name_WMHs; Total_Result_WMHs],[OutputFolder,filesep,Splited_string{end-1},'_Results.xlsx'],'Sheet',1);

writecell([Var_Name_DTI; Total_Result_DTI],[OutputFolder,filesep, Splited_string{end-1},'_Results.xlsx'],'Sheet',2);

U_fiber_files = dir([OutputFolder,'/U_fibers/*h_*.tck']);

total_U_fiber = {};

U_fiber_FA = zeros(length(U_fiber_files),1);

U_fiber_MD = zeros(length(U_fiber_files),1);

U_fiber_AD = zeros(length(U_fiber_files),1);

U_fiber_RD = zeros(length(U_fiber_files),1);

for findex = 1:length(U_fiber_files)
    
    U_fiber = U_fiber_files(findex).name(1:length(U_fiber_files(findex).name)-4);
    
    total_U_fiber = [total_U_fiber, U_fiber];
    
    unix(['tcksample ',[OutputFolder,'/U_fibers/',U_fiber,'.tck'],' ',[DWI_Path,'/dt_fa.mif'],' ',[OutputFolder,'/U_fibers/FA_',U_fiber,'.txt'],' -stat_tck mean -force']);
    
    unix(['tcksample ',[OutputFolder,'/U_fibers/',U_fiber,'.tck'],' ',[DWI_Path,'/dt_md.mif'],' ',[OutputFolder,'/U_fibers/MD_',U_fiber,'.txt'],' -stat_tck mean -force']);
    
    unix(['tcksample ',[OutputFolder,'/U_fibers/',U_fiber,'.tck'],' ',[DWI_Path,'/dt_ad.mif'],' ',[OutputFolder,'/U_fibers/AD_',U_fiber,'.txt'],' -stat_tck mean -force']);

    unix(['tcksample ',[OutputFolder,'/U_fibers/',U_fiber,'.tck'],' ',[DWI_Path,'/dt_rd.mif'],' ',[OutputFolder,'/U_fibers/RD_',U_fiber,'.txt'],' -stat_tck mean -force']);
    
    FA_U_fiber = importdata([OutputFolder,'/U_fibers/FA_',U_fiber,'.txt']);
    
    MD_U_fiber = importdata([OutputFolder,'/U_fibers/MD_',U_fiber,'.txt']);
    
    AD_U_fiber = importdata([OutputFolder,'/U_fibers/AD_',U_fiber,'.txt']);
    
    RD_U_fiber = importdata([OutputFolder,'/U_fibers/RD_',U_fiber,'.txt']);
    
    if ~isempty(FA_U_fiber) && ~isempty(MD_U_fiber) && ~isempty(AD_U_fiber) && ~isempty(RD_U_fiber)
        
        U_fiber_FA(findex) = nanmean(FA_U_fiber.data);
        
        U_fiber_MD(findex) = nanmean(MD_U_fiber.data);
        
        U_fiber_AD(findex) = nanmean(AD_U_fiber.data);
        
        U_fiber_RD(findex) = nanmean(RD_U_fiber.data);
    
    end
    
end

U_fiber_FA(U_fiber_FA == 0) = nan;

U_fiber_MD(U_fiber_MD == 0) = nan;

U_fiber_AD(U_fiber_AD == 0) = nan;

U_fiber_RD(U_fiber_RD == 0) = nan;

Var_Name_U_fiber = ['Subject_Name_and_ID', strcat(total_U_fiber,'_FA'), strcat(total_U_fiber,'_MD'), strcat(total_U_fiber,'_AD'), strcat(total_U_fiber,'_RD')];

Total_Result_U_fiber = [Splited_string{end-1}, num2cell(U_fiber_FA'), num2cell(U_fiber_MD'), num2cell(U_fiber_AD'), num2cell(U_fiber_RD')];

%{
Var_Name_U_fiber = [Splited_string{end-1}, strcat(total_U_fiber)];

Total_Result_U_fiber = ['FA', num2cell(U_fiber_FA'); 'MD', num2cell(U_fiber_MD'); 'AD', num2cell(U_fiber_AD'); 'RD', num2cell(U_fiber_RD')];
%}

writecell([Var_Name_U_fiber; Total_Result_U_fiber],[OutputFolder,filesep, Splited_string{end-1},'_Results.xlsx'],'Sheet',3);

end
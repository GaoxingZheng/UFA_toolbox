% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14

function UFA_Export_Excel_74_tracts(OutputFolder)

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

%% whole_tract metrics

folderPath = [OutputFolder,'/WMA_clustering'];

tckFiles = dir(fullfile(folderPath, '*.tck'));

for i = 1:length(tckFiles)
    
    oldName = tckFiles(i).name;
    newName = regexprep(oldName, '[&-]', '_');
    
    if ~strcmp(oldName, newName)
        
        oldFilePath = fullfile(folderPath, oldName);
        newFilePath = fullfile(folderPath, newName);
        movefile(oldFilePath, newFilePath);
        disp(['Rename tck file:' oldName ' -> ' newName]);
        
    end
    
end


WM_tck_files = dir(fullfile(OutputFolder,'/WMA_clustering/*.tck'));

tract_name = {};

tract_couts = [];

tract_len = [];

for flag = 1:length(WM_tck_files)
    
    fiber_name = WM_tck_files(flag).name;
    
    fiber_name = fiber_name(1:length(fiber_name)-4);
    unix(['tckstats ', [OutputFolder,'/WMA_clustering/',fiber_name,'.tck'],' -dump ',[OutputFolder,'/WMA_clustering/',fiber_name,'.txt'],'  -force']);
    
    fiber_txt = importdata([OutputFolder,'/WMA_clustering/',fiber_name,'.txt']);
    
    if ~isempty(fiber_txt)
        
        tract_name = [tract_name; fiber_name];
        
        tract_couts = [tract_couts, length(fiber_txt)];
        
        tract_len = [tract_len, median(fiber_txt)];
        
    else
        
        tract_name = [tract_name; fiber_name];
        
        tract_couts = [tract_couts, nan];
        
        tract_len = [tract_len, nan];
        
    end
end


WM_Path = [OutputFolder,'/WMA_clustering'];

DWI_Path = [OutputFolder,'/DWI/Tracking'];

if exist([WM_Path,'/Stats_DTI'],'dir') == 0
    
    mkdir([WM_Path,'/Stats_DTI'])
    
end


WM_FA = zeros(length(tract_name),1);

WM_MD = zeros(length(tract_name),1);

WM_AD = zeros(length(tract_name),1);

WM_RD = zeros(length(tract_name),1);

for label = 1:length(tract_name)
    
    view_direction = tract_name{label};
    
    unix(['tcksample ',[WM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_fa.mif'],' ',[WM_Path,'/Stats_DTI/FA_',view_direction,'.txt'],' -stat_tck median -force']);
    
    unix(['tcksample ',[WM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_md.mif'],' ',[WM_Path,'/Stats_DTI/MD_',view_direction,'.txt'],' -stat_tck median -force']);
    
    unix(['tcksample ',[WM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_ad.mif'],' ',[WM_Path,'/Stats_DTI/AD_',view_direction,'.txt'],' -stat_tck median -force']);
    
    unix(['tcksample ',[WM_Path,'/',view_direction,'.tck'],' ',[DWI_Path,'/dt_rd.mif'],' ',[WM_Path,'/Stats_DTI/RD_',view_direction,'.txt'],' -stat_tck median -force']);
    
    FA = importdata([WM_Path,'/Stats_DTI/FA_',view_direction,'.txt']);
    
    MD = importdata([WM_Path,'/Stats_DTI/MD_',view_direction,'.txt']);
    
    AD = importdata([WM_Path,'/Stats_DTI/AD_',view_direction,'.txt']);
    
    RD = importdata([WM_Path,'/Stats_DTI/RD_',view_direction,'.txt']);
    
    if ~isempty(FA) && ~isempty(MD) && ~isempty(AD) && ~isempty(RD)
        
        WM_FA(label) = nanmedian(FA.data);
        
        WM_MD(label) = nanmedian(MD.data);
        
        WM_AD(label) = nanmedian(AD.data);
        
        WM_RD(label) = nanmedian(RD.data);
        
    else
        
        WM_FA(label) = nan;
        
        WM_MD(label) = nan;
        
        WM_AD(label) = nan;
        
        WM_RD(label) = nan;
        
    end
    
end

Var_Name_WMHs = ['Subject_Name_and_ID', Var_Name_WMHs];

Total_Result_WMHs = [Splited_string{end-1}, Total_Result_WMHs];

Var_Name_DTI = ['Subject_Name_and_ID', strcat(tract_name','_FA'), strcat(tract_name','_MD'), strcat(tract_name','_AD'), strcat(tract_name','_RD'), strcat(tract_name','_Numbers'), strcat(tract_name','_Median_Length')];

Total_Result_DTI = [Splited_string{end-1}, num2cell(WM_FA'), num2cell(WM_MD'), num2cell(WM_AD'), num2cell(WM_RD'), num2cell(tract_couts), num2cell(tract_len)];

writecell([Var_Name_WMHs; Total_Result_WMHs],[OutputFolder,filesep,Splited_string{end-1},'_74_tracts.xlsx'],'Sheet',1);

writecell([Var_Name_DTI; Total_Result_DTI],[OutputFolder,filesep, Splited_string{end-1},'_74_tracts.xlsx'],'Sheet',2);

end
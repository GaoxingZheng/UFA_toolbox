function tracks_U_fiber = Ufiber_generate(path,whole_fiber_name,flag_filter,U_fiber_filter_para,FastSurferFolder,SPM12path,Output_Folder)
% 1 - length filter
% 2 - U shape filter
% 3 - Superficial filter
% 4 - Gyrus_gyrus filter

% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14

% filename = 'fibs_200000_angle20_minlen20_maxlen200_act.tck';
% path = 'Output_Folder/DWI/Tracking';
% whole_fiber_name = 'fibs_200000_angle20_minlen20_maxlen200_act.tck';

addpath(SPM12path)

system(['mkdir ',Output_Folder,'/U_fibers']);

SWM_folder = [Output_Folder,'/U_fibers'];

filename =[path,filesep,whole_fiber_name];

tracks = read_mrtrix_tracks (filename);
fibre_length = zeros(length(tracks.data),1);
arc_length = zeros(length(tracks.data),1);

U_fibre_flag = [];

NoU_fibre_flag = [];

SWM_flag = 0;

for k = 1:length(tracks.data)
    
    StreamLine = tracks.data{1,k};
      
    for i = 1:size(StreamLine,1)-1
        
        dist = (StreamLine(i+1,1)-StreamLine(i,1)).^2 + (StreamLine(i+1,2)-StreamLine(i,2)).^2 + (StreamLine(i+1,3)-StreamLine(i,3)).^2;
        fibre_length(k) = fibre_length(k) + sqrt(dist);
        
    end
    
    dist_arc = (StreamLine(end,1)-StreamLine(1,1)).^2 + (StreamLine(end,2)-StreamLine(1,2)).^2 + (StreamLine(end,3)-StreamLine(1,3)).^2;
    
    arc_length(k) = sqrt(dist_arc);
    
    
    if all(flag_filter([1,2,3])) && contains(U_fiber_filter_para{3},'Yes')
        
        length_filter = strsplit(U_fiber_filter_para{1},', ');
        
        minlen = str2num(length_filter{1});
        
        maxlen = str2num(length_filter{2});
        
        shape_filter = strsplit(U_fiber_filter_para{2},', ');
        
        min_shape = str2num(shape_filter{1});
        
        max_shape = str2num(shape_filter{2});
        
        if (fibre_length(k) >= minlen && fibre_length(k) <= maxlen) && (fibre_length(k)./arc_length(k) >= min_shape && fibre_length(k)./arc_length(k) <= max_shape)
            
            U_fibre_flag = [U_fibre_flag, k];
            
        else
            
            NoU_fibre_flag = [NoU_fibre_flag, k];
            
        end
        
        SWM_flag = 1;
        
    elseif all(flag_filter([1,2])) && flag_filter(3) == 0 
        
        length_filter = strsplit(U_fiber_filter_para{1},', ');
        
        minlen = str2num(length_filter{1});
        
        maxlen = str2num(length_filter{2});
        
        shape_filter = strsplit(U_fiber_filter_para{2},', ');
        
        min_shape = str2num(shape_filter{1});
        
        max_shape = str2num(shape_filter{2});
        
        if (fibre_length(k) >= minlen && fibre_length(k) <= maxlen) && (fibre_length(k)./arc_length(k) >= min_shape && fibre_length(k)./arc_length(k) <= max_shape)
            
            U_fibre_flag = [U_fibre_flag, k];
            
        else
            
            NoU_fibre_flag = [NoU_fibre_flag, k];
            
        end
        
    elseif all(flag_filter([1,3])) && contains(U_fiber_filter_para{3},'Yes') && flag_filter(2) == 0 
        
        length_filter = strsplit(U_fiber_filter_para{1},', ');
        
        minlen = str2num(length_filter{1});
        
        maxlen = str2num(length_filter{2});
        
        if (fibre_length(k) >= minlen && fibre_length(k) <= maxlen)
            
            U_fibre_flag = [U_fibre_flag, k];
            
        else
            
            NoU_fibre_flag = [NoU_fibre_flag, k];
            
        end
        
        SWM_flag = 1;
        
    elseif all(flag_filter([2,3])) && contains(U_fiber_filter_para{3},'Yes')&& flag_filter(1) == 0 
        
        shape_filter = strsplit(U_fiber_filter_para{2},', ');
        
        min_shape = str2num(shape_filter{1});
        
        max_shape = str2num(shape_filter{2});
        
        if (fibre_length(k)./arc_length(k) >= min_shape && fibre_length(k)./arc_length(k) <= max_shape)
            
            U_fibre_flag = [U_fibre_flag, k];
            
        else
            
            NoU_fibre_flag = [NoU_fibre_flag, k];
            
        end
        
        SWM_flag = 1;
        
    elseif flag_filter(1) > 0 && flag_filter(2) == 0 && flag_filter(3) == 0 
        
        length_filter = strsplit(U_fiber_filter_para{1},', ');
        
        minlen = str2num(length_filter{1});
        
        maxlen = str2num(length_filter{2});
        
        if (fibre_length(k) >= minlen && fibre_length(k) <= maxlen)
            
            U_fibre_flag = [U_fibre_flag, k];
            
        else
            
            NoU_fibre_flag = [NoU_fibre_flag, k];
            
        end
        
    elseif flag_filter(2) > 0 && flag_filter(1) == 0 && flag_filter(3) == 0 
        
        shape_filter = strsplit(U_fiber_filter_para{2},', ');
        
        min_shape = str2num(shape_filter{1});
        
        max_shape = str2num(shape_filter{2});
        
        if (fibre_length(k)./arc_length(k) >= min_shape && fibre_length(k)./arc_length(k) <= max_shape)
            
            U_fibre_flag = [U_fibre_flag, k];
            
        else
            
            NoU_fibre_flag = [NoU_fibre_flag, k];
            
        end
        
    elseif flag_filter(3) > 0 && contains(U_fiber_filter_para{3},'Yes') && flag_filter(1) == 0 && flag_filter(2) == 0 
        
        SWM_flag = 1;
        
    end
    
end

tracks_U_fiber = tracks;

deleted_flag = unique(NoU_fibre_flag);

tracks_U_fiber.data(deleted_flag) = [];

tracks_U_fiber.count = num2str(length(tracks.data) - length(deleted_flag));

write_mrtrix_tracks(tracks_U_fiber, 'U_fiber_tractography.tck')

Current_Path = pwd;

if SWM_flag > 0
    
    system(['bash ' Current_Path '/UFA_Superficial_filter.sh ' FastSurferFolder ' ' Output_Folder]);
    
    system(['mv U_fiber_tractography.tck ',SWM_folder,'/U_fiber_tractography.tck'])
    
end

if contains(U_fiber_filter_para{4},'Yes')
    
    Input_dir = [Output_Folder,'/DWI/Tracking/T1'];
    
    Output_dir = SWM_folder;
    
    Gyrus_folder = SWM_folder;
    
    system(['bash ' Current_Path '/U_fiber_generate/UFA_neighbor_gyri.sh ' Input_dir ' ' Output_dir]);
    
    UFA_U_fiber_filter(SWM_folder,Gyrus_folder);
    
    system(['rm ' Output_dir '/*.mif']);
    
    system(['rm ' Output_dir '/*.nii']);
    
    system(['tckedit ' Output_dir '/lh*.tck ' Output_dir '/rh*.tck ' Output_dir '/U_fibers.tck -force']);
    
end

function U_fiber_cluster_View(UFA_Output,view_direction)

% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14

if contains(view_direction,'view_sup')

    h1 = imread([UFA_Output,'/WMA_clustering_SWM/QC/InputTractOverlap/view_sup_tract_overlap.jpg']);
    
    h2 = imread([UFA_Output,'/WMA_clustering_SWM/QC/RegTractOverlap/view_sup_tract_overlap.jpg']);
    
    h3 = imread([UFA_Output,'/WMA_clustering_SWM/QC/FiberCluster-Initial/view_sup_all_subjects.jpg']);
    
    h4 = imread([UFA_Output,'/WMA_clustering_SWM/QC/AnatomicalTracts/view_sup_all_subjects.jpg']);
    
elseif contains(view_direction,'view_inf')
    
    
    h1 = imread([UFA_Output,'/WMA_clustering_SWM/QC/InputTractOverlap/view_inf_tract_overlap.jpg']);
    
    h2 = imread([UFA_Output,'/WMA_clustering_SWM/QC/RegTractOverlap/view_inf_tract_overlap.jpg']);
    
    h3 = imread([UFA_Output,'/WMA_clustering_SWM/QC/FiberCluster-Initial/view_inf_all_subjects.jpg']);
    
    h4 = imread([UFA_Output,'/WMA_clustering_SWM/QC/AnatomicalTracts/view_inf_all_subjects.jpg']);
    
    
elseif contains(view_direction,'view_ant')
    
    h1 = imread([UFA_Output,'/WMA_clustering_SWM/QC/InputTractOverlap/view_ant_tract_overlap.jpg']);
    
    h2 = imread([UFA_Output,'/WMA_clustering_SWM/QC/RegTractOverlap/view_ant_tract_overlap.jpg']);
    
    h3 = imread([UFA_Output,'/WMA_clustering_SWM/QC/FiberCluster-Initial/view_ant_all_subjects.jpg']);
    
    h4 = imread([UFA_Output,'/WMA_clustering_SWM/QC/AnatomicalTracts/view_ant_all_subjects.jpg']);
    
elseif contains(view_direction,'view_post')
    
    h1 = imread([UFA_Output,'/WMA_clustering_SWM/QC/InputTractOverlap/view_post_tract_overlap.jpg']);
    
    h2 = imread([UFA_Output,'/WMA_clustering_SWM/QC/RegTractOverlap/view_post_tract_overlap.jpg']);
    
    h3 = imread([UFA_Output,'/WMA_clustering_SWM/QC/FiberCluster-Initial/view_post_all_subjects.jpg']);
    
    h4 = imread([UFA_Output,'/WMA_clustering_SWM/QC/AnatomicalTracts/view_post_all_subjects.jpg']);
    
elseif contains(view_direction,'view_left')
    
    h1 = imread([UFA_Output,'/WMA_clustering_SWM/QC/InputTractOverlap/view_left_tract_overlap.jpg']);
    
    h2 = imread([UFA_Output,'/WMA_clustering_SWM/QC/RegTractOverlap/view_left_tract_overlap.jpg']);
    
    h3 = imread([UFA_Output,'/WMA_clustering_SWM/QC/FiberCluster-Initial/view_left_all_subjects.jpg']);
    
    h4 = imread([UFA_Output,'/WMA_clustering_SWM/QC/AnatomicalTracts/view_left_all_subjects.jpg']);
    
elseif contains(view_direction,'view_right')
    
    h1 = imread([UFA_Output,'/WMA_clustering_SWM/QC/InputTractOverlap/view_right_tract_overlap.jpg']);
    
    h2 = imread([UFA_Output,'/WMA_clustering_SWM/QC/RegTractOverlap/view_right_tract_overlap.jpg']);
    
    h3 = imread([UFA_Output,'/WMA_clustering_SWM/QC/FiberCluster-Initial/view_right_all_subjects.jpg']);
    
    h4 = imread([UFA_Output,'/WMA_clustering_SWM/QC/AnatomicalTracts/view_right_all_subjects.jpg']);    
    
    
end

figure('Name',view_direction,'NumberTitle','off')

ha = UFA_tightPlots(1,4,30,[1.3 1],[0.1 0.1], [0.3 0.7], [0.8 0.3]);

axes(ha(1)), imshow(h1),title('Before registration')

axes(ha(2)), imshow(h2),title('After registration')

axes(ha(3)), imshow(h3),title('Fiber auto clustering')

axes(ha(4)), imshow(h4),title('U fiber cluster')

set(gcf,'color','w')
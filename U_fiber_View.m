function U_fiber_View(UFA_Output,view_choice)

% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14

if contains(view_choice,'whole_brain')
    
     unix(['mrview -load ',UFA_Output, '/T1/T1w2dwispace.nii.gz',' -imagevisible true -tractography.load ',UFA_Output,'/DWI/Tracking/*.tck -mode 2']);
%     unix(['mrview -load ',UFA_Output, '/WMH_extraction/subjects/QC/QC_final_native/*.nii.gz',' -imagevisible true -tractography.load ',UFA_Output,'/DWI/Tracking/*.tck -mode 2']);
    
elseif contains(view_choice,'U_fiber')
    
      unix(['mrview -load ',UFA_Output, '/T1/T1w2dwispace.nii.gz',' -imagevisible true -tractography.load ',UFA_Output,'/U_fibers/U_fibers.tck -mode 2']);
%     unix(['mrview -load ',UFA_Output, '/T1/T1w2dwispace.nii.gz',' -imagevisible true -tractography.load ',UFA_Output,'/WMA_clustering_SWM/U_fiber_tractography.tck -mode 2']);

end

end

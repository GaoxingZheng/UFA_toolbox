function UFA_negibor_gyri_filter(SWM_name,Gyrus1_name,Gyrus2_name,U_fiber_name,SWM_folder,Gyrus_folder)

% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14

% SWM_file = read_mrtrix_tracks('U_fibers_lenfilter.tck');
% Gyrus1_name = 'lh_G_front_sup.nii';
% Gyrus2_name = 'lh_G_S_cingul_Ant.nii';
% U_fiber_name = 'U_fibers.tck';


SWM_file = read_mrtrix_tracks([SWM_folder,'/',SWM_name]);

%% Gyrus 1

volumeInfo1=spm_vol([Gyrus_folder,'/',Gyrus1_name]);

[Gyrus1_intensityValues,Gyrus1_xyzCoordinates]=spm_read_vols(volumeInfo1);

Gyrus1_index = find(Gyrus1_intensityValues(:)>0);

Gyrus1_xyz = Gyrus1_xyzCoordinates(:,Gyrus1_index)';

%% Gyrus 2

volumeInfo2=spm_vol([Gyrus_folder,'/',Gyrus2_name]);

[Gyrus2_intensityValues,Gyrus2_xyzCoordinates]=spm_read_vols(volumeInfo2);

Gyrus2_index = find(Gyrus2_intensityValues(:)>0);

Gyrus2_xyz = Gyrus2_xyzCoordinates(:,Gyrus2_index)';

% color_settings = colormap(jet);

U_fiber_flag = [];

NoU_fiber_flag = [];

for findex = 1:length(SWM_file.data)
    
    tem_fiber = SWM_file.data{findex};
    
    dmat1 = pdist2(Gyrus1_xyz, tem_fiber(1,:),'euclidean');
    
    [dist1 , ind1] = min(dmat1,[],2,'linear');
    
    dmat2 = pdist2(Gyrus2_xyz, tem_fiber(end,:),'euclidean');
    
    [dist2 , ind2] = min(dmat2,[],2,'linear');
    
    
    dmat3 = pdist2(Gyrus1_xyz, tem_fiber(end,:),'euclidean');
    
    [dist3 , ind3] = min(dmat3,[],2,'linear');
    
    dmat4 = pdist2(Gyrus2_xyz, tem_fiber(1,:),'euclidean');
    
    [dist4 , ind4] = min(dmat4,[],2,'linear');
    
    
    if (min(dist1) < 5 && min(dist2) < 5) || (min(dist3) < 5 && min(dist4) < 5)
        
        U_fiber_flag = [U_fiber_flag, findex];
        
         % plot1 = plot3(tem_fiber(:,1),tem_fiber(:,2),tem_fiber(:,3),'-','linewidth',2); hold on % getColor(findex,1,256)

    else
        
        NoU_fiber_flag = [NoU_fiber_flag, findex];
        
    end
    
end

% colorbar
% 
% plot3(Gyrus1_xyz(:,1),Gyrus1_xyz(:,2),Gyrus1_xyz(:,3),'.','color',[148 100 108]/255); hold on  % [148 0 211]/255
% 
% plot3(Gyrus2_xyz(:,1),Gyrus2_xyz(:,2),Gyrus2_xyz(:,3),'.','color',[148 0 211]/255); hold off  % [148 0 211]/255

U_fibers = SWM_file;

deleted_flag = unique(NoU_fiber_flag);

U_fibers.data(deleted_flag) = [];

U_fibers.count = num2str(length(SWM_file.data) - length(deleted_flag));

write_mrtrix_tracks(U_fibers, [Gyrus_folder,'/',U_fiber_name])

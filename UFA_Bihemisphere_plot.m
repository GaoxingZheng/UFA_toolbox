function UFA_Bihemisphere_plot(left,right,YLabel,color_pair)

% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14

% Automatically determine the scaling factor using the data itself
scale = max(right) / max(left);

% Create the left bar by scaling the magnitude
barh(1:numel(left), -left * scale, 'FaceColor',color_pair{1});

hold on
barh(1:numel(right), right, 'FaceColor',color_pair{2});  

% Now alter the ticks.
xticks = get(gca, 'xtick');

% Get the current labels
labels = get(gca, 'xtickLabel'); 

if ischar(labels)
    labels = cellstr(labels); 
end

labels = abs(xticks);

% Update the tick locations and the labels
set(gca, 'xtick', xticks, 'xticklabel', labels,'yticklabel',YLabel,'fontsize',12, 'FontWeight', 'bold')

% Now add a different label for each side of the x axis
xmax = max(get(gca, 'xlim'));
label(1) = text(xmax / 2, length(right)+0.7, 'Right Brain');
label(2) = text(-xmax/ 2, length(left)+0.7, 'Left Brain');

set(label, 'HorizontalAlignment', 'center', 'FontWeight', 'bold', 'FontSize', 14) 

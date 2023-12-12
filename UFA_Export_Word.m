% AUTHOR : Gaoxing Zheng
% Institution: Zhongshan Hospital, Fudan University
% EMAIL CONTACT: zheng_gao_xing@163.com
% DATE: 2022-04-14
% Reference: https://blog.51cto.com/u_15127592/3286945

function UFA_Export_Word(InputFolder,OutputFolder,T2Flair_Image)

import mlreportgen.dom.*;
d=Document([OutputFolder,filesep,'U_fiber_intelligent_analysis_report'],'docx');
open(d);

%% Page Settings
s = d.CurrentDOCXSection;
s.PageSize.Orientation  ='landscape'; % portrait(default)
s.PageSize.Height = '45cm';% '8.5in';
s.PageSize.Width = '27.94cm'; % '11in';
% s.PageMargins.Left = '3.0cm';
% s.PageMargins.Right = '3.0cm';
% s.PageMargins.Top = '2.5cm';
% s.PageMargins.Bottom = '2.5cm';

%
heiti=FontFamily;
heiti.FamilyName='Times New Roman';
heiti.EastAsiaFamilyName='Times New Roman';
ziti=FontFamily;
ziti.FamilyName='Times New Roman';
ziti.EastAsiaFamilyName='Times New Roman';

%% Title
p=Heading(1,'The multi-modal neuroimaging report');% the first title
%p.Color='red';
%p.HAlign='center';
p.Style={heiti,Color('black'),HAlign('center'),FontSize('24pt')};
append(d,p);

%% Easy table

append(d,Heading(2,'1. Basic Information'));
append(d,' ');
DICOM_Folder = dir(fullfile([InputFolder,filesep,['*',T2Flair_Image,'*']]));

DICOM_PATH = dir([DICOM_Folder(1).folder,filesep,DICOM_Folder(1).name]);

Subject_info = dicominfo([DICOM_PATH(3).folder,filesep,DICOM_PATH(3).name]);

t = {'Name','ID','Gender','Age';...
    Subject_info.PatientName.FamilyName, Subject_info.PatientID, Subject_info.PatientSex, Subject_info.PatientAge(2:3);...
    'Weight (kg)','Birth Date','Scan Time','Modality';...   
    Subject_info.PatientWeight, Subject_info.PatientBirthDate,Subject_info.AcquisitionDate,'DWI/T1/T2 Flair'};

p=Table(t);

% Format paragraphs in cells

for ii=1:p.NRows
    for jj=1:p.NCols
        t=entry(p,ii,jj);
         t.Children(1).Style={ziti,...
            Color('black'),... % green
            FontSize('14pt'),...
            LineSpacing(2.0),...
            OuterMargin('0pt','0pt','0pt','0pt')};
    end
end

p.Style = {Border('single','black','3px'), ...
               ColSep('single','black','1px'), ...   % blue
               RowSep('single','black','1px')};   % blue
 
p.Width = '100%';
p.HAlign='center';% center align
p.TableEntriesHAlign='center';
p.TableEntriesVAlign='middle';
append(d,p);
append(d,' ');

%% WMH

append(d,Heading(2,'2. White matter hyper-intensities (WMH)'));

WMH_file_path = [OutputFolder,filesep,'WMH_extraction/subjects'];

UFA_WMHplot_lobe(WMH_file_path)

saveas(figure(1),'WMH_volume_Whole_PV_Deep.png');

saveas(figure(2),'WMH_size_Whole_PV.png');

saveas(figure(3),'WMH_volume_lobar.png');

saveas(figure(4),'WMH_counts_lobar.png');

saveas(figure(5),'WMH_volume_AT.png');

saveas(figure(6),'WMH_counts_AT.png');

saveas(figure(7),'WMH_size_AT.png');

saveas(figure(8),'WMH_size_lobar.png');

WMH_volume_Whole_PV_Deep = Image('WMH_volume_Whole_PV_Deep.png');

WMH_size_Whole_PV = Image('WMH_size_Whole_PV.png');

WMH_volume_lobar = Image('WMH_volume_lobar.png');

WMH_counts_lobar = Image('WMH_counts_lobar.png');

WMH_volume_AT = Image('WMH_volume_AT.png');

WMH_counts_AT = Image('WMH_counts_AT.png');

WMH_size_AT = Image('WMH_size_AT.png');

WMH_size_lobar = Image('WMH_size_lobar.png');

% WMH_counts.Style={HAlign('right'),Width('600px'),Height('400px')};

imgStyle1 = {HAlign('center'),Width('400px'),Height('300px')};

WMH_volume_Whole_PV_Deep.Style = imgStyle1;

WMH_size_Whole_PV.Style = imgStyle1;

WMH_volume_lobar.Style = imgStyle1;

WMH_counts_lobar.Style = imgStyle1;

WMH_volume_AT.Style = imgStyle1;

WMH_counts_AT.Style = imgStyle1;

imgStyle2 = {HAlign('center'),Width('700px'),Height('400px')};

WMH_size_AT.Style = imgStyle2;

WMH_size_lobar.Style = imgStyle2;

% WMH = Table({WMH_volume_lobar, WMH_counts_lobar, WMH_volume_AT, WMH_counts_AT,WMH_size_AT, WMH_size_lobar});

WMH1 = Table({WMH_volume_Whole_PV_Deep, WMH_size_Whole_PV});

WMH2 = Table({WMH_volume_lobar, WMH_counts_lobar});

WMH3 = Table({WMH_volume_AT, WMH_counts_AT});

WMH4 = Table({WMH_size_AT});

WMH5 = Table({WMH_size_lobar});

WMH1.Style = {ResizeToFitContents(false),Width('100%'),...
    Border('solid','white','0px'),...
    ColSep('solid','white','0px'),...
    RowSep('solid','white','0px')};

WMH2.Style = {ResizeToFitContents(false),Width('100%'),...
    Border('solid','white','0px'),...
    ColSep('solid','white','0px'),...
    RowSep('solid','white','0px')};

WMH3.Style = {ResizeToFitContents(false),Width('100%'),...
    Border('solid','white','0px'),...
    ColSep('solid','white','0px'),...
    RowSep('solid','white','0px')};

WMH4.Style = {ResizeToFitContents(false),Width('100%'),...
    Border('solid','white','0px'),...
    ColSep('solid','white','0px'),...
    RowSep('solid','white','0px')};

WMH5.Style = {ResizeToFitContents(false),Width('100%'),...
    Border('solid','white','0px'),...
    ColSep('solid','white','0px'),...
    RowSep('solid','white','0px')};

append(d,' ');
append(d,WMH1);
append(d,' ');
append(d,WMH2);
append(d,' ');
append(d,WMH3);
append(d,' ');
append(d,WMH4);
append(d,' ');
append(d,WMH5);
append(d,' ');

close([figure(1) figure(2) figure(3) figure(4) figure(5) figure(6) figure(7) figure(8)])

%% U fiber quantification

append(d,Heading(2,'3. U fiber quantitation'));

minlen = 20;

maxlen = 80;

UFA_quantificaton(OutputFolder,minlen,maxlen);

saveas(figure(1),'U_fiber_counts.png');

saveas(figure(2),'U_fiber_length.png');

saveas(figure(3),'U_fiber_DTI.png');

U_fiber_counts = Image('U_fiber_counts.png');

U_fiber_length = Image('U_fiber_length.png');

U_fiber_DTI = Image('U_fiber_DTI.png');

imgStyle = {HAlign('center'),Width('400px'),Height(' 300px')};

U_fiber_counts.Style = imgStyle;

U_fiber_length.Style = imgStyle;

imgStyle3 = {HAlign('center'),Width('700px'),Height('400px')};

U_fiber_DTI.Style = imgStyle3;

U_fiber1 = Table({'Number of U fibers','Mean U fiber length';U_fiber_counts,U_fiber_length});

U_fiber1.Style = {ziti,ResizeToFitContents(false),Width('100%'),...
    Border('solid','white','0px'),...
    ColSep('solid','white','0px'),...
    RowSep('solid','white','0px')};

U_fiber1.HAlign='center';% center align
U_fiber1.TableEntriesHAlign='center';
U_fiber1.TableEntriesVAlign='middle';

U_fiber2 = Table({'DTI metrics of U fibers';U_fiber_DTI});

U_fiber2.HAlign='center';% center align
U_fiber2.TableEntriesHAlign='center';
U_fiber2.TableEntriesVAlign='middle';

append(d,' ');
append(d,U_fiber1);
append(d,' ');
append(d,U_fiber2);
append(d,' ');

close([figure(1) figure(2) figure(3)])

%% Insert the figure

close(d);

rptview(d.OutputPath);

delete('WMH_volume_Whole_PV_Deep.png');
delete('WMH_size_Whole_PV.png');

delete('WMH_volume_lobar.png');
delete('WMH_counts_lobar.png');

delete('WMH_volume_AT.png');
delete('WMH_counts_AT.png');

delete('WMH_size_AT.png');
delete('WMH_size_lobar.png');

delete('U_fiber_counts.png');
delete('U_fiber_length.png');
delete('U_fiber_DTI.png');

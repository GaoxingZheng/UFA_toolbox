function varargout = U_fiber_Auto(varargin)
% U_fiber_Auto MATLAB code for U_fiber_Auto.fig
%      U_fiber_Auto, by itself, creates a new U_fiber_Auto or raises the existing
%      singleton*.
%
%      H = U_fiber_Auto returns the handle to a new U_fiber_Auto or the handle to
%      the existing singleton*.
%
%      U_fiber_Auto('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in U_fiber_Auto.M with the given input arguments.
%
%      U_fiber_Auto('Property','Value',...) creates a new U_fiber_Auto or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before U_fiber_Auto_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to U_fiber_Auto_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help U_fiber_Auto

% Last Modified by GUIDE v2.5 18-Jul-2024 08:53:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @U_fiber_Auto_OpeningFcn, ...
                   'gui_OutputFcn',  @U_fiber_Auto_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before U_fiber_Auto is made visible.
function U_fiber_Auto_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to U_fiber_Auto (see VARARGIN)

% Choose default command line output for U_fiber_Auto
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes U_fiber_Auto wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = U_fiber_Auto_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in InputDir_btn.
function InputDir_btn_Callback(hObject, eventdata, handles)
% hObject    handle to InputDir_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
InputDir = uigetdir;
InputDirEdit = findobj ('Tag', 'InputDir_Edit');
set (InputDirEdit, 'String', InputDir);

handles.InputDir = InputDir;
guidata(hObject, handles);

% --- Executes on button press in OutputDir_btn.
function OutputDir_btn_Callback(hObject, eventdata, handles)
% hObject    handle to OutputDir_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
OutputDir = uigetdir;
OutDirEdit = findobj ('Tag', 'OutputDir_Edit');
set (OutDirEdit, 'String', OutputDir);

handles.OutputDir = OutputDir;
guidata(hObject, handles);


function InputDir_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to InputDir_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InputDir_Edit as text
%        str2double(get(hObject,'String')) returns contents of InputDir_Edit as a double


% --- Executes during object creation, after setting all properties.
function InputDir_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputDir_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function OutputDir_Edit_Callback(hObject, eventdata, handles)
% hObject    handle to OutputDir_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OutputDir_Edit as text
%        str2double(get(hObject,'String')) returns contents of OutputDir_Edit as a double


% --- Executes during object creation, after setting all properties.
function OutputDir_Edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutputDir_Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in T1_popupmenu.
function T1_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to T1_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selected_index1 = get(handles.T1_popupmenu,'value');

if selected_index1 < 3
    
    str1 = get(handles.T1_popupmenu,'string');
    
    T1_Image = str1{selected_index1};
    
    handles.T1_Image = T1_Image;
    
else
    
    T1_Image_input = inputdlg('Unique value of T1 folder name','please input the unique T1 folder name',[1 40],{' '});
    
    if ~isempty(T1_Image_input)
        
        handles.T1_Image = T1_Image_input{1};
        
    end
    
end

guidata(hObject, handles);



% Hints: contents = cellstr(get(hObject,'String')) returns T1_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from T1_popupmenu


% --- Executes during object creation, after setting all properties.
function T1_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T1_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in T2Flair_popupmenu.
function T2Flair_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to T2Flair_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns T2Flair_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from T2Flair_popupmenu

selected_index2 = get(handles.T2Flair_popupmenu,'value');

if selected_index2 < 2
    
    str2 = get(handles.T2Flair_popupmenu,'string');
    
    T2Flair_Image = str2{selected_index2};
    
    handles.T2Flair_Image = T2Flair_Image;
        
else
    
    T2Flair_Image_input = inputdlg('Unique value of T2FLAIR folder name','please input the unique T2FLAIR folder name',[1 40],{' '});
    
    if ~isempty(T2Flair_Image_input)
        
        handles.T2Flair_Image = T2Flair_Image_input{1};
        
    end
    
end

guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function T2Flair_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T2Flair_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in DWI_popupmenu.
function DWI_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to DWI_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns DWI_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from DWI_popupmenu

selected_index3 = get(handles.DWI_popupmenu,'value');

if selected_index3 < 4
    
    str3 = get(handles.DWI_popupmenu,'string');
    
    DWI_Image = str3{selected_index3};
    
    handles.DWI_Image = DWI_Image;
        
else
    
    DWI_Image_input = inputdlg('Unique value of DWI folder name','please input the unique DWI folder name',[1 40],{' '});
    
    if ~isempty(DWI_Image_input)
        
        handles.DWI_Image = DWI_Image_input{1};
        
    end
    
end

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function DWI_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DWI_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when uipanel5 is resized.
function uipanel5_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in GibbsRemoval_btn.
function GibbsRemoval_btn_Callback(hObject, eventdata, handles)
% hObject    handle to GibbsRemoval_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
T1_Image = handles.T1_Image;

Input_Folder = handles.InputDir;

Output_Folder = handles.OutputDir;

SubFolder_Name = dir(Input_Folder);

switch T1_Image
    
    case 'T1W'
        
        for i = 1:length(SubFolder_Name)
            
            if contains(SubFolder_Name(i).name, 'T1W')
                
                T1_Folder = [Input_Folder,filesep,SubFolder_Name(i).name];
                
                break
                
            end
                
        end
        
    case 'FSPGR'
        
        for i = 1:length(SubFolder_Name)
            
            if contains(SubFolder_Name(i).name, 'FSPGR')
                
                T1_Folder = [Input_Folder,filesep,SubFolder_Name(i).name];
                
                break
                
            end
            
        end
        
    otherwise
        
        disp('You should check your T1 folder name!');
end

tic

system([pwd,'/UFA_T1_degibbs.sh ' Output_Folder]);

toc



% --- Executes on button press in T1_BiasFieldCorrect_btn.
function T1_BiasFieldCorrect_btn_Callback(hObject, eventdata, handles)
% hObject    handle to T1_BiasFieldCorrect_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AtlasDir = [pwd,'/share'];

Output_Folder = handles.OutputDir;

tic

system([pwd,'/UFA_T1_N4BiasFieldCorrection.sh ' AtlasDir ' ' Output_Folder]);

toc



% --- Executes on button press in TissueSeg_btn.
function TissueSeg_btn_Callback(hObject, eventdata, handles)
% hObject    handle to TissueSeg_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_FOlder = handles.OutputDir;

tic

system([pwd,'/UFA_T1_tissue_seg.sh ' Output_FOlder]);

toc


% --- Executes on button press in RegistationToDWI_btn.
function RegistationToDWI_btn_Callback(hObject, eventdata, handles)
% hObject    handle to RegistationToDWI_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_Folder = handles.OutputDir;

tic

system([pwd,'/UFA_T1registrationDWI.sh ' Output_Folder]);

toc


% --- Executes on button press in DWIdenoise_btn.
function DWIdenoise_btn_Callback(hObject, eventdata, handles)
% hObject    handle to DWIdenoise_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

DWI_Image = handles.DWI_Image;

DWI_Image = regexprep(DWI_Image,{' ',',',';'},'');

Output_Folder = handles.OutputDir;

tic

system([pwd,'/UFA_DWI_denoise.sh ' Output_Folder ' ' DWI_Image]);

toc

% --- Executes on button press in MRdegibbs_btn.
function MRdegibbs_btn_Callback(hObject, eventdata, handles)
% hObject    handle to MRdegibbs_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_Folder = handles.OutputDir;

tic

system([pwd,'/UFA_DWI_degibbs.sh ' Output_Folder]);

toc



% --- Executes on button press in EddyCorrection_btn.
function EddyCorrection_btn_Callback(hObject, eventdata, handles)
% hObject    handle to EddyCorrection_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

DWI_Image = handles.DWI_Image;

DWI_Image = regexprep(DWI_Image,{' ',',',';'},'');

Output_Folder = handles.OutputDir;

tic

system([pwd,'/UFA_DWI_eddy_correction.sh ' Output_Folder ' ' DWI_Image]);

fprintf('The DWI eddy correction is already completed!')

toc


% --- Executes on button press in DWI_BiasFieldCorrect_btn.
function DWI_BiasFieldCorrect_btn_Callback(hObject, eventdata, handles)
% hObject    handle to DWI_BiasFieldCorrect_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_Folder = handles.OutputDir;

tic

system([pwd,'/UFA_DWI_BiasCorrection.sh ' Output_Folder]);

toc


% --- Executes on button press in DWITractography_btn.
function DWITractography_btn_Callback(hObject, eventdata, handles)
% hObject    handle to DWITractography_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_Folder = handles.OutputDir;

prompt = {'cutoff threhold: ', 'angle: ', 'minlength: ', 'maxlength: ', 'total_fibers: '};

dafault_parameters = {'0.05','45','4','200','1M'};

title_name = 'Input your tractography paramters';

lines = [1 50; 1 50; 1 50; 1 50; 1 50];

Tract_para = inputdlg(prompt,title_name,lines, dafault_parameters);

if ~isempty(Tract_para)
    
    tic
    
    fprintf('The DWI tractography is already begining, please wait...')
    
    system([pwd,'/UFA_DWI_tractography.sh ' Output_Folder ' ' num2str(Tract_para{1}) ' ' num2str(Tract_para{2}) ' ' num2str(Tract_para{3}) ' ' num2str(Tract_para{4}) ' ' num2str(Tract_para{5})]);
    
    fprintf('The DWI tractography is already completed!')
    
    toc
    
end

% --- Executes on button press in U_fiber_filer_btn.
function U_fiber_filer_btn_Callback(hObject, eventdata, handles)
% hObject    handle to U_fiber_filer_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set (handles.checkbox1, 'Enable', 'on');

set (handles.checkbox2, 'Enable', 'on');

set (handles.checkbox3, 'Enable', 'on');

FastSurferFolder = uigetdir(pwd,'Please find where the FastSurfer folder locates');

% FastSurferFolder = '/home/zhenggaoxing/Public/NeuroImage_toolbox/FastSurfer';

SPM12path = uigetdir(pwd,'Please find where the spm12 toolbox locates');

Output_Folder = handles.OutputDir;

prompt = {'length filter: ', 'U shape filter: ', 'Superficial filter: ', 'Gyrus_gyrus filter: '};

dafault_parameters = {'20, 80', '1.01, 6', 'Yes', 'Yes'};

title_name = 'Input your U fiber filter paramters';

lines = [1 50; 1 50; 1 50; 1 50];

flag_filter = [1 2 3 4];

if (handles.length_filter_checkbox == 0) && (handles.shape_filter_checkbox == 0) && (handles.Superficial_checkbox == 0) && (handles.Neighbor_gyrus_filter_checkbox == 0)
    
    warndlg('Please select at least one choice! ');
    
else
    
    
    if ~handles.length_filter_checkbox
        
        flag_filter(1) = 0;
        
    end
    
    if ~handles.shape_filter_checkbox
        
        flag_filter(2) = 0;
        
    end
    
    if ~handles.Superficial_checkbox
        
        flag_filter(3) = 0;
        
    end
    
    if ~handles.Neighbor_gyrus_filter_checkbox
        
        
        flag_filter(4) = 0;
        
    end
    
    prompt1 = [];
    
    dafault_parameters1 = [];
    
    lines1 = [];
    
    if flag_filter(1)
        
        prompt1 = [prompt1,prompt(flag_filter(1))];
        
        dafault_parameters1 = [dafault_parameters1, dafault_parameters(flag_filter(1))];
        
        lines1 = [lines1; lines(flag_filter(1),:)];
        
    else
        
        prompt1 = [prompt1,prompt(1)];
        
        dafault_parameters1 = [dafault_parameters1, {' '}];
        
        lines1 = [lines1; lines(1,:)];
        
    end
    
    if flag_filter(2)
        
        prompt1 = [prompt1,prompt(flag_filter(2))];
        
        dafault_parameters1 = [dafault_parameters1, dafault_parameters(flag_filter(2))];
        
        lines1 = [lines1; lines(flag_filter(2),:)];
        
    else
        
        prompt1 = [prompt1,prompt(2)];
        
        dafault_parameters1 = [dafault_parameters1, {' '}];
        
        lines1 = [lines1; lines(2,:)];
        
    end
    
    if flag_filter(3)
        
        prompt1 = [prompt1,prompt(flag_filter(3))];
        
        dafault_parameters1 = [dafault_parameters1, dafault_parameters(flag_filter(3))];
        
        lines1 = [lines1; lines(flag_filter(3),:)];
        
    else
        
        prompt1 = [prompt1,prompt(3)];
        
        dafault_parameters1 = [dafault_parameters1, {' '}];
        
        lines1 = [lines1; lines(3,:)];
        
    end
    
    if flag_filter(4)
        
        prompt1 = [prompt1,prompt(flag_filter(4))];
        
        dafault_parameters1 = [dafault_parameters1, dafault_parameters(flag_filter(4))];
        
        lines1 = [lines1; lines(flag_filter(4),:)];
    
    else
        
        prompt1 = [prompt1,prompt(4)];
        
        dafault_parameters1 = [dafault_parameters1, {' '}];
        
        lines1 = [lines1; lines(4,:)];
        
    end
        
    U_fiber_filter_para = inputdlg(prompt1,title_name,lines1, dafault_parameters1);
    
    if ~isempty(U_fiber_filter_para)
        
        if flag_filter(1)
            
            len_filter = strsplit(U_fiber_filter_para{1},', ');
            
            minlen = str2num(len_filter{1});
            
            maxlen = str2num(len_filter{2});
            
            handles.minlen = minlen;
            
            handles.maxlen = maxlen;
            
            guidata(hObject, handles);
            
        end
        
        
        if ~isempty(U_fiber_filter_para)
            
            addpath(genpath([pwd,'/U_fiber_generate']))
            
            tic
            
            fprintf(['The U fiber is already generating, please wait...','\n'])
            
            fiber_path = [Output_Folder,'/DWI/Tracking/'];
            
            name_list = dir([fiber_path,'*.tck']);
            
            whole_fiber_name = name_list(1).name;
            
            Ufiber_generate(fiber_path,whole_fiber_name,flag_filter,U_fiber_filter_para,FastSurferFolder,SPM12path,Output_Folder);
            
            fprintf('The U fiber is already completed!')
            
            toc
            
        else
            
            fprintf('The U fiber filter parameters exist errors, please select again!')
            
        end
    end
    
end


    

% --- Executes on button press in U_fiber_cluster_btn.
function U_fiber_cluster_btn_Callback(hObject, eventdata, handles)
% hObject    handle to U_fiber_cluster_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

SlicerPath = uigetdir(pwd,'Please find where the 3D Slicer locates');

view_choice = inputdlg('possible choice (whole_brain/U_fiber)','please input the view choice',[1 50],{'U_fiber'});

if contains(view_choice,'whole_brain')
    
    if isfield(handles, 'minlen')  && isfield(handles, 'maxlen')
        
        minlen = num2str(handles.minlen); % 20
        
        maxlen = num2str(handles.maxlen); % 200
        
    else
        
        fiber_len_para = inputdlg({'minlen (mm): ', 'maxlen (mm)'},'Input the min and max length',[1 50; 1 50], {'20', '200'});
        
        if ~isempty(fiber_len_para)
            
            minlen = fiber_len_para{1};
            
            maxlen = fiber_len_para{2};
            
        end
        
    end
    
    
    if ~isnumeric(SlicerPath)  && ~isempty(minlen) && ~isempty(maxlen)
        
        
        run_flag = system([pwd,'/UFA_whole_fiber_cp.sh ' handles.OutputDir,'/DWI/Tracking']);
        
        if run_flag > 0
            
            warndlg('Please select at least one choice! ');
            
        else
            
            tic
            
            system([pwd,'/WMA_clustering_SWM/WMA_clustering.sh ' [pwd,'/WMA_clustering_SWM '], [handles.OutputDir,'/WMA_clustering '],SlicerPath, ' ',minlen, ' ',maxlen]);
            
            toc
            
        end
        
    end
    
elseif contains(view_choice,'U_fiber')
    
    if isfield(handles, 'minlen')  && isfield(handles, 'maxlen')
        
        minlen = num2str(handles.minlen); % 20
        
        maxlen = num2str(handles.maxlen); % 80
        
    else
        
        fiber_len_para = inputdlg({'minlen (mm): ', 'maxlen (mm)'},'Input the min and max length',[1 50; 1 50], {'20', '80'});
        
        if ~isempty(fiber_len_para)
            
            minlen = fiber_len_para{1};
            
            maxlen = fiber_len_para{2};
            
        end
        
    end
    
    
    if ~isnumeric(SlicerPath)  && ~isempty(minlen) && ~isempty(maxlen)
        
        
        run_flag = system([pwd,'/UFA_U_fiber_cp.sh ' handles.OutputDir,'/U_fibers']);
        
        if run_flag > 0
            
            warndlg('Please select at least one choice! ');
            
        else
            
            tic
            
            system([pwd,'/WMA_clustering_SWM/WMA_clustering_SWM.sh ' [pwd,'/WMA_clustering_SWM '], [handles.OutputDir,'/WMA_clustering_SWM '],SlicerPath, ' ',minlen, ' ',maxlen]);
            
            toc
            
        end
        
    end
    
else
    
    fprintf('The U fiber clustering parameters exist errors, please select again!')
    
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1

if (get(hObject, 'Value'))
    
    length_filter_checkbox = 1;
    
else
    
    length_filter_checkbox = 0;
    
end

handles.length_filter_checkbox = length_filter_checkbox;

guidata(hObject, handles);




% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2

if (get(hObject, 'Value'))
    
    shape_filter_checkbox = 1;
    
else
    
    shape_filter_checkbox = 0;
    
end

handles.shape_filter_checkbox = shape_filter_checkbox;

guidata(hObject, handles);



% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3

if (get(hObject, 'Value'))
    
    Superficial_filter_checkbox = 1;
    
else
    
    Superficial_filter_checkbox = 0;
    
end

handles.Superficial_checkbox =  Superficial_filter_checkbox;

guidata(hObject, handles);


% --- Executes on button press in U_fiber_quant_btn.
function U_fiber_quant_btn_Callback(hObject, eventdata, handles)
% hObject    handle to U_fiber_quant_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

UFA_Folder = handles.OutputDir;

if  isfield(handles,'minlen') && isfield(handles,'maxlen')
    
    minlen =  handles.minlen;
    
    maxlen = handles.maxlen;
    
else
    
    minlen = 20; maxlen = 80;
    
end

tic

UFA_quantificaton(UFA_Folder,minlen,maxlen)

toc


% --- Executes on button press in Relation_U_fiber_WMH_btn.
function Relation_U_fiber_WMH_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Relation_U_fiber_WMH_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_Folder = handles.OutputDir;

addpath(genpath([pwd,'/U_fiber_generate']));

fprintf('The histogram of distance between U fiber and WMH is running! Please wait a few miniutes\n')

[U_fiber_WMH_dist, U_fiber_WMH_index,maxcount, whichbin,Xbin_low,Xbin_up] = WMH_U_fiber_Relations_before(Output_Folder);

% [U_fiber_WMH_dist, U_fiber_WMH_index] = WMH_U_fiber_Relations(Output_Folder);

handles.U_fiber_WMH_dist = U_fiber_WMH_dist;

handles.U_fiber_WMH_index = U_fiber_WMH_index;

% handles.maxcount = maxcount;
% 
% handles.whichbin = whichbin;
% 
% handles.Xbin_low = Xbin_low;
% 
% handles.Xbin_up = Xbin_up;

guidata(hObject, handles);


% --- Executes on button press in Check_OK_btn.
function  Check_OK_btn_Callback(hObject, eventdata, handles)
% hObject    handle to Check_OK_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set (handles.T1_popupmenu, 'Enable', 'on');

set (handles.T2Flair_popupmenu, 'Enable', 'on');

set (handles.DWI_popupmenu, 'Enable', 'on');

handles.T1_Image = handles.T1_Image;

handles.T2Flair_Image = handles.T2Flair_Image;

handles.DWI_Image = handles.DWI_Image;

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Check_OK_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Check_OK_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function InputDir_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InputDir_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in RunAll_Once_btn.
function RunAll_Once_btn_Callback(hObject, eventdata, handles)
% hObject    handle to RunAll_Once_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in dcm2nii_btn.
function dcm2nii_btn_Callback(hObject, eventdata, handles)
% hObject    handle to dcm2nii_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

T1_Image = handles.T1_Image;

T2Flair_Image = handles.T2Flair_Image;

DWI_Image = handles.DWI_Image;

Input_Folder = handles.InputDir;

Output_Folder = handles.OutputDir;

DWI_Image = regexprep(DWI_Image,{' ',',',';'},'');

system([pwd,'/UFA_Dcm2Nii.sh ' Input_Folder ' ' Output_Folder ' ' T1_Image ' ' T2Flair_Image ' ' DWI_Image]);


% --- Executes on button press in WMH_extraction_btn.
function WMH_extraction_btn_Callback(hObject, eventdata, handles)
% hObject    handle to WMH_extraction_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_Folder = handles.OutputDir;

%{
CNSP_path = '/home/zhenggaoxing/Public/NeuroImage_toolbox/CNS';

spm12path = '/home/zhenggaoxing/Public/NeuroImage_toolbox/spm12';
%}

CNSP_path = uigetdir(pwd,'Please find where the CNS toolbox locates');

spm12path = uigetdir(pwd,'Please find where the spm12 toolbox locates');

if ~isnumeric(CNSP_path) &&  ~isnumeric(spm12path)
    
    tic 
    
    system([pwd,'/UFA_T1T2Flair_copy.sh ' Output_Folder ' ' spm12path])
    
    studyDir=[Output_Folder,'/WMH_extraction'];
    
    chos = 0;
    
    UFA_WMH_extraction(studyDir,CNSP_path,spm12path,chos);
    
    toc
    
    system(['rm -rf ',studyDir,'/subjects/Patient/mri/preprocessing']);
    
end


% --- Executes during object creation, after setting all properties.
function U_fiber_cluster_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to U_fiber_cluster_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function U_fiber_quant_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to U_fiber_quant_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in WMH_registration_DWI_btn.
function WMH_registration_DWI_btn_Callback(hObject, eventdata, handles)
% hObject    handle to WMH_registration_DWI_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

UFA_T1T2Flair_alignDWI(handles.OutputDir);


% --- Executes on button press in WMH_view_btn.
function WMH_view_btn_Callback(hObject, eventdata, handles)
% hObject    handle to WMH_view_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_Folder = handles.OutputDir;

T1_image = [Output_Folder,'/WMH_extraction/subjects/Patient/mri/orig/Patient_T1.nii'];

Flair_image = [Output_Folder,'/WMH_extraction/subjects/Patient/mri/orig/Patient_FLAIR.nii'];

WMH_image = [Output_Folder,'/WMH_extraction/subjects/Patient/mri/extractedWMH/Patient_WMH_FLAIRspace.nii.gz'];

unix(['fsleyes ',T1_image,' ',Flair_image,' ',WMH_image]);


% --- Executes during object creation, after setting all properties.
function WMH_view_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WMH_view_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in WMH_stats_btn.
function WMH_stats_btn_Callback(hObject, eventdata, handles)
% hObject    handle to WMH_stats_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

WMH_file_path = [handles.OutputDir,'/WMH_extraction/subjects/'];

tic

UFA_WMHplot_lobe(WMH_file_path)

toc


% --------------------------------------------------------------------
function Generate_Report_Callback(hObject, eventdata, handles)
% hObject    handle to Generate_Report (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function View_the_Result_Callback(hObject, eventdata, handles)
% hObject    handle to View_the_Result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Word_version_Callback(hObject, eventdata, handles)
% hObject    handle to Word_version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Input_Folder = handles.InputDir;

Output_Folder = handles.OutputDir;

T2Flair_Image = handles.T2Flair_Image;

UFA_Export_Word(Input_Folder,Output_Folder,T2Flair_Image)

% --------------------------------------------------------------------
function Html_version_Callback(hObject, eventdata, handles)
% hObject    handle to Html_version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function View_WMH_Callback(hObject, eventdata, handles)
% hObject    handle to View_WMH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_Folder = handles.OutputDir;

T1_image = [Output_Folder,'/WMH_extraction/subjects/Patient/mri/orig/Patient_T1.nii'];

Flair_image = [Output_Folder,'/WMH_extraction/subjects/Patient/mri/orig/Patient_FLAIR.nii'];

WMH_image = [Output_Folder,'/WMH_extraction/subjects/Patient/mri/extractedWMH/Patient_WMH_FLAIRspace.nii.gz'];

unix(['fsleyes ',T1_image,' ',Flair_image,' ',WMH_image]);


% --------------------------------------------------------------------
function View_U_fiber_Callback(hObject, eventdata, handles)
% hObject    handle to View_U_fiber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_Folder = handles.OutputDir;

view_choice = inputdlg('possible choice (whole_brain/U_fiber)','please input the view choice',[1 50],{'U_fiber'});


if ~isempty(view_choice)
    
    U_fiber_View(Output_Folder,view_choice{1})
    
end


% --------------------------------------------------------------------
function View_U_fiber_clusters_Callback(hObject, eventdata, handles)
% hObject    handle to View_U_fiber_clusters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_Folder = handles.OutputDir;

view_direction = inputdlg('possible choice (sup/inf/ant/post/left/right)','please input the view direction',[1 50],{'view_sup'});

if ~isempty(view_direction)
    
    U_fiber_cluster_View(Output_Folder,view_direction{1})
    
end


% --------------------------------------------------------------------
function View_U_fiber_WMH_Callback(hObject, eventdata, handles)
% hObject    handle to View_U_fiber_WMH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_Folder = handles.OutputDir;

view_choice = inputdlg('possible choice (whole_brain/U_fiber)','please input the view choice',[1 50],{'U_fiber'});

if ~isempty(view_choice)
    
    U_fiber_WMH_View(Output_Folder,view_choice{1})
    
end


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4
if (get(hObject, 'Value'))
    
    Neighbor_gyrus_filter_checkbox = 1;
    
else
    
    Neighbor_gyrus_filter_checkbox = 0;
    
end


handles.Neighbor_gyrus_filter_checkbox =  Neighbor_gyrus_filter_checkbox;

guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function U_fiber_filer_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to U_fiber_filer_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function DWIdenoise_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DWIdenoise_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function WMH_extraction_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WMH_extraction_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function Excel_version_Callback(hObject, eventdata, handles)
% hObject    handle to Excel_version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_Folder = handles.OutputDir;

UFA_Export_Excel(Output_Folder)


% --------------------------------------------------------------------
function Excel_74_tracts_dti_Callback(hObject, eventdata, handles)
% hObject    handle to Excel_74_tracts_dti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Output_Folder = handles.OutputDir;

UFA_Export_Excel_74_tracts(Output_Folder)
function varargout = windowapp(varargin)
% WINDOWAPP MATLAB code for windowapp.fig
%      WINDOWAPP, by itself, creates a new WINDOWAPP or raises the existing
%      singleton*.
%
%      H = WINDOWAPP returns the handle to a new WINDOWAPP or the handle to
%      the existing singleton*.
%
%      WINDOWAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WINDOWAPP.M with the given input arguments.
%
%      WINDOWAPP('Property','Value',...) creates a new WINDOWAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before windowapp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to windowapp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help windowapp

% Last Modified by GUIDE v2.5 19-Mar-2019 13:01:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @windowapp_OpeningFcn, ...
                   'gui_OutputFcn',  @windowapp_OutputFcn, ...
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


% --- Executes just before windowapp is made visible.
function windowapp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to windowapp (see VARARGIN)

% Loading models
global customnet alexnet googlenet resnet inceptionresnet currentNet;

load('./models/customnet.mat', 'net');
customnet = net;
load('./models/alexnet.mat', 'net');
alexnet = net;
load('./models/googlenet.mat', 'net');
googlenet = net;
load('./models/resnet.mat', 'net');
resnet = net;
load('./models/inceptionresnet.mat', 'net');
inceptionresnet = net;

currentNet = inceptionresnet;

% Choose default command line output for windowapp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes windowapp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = windowapp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function uploadbutton_Callback(hObject, eventdata, handles)
   global image;

   infoText = findobj(0, 'tag', 'infoText');  
   set(infoText, 'string', "Please wait for file uploading window ...");
   [file, path] = uigetfile('*.jpg');  %open a mat file
   if ~(file == "")
       axes1 = findobj(0, 'tag', 'axes1');       
       axes(axes1);
       imshow([path,file]);

       image = imread([path,file]);
   end
   
   set(infoText, 'string', "Please choose model for classifying");
   

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

    global customnet alexnet googlenet resnet inceptionresnet currentNet image;
    
    infoText = findobj(0, 'tag', 'infoText');  
    set(infoText, 'string', "Please wait for models loading ...");
    if isempty(currentNet)
        
        % Loading models
        load('./models/customnet.mat', 'net');
        customnet = net;
        load('./models/alexnet.mat', 'net');
        alexnet = net;
        load('./models/googlenet.mat', 'net');
        googlenet = net;
        load('./models/resnet.mat', 'net');
        resnet = net;
        load('./models/inceptionresnet.mat', 'net');
        inceptionresnet = net;

        currentNet = inceptionresnet;
    end
    
    set(infoText, 'string', "Please wait for classifying ...");
    
    if ~isempty(image)
        
        resized_image = imresize(image, currentNet.Layers(1).InputSize(1:2));
        [~, scores] = classify(currentNet, resized_image);

        [val1, index1] = max(scores); scores(index1) = [];
        [val2, index2] = max(scores); scores(index2) = [];
        [val3, index3] = max(scores); scores(index3) = [];
        [val4, index4] = max(scores); scores(index4) = [];

        result1 = [currentNet.Layers(end).Classes(index1) num2str(val1*100, '  [%.2f%%]')];
        result2 = [currentNet.Layers(end).Classes(index2) num2str(val2*100, '  [%.2f%%]')];
        result3 = [currentNet.Layers(end).Classes(index3) num2str(val3*100, '  [%.2f%%]')];
        result4 = [currentNet.Layers(end).Classes(index4) num2str(val4*100, '  [%.2f%%]')];

        resultText1 = findobj(0, 'tag', 'resultText1');        
        set(resultText1,'string', ...
            sprintf("%s", result1));
        
        resultText2 = findobj(0, 'tag', 'resultText2');  
        set(resultText2,'string', ...
            sprintf("%s", result2));
        
        resultText3 = findobj(0, 'tag', 'resultText3');  
        set(resultText3,'string', ...
            sprintf("%s", result3));
        
        resultText4 = findobj(0, 'tag', 'resultText4');  
        set(resultText4,'string', ...
            sprintf("%s", result4));
        
    end
    
    set(infoText, 'string', "");

    
% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
    global customnet currentNet;
    currentNet = customnet;

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
    global alexnet currentNet;
    currentNet = alexnet;

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
    global googlenet currentNet;
    currentNet = googlenet;

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
    global resnet currentNet;
    currentNet = resnet;

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
    global inceptionresnet currentNet;
    currentNet = inceptionresnet;

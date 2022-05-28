function varargout = flopcounter(varargin)
% FLOPCOUNTER M-file for flopcounter.fig
%      FLOPCOUNTER, by itself, creates a new FLOPCOUNTER or raises the existing
%      singleton*.
%
%      H = FLOPCOUNTER returns the handle to a new FLOPCOUNTER or the handle to
%      the existing singleton*.
%
%      FLOPCOUNTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLOPCOUNTER.M with the given input arguments.
%
%      FLOPCOUNTER('Property','Value',...) creates a new FLOPCOUNTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before flopcounter_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to flopcounter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help flopcounter

% Last Modified by GUIDE v2.5 28-Apr-2009 21:27:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @flopcounter_OpeningFcn, ...
                   'gui_OutputFcn',  @flopcounter_OutputFcn, ...
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


% --- Executes just before flopcounter is made visible.
function flopcounter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to flopcounter (see VARARGIN)

handles.n = 2000;
handles.cases = 3;
handles.current_method = 3;

% Choose default command line output for flopcounter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes flopcounter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = flopcounter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%First method
n = handles.n;
cases = handles.cases;
option = handles.current_method;
set(handles.text15,'String',' ');
drawnow
%Time solvin each matrix 
flopsgauss = n*(n^2 - 1)/3 + n*(n-1)/2 + n*(n+1)/2; %flops needed to solve each matrix
flopsproduct = n^3;

set(handles.text13,'String','Running!');
drawnow
if option == 1;
time = zeros(1,cases); 
    % Gauss method
for j=1:cases
   A = 100*rand(n); 
   b = 100*rand(n,1); 
   time(j) = cputime;
   Solution = A\b;
   time(j) = cputime - time(j);
end
set(handles.text13,'String',' ');
set(handles.text15,'String','Done!');
flopscases = flopsgauss./time;
computer_flops = mean(flopscases);
%totaltime = sum(time(1:cases));
megaflops = computer_flops/1e6;
set(handles.text7,'String',[num2str(megaflops) ' Megaflops']);

axes(handles.megagauss)
bar(flopscases/1e6,'r')
grid on
axis([0 cases+1 0.95*megaflops 1.05*megaflops])

axes(handles.timegauss)
bar(time)
set(handles.timegauss,'XMinorTick','on')
grid on
end

if option == 2;
    time = zeros(1,cases); 
    % Multiplication method
for j=1:cases
    A = 100*rand(n);
    b = 100*rand(n);
    time(j) = cputime;
    C = A*b;
    time(j) = cputime - time(j);
end
set(handles.text13,'String',' ');
set(handles.text15,'String','Done!');
flopsprod = flopsproduct./time;
computer_flops2 = mean(flopsprod);
%totaltime2 = sum(time);
megaflops2 = computer_flops2/1e6;

set(handles.text7,'String',[num2str(megaflops2) ' Megaflops']);

axes(handles.timemul)
bar(time,'y')
set(handles.timemul,'XMinorTick','on')
grid on
%title(['Time to solve each each ' num2str(n) ' square matrix multiplication'])
%xlabel('Case')
%ylabel('Time [s]')

axes(handles.megamul)
bar(flopsprod/1e6,'r')
%set(handles.megamul,'XMinorTick','on')
%hold on
%plot(0:n , megaflops2*ones(1,n+1) ,'k')
grid on
axis([0 handles.cases+1  0.95*megaflops2 1.05*megaflops2])
%title('Megaflops in each case for product (in black the average)')
%xlabel('Case')
%ylabel('Megaflops')
% 
% axes(handles.timegauss)
% plot(0)
% 
% axes(handles.megagauss)
% plot(0)
end

if option == 3,
    time = zeros(1,2*cases); 
    % Gauss method
for j=1:cases
   A = 100*rand(n); 
   b = 100*rand(n,1); 
   time(j) = cputime;
   Solution = A\b;
   time(j) = cputime - time(j);
end
set(handles.text13,'String',' ');
set(handles.text15,'String','Done!');
flopscases = flopsgauss./time(1:cases);
computer_flops = mean(flopscases);
%totaltime = sum(time(1:handles.cases));
megaflops = computer_flops/1e6;

% Multiplication method
for j=1:cases
    A = 100*rand(n);
    b = 100*rand(n);
    time(handles.cases + j) = cputime;
    C = A*b;
    time(handles.cases + j) = cputime - time(cases + j);
end
flopsprod = flopsproduct./time(cases+1 : 2*cases);
computer_flops2 = mean(flopsprod);
%totaltime2 = sum(time(handles.cases+1 : 2*handles.cases));
megaflops2 = computer_flops2/1e6;

average = mean([megaflops megaflops2]);

set(handles.text7,'String',[num2str(average) ' Megaflops']);

axes(handles.megagauss)
bar(flopscases/1e6,'r')
%set(handles.megagauss,'XMinorTick','on')
%hold on
%plot(0:n , megaflops*ones(1 , n + 1) ,'k')
grid on
axis([0 cases+1 0.95*megaflops 1.05*megaflops])
%title('Megaflops in each case for gauss (in black the average)')
%xlabel('Case')
%ylabel('Megaflops')

axes(handles.timegauss)
bar(time(1:cases))
%set(handles.timegauss,'XMinorTick','on')
grid on
%title(['Time to solve each: ' num2str(n) ' x ' num2str(n) ' system'])
%xlabel('Case')
%ylabel('Time [s]')

axes(handles.timemul)
bar(time(cases+1:2*cases),'y')
%set(handles.timemul,'XMinorTick','on')
grid on
%title(['Time to solve each each ' num2str(n) ' square matrix multiplication'])
%xlabel('Case')
%ylabel('Time [s]')

axes(handles.megamul)
bar(flopsprod/1e6,'r')
%set(handles.megamul,'XMinorTick','on')
%hold on
%plot(0:n , megaflops2*ones(1,n+1) ,'k')
grid on
axis([0 handles.cases+1  0.95*megaflops2 1.05*megaflops2])
%title('Megaflops in each case for product (in black the average)')
%xlabel('Case')
%ylabel('Megaflops')
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.n = round(get(hObject,'Value'));
set(handles.text2,'String',num2str(handles.n));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.cases = round(get(hObject,'Value'));
set(handles.text4,'String',num2str(handles.cases));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
handles.current_method = 1;
guidata(hObject,handles)


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
handles.current_method = 2;
guidata(hObject,handles)

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
handles.current_method = 3;
guidata(hObject,handles)



% --- Executes during object creation, after setting all properties.
function timegauss_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timegauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate timegauss


% --- Executes during object creation, after setting all properties.
function megagauss_CreateFcn(hObject, eventdata, handles)
% hObject    handle to megagauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate megagauss


% --- Executes during object creation, after setting all properties.
function timemul_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timemul (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate timemul


% --- Executes during object creation, after setting all properties.
function megamul_CreateFcn(hObject, eventdata, handles)
% hObject    handle to megamul (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate megamul



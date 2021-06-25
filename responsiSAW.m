function varargout = responsiSAW(varargin)
% responsiSAW MATLAB code for responsiSAW.fig
%      responsiSAW, by itself, creates a new responsiSAW or raises the existing
%      singleton*.
%
%      H = responsiSAW returns the handle to a new responsiSAW or the handle to
%      the existing singleton*.
%
%      responsiSAW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in responsiSAW.M with the given input arguments.
%
%      responsiSAW('Property','Value',...) creates a new responsiSAW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before responsiSAW_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to responsiSAW_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help responsiSAW

% Last Modified by GUIDE v2.5 25-Jun-2021 23:24:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @responsiSAW_OpeningFcn, ...
                   'gui_OutputFcn',  @responsiSAW_OutputFcn, ...
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


% --- Executes just before responsiSAW is made visible.
function responsiSAW_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to responsiSAW (see VARARGIN)

% Choose default command line output for responsiSAW
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes responsiSAW wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = responsiSAW_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonProses.
function buttonProses_Callback(hObject, eventdata, handles)
% hObject    handle to buttonProses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%membaca dan memilih data
x = readmatrix('DATA RUMAH.xlsx');
data = [x(:,3:8)];

%memasukkan nilai w
w=[0.30,0.20,0.23,0.10,0.07,0.10];

%memasukkan k
k=[0,1,1,1,1,1];

%normalisasi matriks
[m n]=size (data); %mengukur ukuran matriz dari data
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong

for j=1:n,
 if k(j)==1, 
  R(:,j)=data(:,j)./max(data(:,j));%benefit
 else
  R(:,j)=min(data(:,j))./data(:,j);%cost
 end;
end;

for i=1:m,
 V(i)= sum(w.*R(i,:)); %menghitung nilai v untuk melakukan perankingan
end;

Vtranspose=V.';%mentranspose V dari baris ke kolom
Vtranspose=num2cell(Vtranspose);%mengubah hasil transpose ke dalam bentuk cell

y = detectImportOptions('DATA RUMAH.xlsx');%mendeteksi opsi impor

y.SelectedVariableNames = (2);%mengambil nama variabel secara spesifik dengan 
%hanya mengambil yaitu nama ke 2 'NAMA RUMAH'
x2= readtable('DATA RUMAH.xlsx',y);%membaca tabel dan mengambil data yang ada dalam kolom y (NAMA RUMAH)

x2 = table2cell(x2);%mengubah bentuk tabel ke dalam bentuk cell
x2=[x2 Vtranspose];%menggabungkan data nama rumah dan juga V ke dalam bentuk matrix

x2=sortrows(x2,-2);%mensorting data berdasarkan dengan nilai V dan diurutkan secera descending
x2 = x2(1:20,1:2)%mengambil 20 data teratas

set(handles.tabelRekomendasi, 'data', x2, 'visible','on');%menampilkan dalam tabel


% --- Executes when entered data in editable cell(s) in tabelRumah.
function tabelRumah_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tabelRumah (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function buttonProses_CreateFcn(hObject, eventdata, handles)
% hObject    handle to buttonProses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function tabelRumah_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tabelRumah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%menampilkan data yang ada pada tabel rumah

x = readmatrix('DATA RUMAH.xlsx');%membaca data pada tabel
data = [x(:,1) x(:,3:8)];%memilih data yang ingin ditampilkan
tabelRumah = findobj(0, 'tag', 'tabelRumah');
set(tabelRumah,'Data',data); 

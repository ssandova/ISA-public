function h = ISA3dPlot(t,PSI,IF,A,fs,fMax,STFTparams)
%==========================================================================
% Call Syntax:  h = ISA3dPlot(t,PSI,IF,A,fs,fMax,STFTparams)
%
% Description: This function plots a 3D instantenous spectrum.
%
% Input Arguments:
%   Name: t
%   Type: vector (real)
%   Description: time instants
%
%   Name: PSI
%   Type: complex matrix (or vector)
%   Description: the $k$th column is the $k$th component $\psi_k(t)$
%
%   Name: IF
%   Type: real matrix (or vector)
%   Description: the $k$th column is the IF of $\psi_k(t)$
%
%   Name: A
%   Type: real matrix (or vector)
%   Description: the $k$th column is the IA of $\psi_k(t)$
%
%	Name: fs
%	Type: scalar
%	Description: sampling freq
%
%	Name: fMax or [fMax,fMin](optional)
%	Type: scalar or [scalar,scalar]
%	Description: maximum plotting frequency and optionally the minimum plotting frequency
%
%	Name: STFTparams (optional)
%	Type: vector (1x2)
%	Description: STFT parameters: [N_FFT,frame_advance]
%
% Output Arguments:
%
%	Name: h
%	Type: handle
%	Description: figure handle
%
%--------------------------------------------------------------------------
%
% If you use these files please cite the following:
%
%       @article{ISA2018_Sandoval,
%           title = {The Instantaneous Spectrum: A General Framework for Time-Frequency Analysis},
%           author = {S.~Sandoval and P.~L.~De~Leon},
%           journal = {{IEEE Trans.~Signal Process.}},
%           volume = {66},
%           year = {2018},
%           month = {Nov},
%           pages = {5679-5693} 
%       }
%
%--------------------------------------------------------------------------
%
% References:
%
% Notes:
%
%
%
%--------------------------------------------------------------------------
% Author: Steven Sandoval
%--------------------------------------------------------------------------
% Revision History:
%
%
%--------------------------------------------------------------------------
%
%   History:    V1.00 (S.Sandoval)
%
% WARNING: This software is a result of our research work and is supplied without any guaranties.
%          We would like to receive comments on the results and report on bugs.
%
%==========================================================================    
S = real(PSI); 

% params.PlotNegativeFreq = false;
% params = parse_pv_pairs(params,varargin);

%------------
% ARG CHECK
%------------
[rT, cT] = size(t);
if ((rT*cT)~= max(rT,cT)), error('myHHT: t must be a one dim vector.'), end
if ((rT*cT)<= 1), error('myHHT: t must be a vector.'), end
t = t(:);

if (length(t)==size(S,2)) && not(length(t)==size(S,1))
    S = S';
end
if max(size(t))~=size(S,1)
    error('error(HilbertMultiComponentPlot): max(size(t))~=size(S,1)')
end

if (length(t)==size(IF,2)) && not(length(t)==size(IF,1))
    IF = IF';
end
if size(S)~=size(IF)
    error('error(HilbertMultiComponentPlot): size(S)~=size(IF)')
end

if (length(t)==size(A,2)) && not(length(t)==size(A,1))
    A = A';
end
if size(S)~=size(A)
    error('error(HilbertMultiComponentPlot): size(S)~=size(A)')
end
if sum(max(S) > 1e5)>0;warning('Warning(HilbertMultiComponentPlot): huge values, ignoring columns...');end
IF = IF(:,not(max(S) > 1e5));
A = A(:,not(max(S) > 1e5));
S = S(:,not(max(S) > 1e5));

if nargin<6
    fMax = min([1.05*max(max(IF)),fs/2]);
    fMin = 0;
end
if length(fMax)==1
    fMin = 0;
elseif    length(fMax)==2
    fMin = fMax(1);
    fMax = fMax(2);
end
lims = [0,t(length(t)),fMin,fMax,min(-1.05*max(max(abs(sum(S,2)))),-1.05*max(max(abs(S))))  ,max(1.05*max(max(abs(sum(S,2)))),1.05*max(max(abs(S)))) ];



if nargin<7
    STFTparams(1) = 1024;
    STFTparams(2) = 4;
    STFTparams(3) = 1024;
end

if length(STFTparams) < 3
    STFTparams(3) = STFTparams(1);
end

%FIND COMPONTENTs OUT OF PLOTTING AREA
IFtest = (IF>fMax);
exclude = find(all(IFtest,1));

% IF(not(IF<=fMax)) = NaN;
% if not(params.PlotNegativeFreq)
%     if (sum(IF < 0)>0);warning('Warning(HilbertMultiComponentPlot):  ignoring negative frequency values');IF(IF<0)=NaN;end
% else
%     IF(IF<fMin)=NaN;
% end
%------------------
% Figure and Axes
%------------------

%OPEN FIGURE
%set(0,'HideUndocumented','off');
h.fig = figure('name','AM-FM Model');hold on;
set(h.fig,'units','normalized', 'Position',  [ 0.05    0.05    1-0.1    0.85],'color',[1,1,1]);

%COLORMAP
cmap = colormap(pmkmp(256,'CubicYF') );
caxis([0,max(max(abs(A)))])
set(gca,'color',[1,1,1])

%AXIS AND VIEW
axis(lims)
view([-30,70])
a = axis;

%---------------
% Draw 3D Box
%---------------

%BOX SIDES
h.p1 = patch([a(1),a(1),a(2),a(2)],[a(3),a(4),a(4),a(3)],[a(5),a(5),a(5),a(5)],cmap(1,:));
h.p2 = patch([a(1),a(1),a(2),a(2)],[a(4),a(4),a(4),a(4)],[a(5),a(6),a(6),a(5)],rgb('Black'),'FaceAlpha',0.25);
h.p3 = patch([a(2),a(2),a(2),a(2)],[a(3),a(3),a(4),a(4)],[a(5),a(6),a(6),a(5)],rgb('Navy'),'FaceAlpha',0.25);
plot3([a(1),a(1)],[a(3),a(4),],[a(6),a(6)],'--k');
plot3([a(1),a(2)],[a(3),a(3)],[a(6),a(6)],'--k');
if fMin<0
    plot3([a(1),a(1)],[a(3),a(3)],[a(5),a(6)],'--k');
end

%AXES THROUGH ORIGIN
ORIGIN = [0,0,0];
try
    h.oa = oaxes(ORIGIN,'Xlabel',{'\it{-time(sec)}','\it{time(sec)}'},'Ylabel',{'\it{ }','\it{frequency(Hz)}'},'Zlabel',{'\it{-real}','\it{real}'});
    set(get(h.oa,'hXLabel'),'FontSize',16)
    set(get(h.oa,'hYLabel'),'FontSize',16)
    set(get(h.oa,'hZLabel'),'FontSize',16)
    set(get(h.oa,'hXTickLabel'),'FontSize',16)
    set(get(h.oa,'hYTickLabel'),'FontSize',16)
    set(get(h.oa,'hZTickLabel'),'FontSize',16)
catch
    warning('Visualizations in this package are not yet fully supported using R2014B and later. The visualization may differ in appearance than those shown in the manual.')
    xlabel('time','FontSize',16);
    ylabel('frequency','FontSize',16);
    zlabel('real','FontSize',16);
end
set(gca,'color',get(gcf,'color'))

%-------------------------
% Plot AM-FM Components
%-------------------------

%DRAW 4D LINES (time/real/frequency/amplitude)
for kk = setxor((1:size(S,2)),exclude)
    h.l1(kk) = colorLine(t, IF(:,kk), S(:,kk), abs(A(:,kk)));
    set(h.l1(kk),'LineWidth',1.5,'LineSmoothing','on','EdgeAlpha',0.8,'FaceAlpha',0.8)
    %h.l2(kk) = colorLine(t, IF(:,kk),  A(:,kk)       , A(:,kk));set(hl,'LineWidth',2)
    %h.l3(kk) = colorLine(t, IF(:,kk), -A(:,kk)       , A(:,kk));set(hl,'LineWidth',2)
end

%-------------------------------------
% Plot Projections and Comparisions
%-------------------------------------

%REAL SUPER-PROJECTION
h.Line = patchline(t,zeros(size(t)),sum(S,2),'LineSmoothing','on','FaceColor',rgb('white'),'EdgeColor',rgb('white'),'EdgeAlpha',0.9,'FaceAlpha',0.9);
set(h.Line,'Visible','off');

%FT OVERLAY
N = size(S,1);
PHI  = fft((sum(PSI,2)),N);
PHI = PHI./max(abs(PHI));
f_axis = (0:(2*pi)/N:2*pi-(1/N))./pi.*(fs/2);
h.FFT(1) = patchline(zeros(size(f_axis)),f_axis,...
    max(   [max(max(sum(S,2))),max(max(sum(A,2))  ) ])   .*abs(PHI)./max(max(abs(PHI))),...
    'LineSmoothing','on','FaceColor',rgb('OrangeRed'),'EdgeColor',rgb('OrangeRed'),'EdgeAlpha',0.9,'FaceAlpha',0.9,'LineWidth',1.5);
set(h.FFT,'Visible','off');
set(h.FFT,'LineSmoothing','on');

%STFT UNDERLAY
X = ISstft(sum(PSI,2),hamming(STFTparams(1)),STFTparams(2),STFTparams(3));
imgzposition = a(5)+1e-10;
fInd = (0:size(X,1)-1)./(size(X,1)-1).*fs;
if fMin==0
    planeimg = abs(X(fInd<=fMax,:));
else 
    fInd(fInd>fs/2) = fInd(fInd>fs/2)-fs;
    planeimg = abs(X(  (fInd<=fMax)&(fInd>=fMin)  ,:));
    planeimg = fftshift(planeimg,1);
end
planeimg = planeimg./max(max(abs(planeimg)));
h.fft = surf([a(1) a(2)],[fMin fMax],repmat(imgzposition, [2 2]),planeimg,'facecolor','texture');
set(h.fft,'Visible','off');
set(h.fft,'LineSmoothing','on');


%------------------
% USER INTERFACE
%------------------

h.b1 = uicontrol('Parent',gcf,'String','Time/Real Plane','units','normalized',...
    'Position',[0.01 .01 1/8 0.05]);
h.b2 = uicontrol('Parent',gcf,'String','Freq/Real Plane','units','normalized',...
    'Position',[0.01+9/64 .01 1/8 0.05]);
h.b3 = uicontrol('Parent',gcf,'String','Time/Freq Plane','units','normalized',...
    'Position',[0.01+9/64*2 .01 1/8 0.05]);
h.b4 = uicontrol('Parent',gcf,'String','Default 3D View','units','normalized',...
    'Position',[0.01+9/64*3 .01 1/8 0.05]);
h.b5  = uicontrol('Parent',gcf,'String','Custom Rotate','units','normalized',...
    'Position',[0.01+9/64*4 .01 1/8 0.05]);
h.b6 = uicontrol('Parent',gcf,'String','Toggle Real Superposition','units','normalized',...
    'Position',[0.01+9/64*5 .01 1/8 0.05]);
h.b7 = uicontrol('Parent',gcf,'String','Toggle FT','units','normalized',...
    'Position',[0.01+9/64*6 .01 1/16 0.05]);
h.b8 = uicontrol('Parent',gcf,'String','Toggle STFT','units','normalized',...
    'Position',[0.01+((9/64*6)+(9/64*7))/2 .01 1/16 0.05]);

h.b9 = uicontrol('Parent',gcf,'String','Play','units','normalized','BusyAction','cancel','Interruptible','off',...
    'Position',[0.01+((9/64*6)+(9/64*7))/2 .35 1/16 0.05]);
h.b10 = uicontrol('Parent',gcf,'String','Real Plot','units','normalized','BusyAction','cancel','Interruptible','off',...
    'Position',[0.01+((9/64*6)+(9/64*7))/2 .3 1/16 0.05]);
h.b11 = uicontrol('Parent',gcf,'String','Amplitude Plot','units','normalized','BusyAction','cancel','Interruptible','off',...
    'Position',[0.01+((9/64*6)+(9/64*7))/2 .25 1/16 0.05]);
h.b12 = uicontrol('Parent',gcf,'String','IS Plot','units','normalized','BusyAction','cancel','Interruptible','off',...
    'Position',[0.01+((9/64*6)+(9/64*7))/2 .2 1/16 0.05]);
h.b13 = uicontrol('Parent',gcf,'String','STFT Plot','units','normalized','BusyAction','cancel','Interruptible','off',...
    'Position',[0.01+((9/64*6)+(9/64*7))/2 .15 1/16 0.05]);

set(h.b1,'callback',{@changeview,gcf,[0,0],[-30,70]})
set(h.b2,'callback',{@changeview,gcf,[-90,0],[-30,70]})
set(h.b3,'callback',{@changeview,gcf,[0,90],[-30,70]})
set(h.b4,'callback',{@changeview,gcf,[-30,70],[-30,70]})
set(h.b5,'callback',{@freerotate,gcf})
set(h.b6,'callback',{@ToggleVis,gcf,h.Line})
set(h.b7,'callback',{@ToggleVis,gcf,h.FFT})
set(h.b8,'callback',{@ToggleVis,gcf,h.fft})

set(h.b9,'callback',{@PlayFromPlot,sum(S,2),fs})
set(h.b10,'callback',{@dispRealPlot,t,S,fs})
set(h.b11,'callback',{@dispAMPPlot,t,A})
set(h.b12,'callback',{@dispISPlot,abs(S),IF,A,fs,[fMin,fMax],t})
set(h.b13,'callback',{@dispFSPlot,planeimg,fs,[fMin,fMax],t})








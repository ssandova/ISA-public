function h = Argand(t,psi)
% Call Syntax:  h = Argand(t,psi)
%
% Description: This function plots an AM-FM component as a rotating vector.
%
% Input Arguments:
%   Name: t
%   Type: vector (real)
%   Description: time instants
%
%   Name: psi
%   Type: vector (complex)
%   Description: AM-FM component
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



%------------
% ARG CHECK
%------------

if min(size(t))~=1
    error('min(size(t))~=1')
end

if min(size(t))~=1
    error('min(size(t))~=1')
end

if length(t)~=length(psi)
    error('length(t)~=length(psi)')
end

t = t(:);
psi = psi(:);

%----------
% MAIN
%----------


%FIGURE
h.fig =figure('name','Argand Diagram');hold on;set(h.fig,'units','normalized', 'Position',  [ 0.05    0.05    1-0.1    0.85],'color',[1,1,1]);

%PLOT
h.p = patchline(t,real(psi),imag(psi),'LineSmoothing','on','FaceColor',rgb('MediumBlue'),'EdgeColor',rgb('MediumBlue'),'EdgeAlpha',0.9,'FaceAlpha',0.9); %,'LineWidth',3,'color',);

%REAL PROJECTION
h.Fill1 = fill3([0;t;t(end)],zeros(length(t)+2,1),[0;imag(psi);0],rgb('MediumBlue'),'EdgeColor',rgb('MediumBlue'),'LineWidth',0.5,'LineSmoothing','on','EdgeAlpha',0.5,'FaceAlpha',0.25);
set(h.Fill1,'Visible','off');

%IMAG PROJECTION
h.Fill2 = fill3([0;t;t(end)],[0;real(psi);0],zeros(length(t)+2,1),rgb('DarkSlateGrey'),'EdgeColor',rgb('DarkSlateGrey'),'LineWidth',0.5,'LineSmoothing','on','EdgeAlpha',0.5,'FaceAlpha',0.25);
set(h.Fill2,'Visible','off');

%AXES AND VIEW
lims = [0,t(end),-1.1*max([max(abs(psi)),1]),1.1*max([max(abs(psi)),1]),-1.1*max([max(abs(psi)),1]),1.1*max([max(abs(psi)),1])];
axis(lims);
da = daspect;
view([42,12])

ORIGIN = [0,0,0];
try
    oaxes(ORIGIN,'Xlabel',{'\it{-time(sec)}','\it{time(sec)}'},'Ylabel',{'\it{-real}','\it{real}'},'Zlabel',{'\it{-imag}','\it{imag}'});
catch
    warning('Visualizations in this package are not yet fully supported using R2014B and later. The visualization may differ in appearance than those shown in the manual.')
    xlabel('time');
    ylabel('real');
    zlabel('imag');
end
set(gca,'color',get(gcf,'color'))



%------------------
% USER INTERFACE
%------------------

h.b1 = uicontrol('Parent',gcf,'String','Time/Real Plane','units','normalized',...
    'Position',[0.01+9/64*0 .01 1/8 0.05]);
h.b2 = uicontrol('Parent',gcf,'String','Real/Imag Plane','units','normalized',...
    'Position',[0.01+9/64*1 .01 1/8 0.05]);
h.b3 = uicontrol('Parent',gcf,'String','Time/Imag Plane','units','normalized',...
    'Position',[0.01+9/64*2 .01 1/8 0.05]);
h.b4 = uicontrol('Parent',gcf,'String','Default 3D View','units','normalized',...
    'Position',[0.01+9/64*3 .01 1/8 0.05]);
h.b5 = uicontrol('Parent',gcf,'String','Custom Rotate','units','normalized',...
    'Position',[0.01+9/64*4 .01 1/8 0.05]);
h.b6 = uicontrol('Parent',gcf,'String','Toggle Signal Trace','units','normalized',...
    'Position',[0.01+9/64*5 .01 1/8 0.05]);
h.b7 = uicontrol('Parent',gcf,'String','Real Projection','units','normalized',...
    'Position',[0.01+9/64*6 .01 1/16 0.05]);
h.b8 = uicontrol('Parent',gcf,'String','Imag Projection','units','normalized',...
    'Position',[0.01+((9/64*6)+(9/64*7))/2 .01 1/16 0.05]);

set(h.b1,'callback',{@changeview,gcf,[0,90],[42,12]})
set(h.b2,'callback',{@changeview,gcf,[90,0],[42,12]})
set(h.b3,'callback',{@changeview,gcf,[0,0],[42,12]})
set(h.b4,'callback',{@changeview,gcf,[42,12],[42,12]})
set(h.b5,'callback',{@freerotate,gcf})
set(h.b6,'callback',{@ToggleVis,gcf,h.p})
set(h.b7,'callback',{@ToggleVis,gcf,h.Fill2})
set(h.b8,'callback',{@ToggleVis,gcf,h.Fill1})

h.ar = uicontrol('Parent',gcf,'units','normalized','Style', 'slider','BusyAction','cancel','Interruptible','off',...
    'Min',1,'Max',length(t),'SliderStep',[1/length(t),20/length(t)],'Value',floor(length(t)/2),...
    'Position', [0.125,0.08-0.02,0.790,0.01]);
set(h.ar,'Callback', {@AnimateRealImag,t,psi,h});

kk = round(get(h.ar,'Value'));
arw = arrow([t(kk) 0 0],[t(kk),real(psi(kk)),imag(psi(kk))], 'EdgeColor','r','FaceColor','r','FaceAlpha',0.9,'EdgeAlpha',0.9,'LineWidth',3,'MarkerSize',10,'LineSmoothing','on');
guidata(gcf,arw);
daspect(da)






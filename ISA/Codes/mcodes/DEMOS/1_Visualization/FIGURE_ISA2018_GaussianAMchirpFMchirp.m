%*********************************************************************
% The Instantaneous Spectrum: Code Examples for Reproducible Research
%*********************************************************************
%
% Description: This script generates Figure 7 (a) in the below reference.     
%
%*********************************************************************
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
%*********************************************************************
clear all
close all
clc
addpath(genpath(fileparts(fileparts(pwd))));

%=================================================================
 
printFlag = false;
lightingFlag = false;
newLight = false;

aaFactor = 2;
 
 
ORIGIN = [0,0,0];
 
 
fs = 5000; %sampling freq
Ts = 1/fs;
t = 0:Ts:2.25;
T = length(t); 
 
alpha = 15;
beta = 5;
 t_0=1;

 
S = [];PSI = [];IF = [];A = [];
for k = 1
    if k==1
        a = (4*alpha^3/pi)^(1/4)*(t-t_0) .* exp(-alpha/2.*(t-t_0).^2);
        m = beta .* (t-t_0);
        fc = 5;
    end
    [psi,s] = amfmmod(a,m,fc,fs);
    fi = fc.*ones(size(t))+(m);
    PSI = [PSI,psi(:)];
    S = [S,s(:)];
    IF = [IF,fi(:)];
    A = [A,a(:)];
end
z = sum(PSI,2);
x = real(z);
 
 
fMax = fc*2.5;
pct = 99.999;
 
t=t';
 
  
%OPEN FIGURE
%set(0,'HideUndocumented','off');
h.fig = figure('name','AM-FM Model');hold on;
set(h.fig,'units','normalized', 'Position',  [ 0.05    0.05    1-0.1    0.85],'color',[1,1,1]);
 
%COLORMAP
cmap = colormap(pmkmp(256,'CubicYF') );
caxis([0,max(max(abs(A)))])
set(gca,'color',[1,1,1])
 
 
%AXIS AND VIEW
% fMax = min([1.05*max(max(IF)),fs/2]);
fMin = 0;
lims = [0,t(length(t)),fMin,fMax,-0.01  ,max(1.05*max(max(abs(sum(S,2)))),1.05*max(max(abs(S)))) ];
axis(lims)
view([-30,35])
ax = axis;
 
close 
 
%=======================================================================================
 
isa = ISA3dPlotPrint(t,S,IF,A,fs,fMax);
set(isa.oa,'XTick',[t_0])
set(isa.oa,'YTick',[fc])
set(isa.oa,'ZTick',[])
set(isa.oa,'XTickLabel',{'0'})
set(isa.oa,'YTickLabel',{'$\omega_0~~$'})
set(isa.oa,'TickLabelFontSize',20,'TickLabelInterpreter','latex')

isa.oa = oaxes(ORIGIN,'Xlabel',{'\it{-time}','\it{time}'},'Ylabel',{'\it{ }','\it{frequency}'},'Zlabel',{'\it{-real}','\it{real}'});
 
if (lightingFlag)
    hl = lightangle(5,60)
    if (newLight)
        lightangle(hl,-30,70)
    else
        lightangle(hl,5,40)
    end
    lighting PHONG; material dull;
end
 
view([-30,70])
set(isa.Line,'Visible','on');
 
 
if (printFlag)
    fileNameStr = 'HSA3dHD_85';
    oaxes('TickLength',aaFactor*[6,8]);
    pause(1);
    myaa([aaFactor,floor(aaFactor/2)])
    movefile('myaa_temp_screendump.png',[,fileNameStr,'.png'],'f')
    pause(1);
    close gcf;
end
 

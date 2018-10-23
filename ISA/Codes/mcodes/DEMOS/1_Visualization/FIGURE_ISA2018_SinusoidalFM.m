%*********************************************************************
% The Instantaneous Spectrum: Code Examples for Reproducible Research
%*********************************************************************
%
% Description: This script generates Figure 6 (a) and (b) in the below
%              reference.
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

printFlag = false;
lightingFlag = false;
newLight = false;

aaFactor = 2;

%==================================================================
%FM VIEW
%==================================================================

phiphi = pi/2;
%UNDERLYING SIGNAL MODEL
fs = 1000; %sampling freq
Ts = 1/fs;
%t = (0:8.5*fs)./fs;
t = (0:0.5*fs)./fs;
a = ones(size(t));
fm = 2;
B = 25;
fc = 55;
m = B*cos(2*pi*fm*t+phiphi);%fm message
phi = B/fm;%phase offset
[psi,s,sigma,fi] = amfmmod(a,m,fc,fs,phi); 
fMax = 2.25*fc;
z = psi;

isa1 = ISA3dPlotPrint(t,s,fi',a',fs,fMax,[1024*4,4]);

set(isa1.oa,'XTick',[])
set(isa1.oa,'YTick',[fc])
set(isa1.oa,'ZTick',[])
set(isa1.oa,'XTickLabel',{})
set(isa1.oa,'YTickLabel',{'$\omega_0~~~$'})
set(isa1.oa,'TickLabelFontSize',20,'TickLabelInterpreter','latex')
set(isa1.oa,'Xlabel',{'\it{-time}','\it{time}'},'Ylabel',{'\it{ }','\it{frequency}'},'Zlabel',{'\it{-real}','\it{real}'})


    set(isa1.Line,'Visible','on');

if (lightingFlag)
    hl = lightangle(5,60)
    if (newLight)
        lightangle(hl,-30,70)
    else
        lightangle(hl,5,40)
    end
    lighting PHONG; material dull;
end

if (printFlag)
    fileNameStr = 'sinFM_HD';
    oaxes('TickLength',aaFactor*[6,8]);
    pause(1);
    myaa([aaFactor,floor(aaFactor/2)])
    movefile('myaa_temp_screendump.png',[fileNameStr,'.png'],'f')
    pause(1);
    close gcf;
end

%==================================================================
%SHC VIEW
%==================================================================

%UNDERLYING SIGNAL MODEL
nComp = 22;
PSI = [];
S = [];
IF = [];
A = [];
m = zeros(size(t));
for k = -nComp:nComp;
    a = besselj(k,B/fm)*ones(size(t));
    phi = k*phiphi;
    [psi,s,sigma,fi] = amfmmod(a,m,fc+k*fm,fs,phi); 

    PSI = [PSI,psi(:)];
    S = [S,s(:)];
    IF = [IF,fi(:)];
    A = [A,a(:)];
end

%3D   SPECTRUM
isa2 = ISA3dPlotPrint(t,S,IF,A,fs,fMax,[1024,4]);
%title(' ','FontSize',18,'Interpreter','latex','string',['$x(t) = \Re\lbrace\sum\limits_{k=-',num2str(nComp),'}^{',num2str(nComp),'}J_k(2\pi B/\omega_m)e^{j[(\omega_c+k\omega_m)t]}\rbrace$']);

set(isa2.oa,'XTick',[])
set(isa2.oa,'YTick',[fc])
set(isa2.oa,'ZTick',[])
set(isa2.oa,'XTickLabel',{})
set(isa2.oa,'YTickLabel',{'$\omega_0~~~$'})
set(isa2.oa,'TickLabelFontSize',20,'TickLabelInterpreter','latex')
set(isa2.oa,'Xlabel',{'\it{-time}','\it{time}'},'Ylabel',{'\it{ }','\it{frequency}'},'Zlabel',{'\it{-real}','\it{real}'})

set(isa2.Line,'Visible','on');


if (lightingFlag)
    hl = lightangle(5,60)
    if (newLight)
        lightangle(hl,-30,70)
    else
        lightangle(hl,5,40)
    end
    lighting PHONG; material dull;
end

if (printFlag)
    fileNameStr = 'sinFM_FT_HD';
    oaxes('TickLength',aaFactor*[6,8]);
    pause(1);
    myaa([aaFactor,floor(aaFactor/2)])
    movefile('myaa_temp_screendump.png',[fileNameStr,'.png'],'f')
    pause(1);
    close gcf;
end






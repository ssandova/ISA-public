%*********************************************************************
% The Instantaneous Spectrum: Code Examples for Reproducible Research
%*********************************************************************
%
% Description: This script generates Figure 5 (a) and (b) in the below
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

%**********************************
% CHANGE THIS PARAMETER
fdelta = 2.5;%  <---- TRY 5 and 60
%**********************************

printFlag = false;
lightingFlag = false;
newLight = false;
aaFactor = 2;

%==================================================================
%ASSUMING SHCs
%==================================================================

%UNDERLYING SIGNAL MODEL
fs = 1000; %sampling freq
Ts = 1/fs;
t = (0:Ts:1)';
%t = (0:Ts:9)';
fc = 20;
fc1 = fc-fdelta;
fc2 = fc+fdelta;
a = 1/2.*ones(size(t));
m = zeros(size(t));
fi1 = fc1.*ones(size(t))+m;
fi2 = fc2.*ones(size(t))+m;
[psi1,s1] = amfmmod(a,m,fc1,fs,0);
[psi2,s2] = amfmmod(a,m,fc2,fs,0);


%3D   SPECTRUM

fMax = 1.75*fc;
isa1 = ISA3dPlotPrint(t,[s1,s2],[fi1,fi2],[abs(a),abs(a)],fs,1.75*fc,[1024*8,32]);

try
    set(isa1.oa,'XTick',[])
    set(isa1.oa,'YTick',[fc1,fc2])
    set(isa1.oa,'ZTick',[])
    set(isa1.oa,'XTickLabel',{})
    set(isa1.oa,'YTickLabel',{'$\omega_\mathrm{a}~~~$','$\omega_\mathrm{b}~~~$'})
    set(isa1.oa,'TickLabelFontSize',20,'TickLabelInterpreter','latex')
    set(isa1.oa,'Xlabel',{'\it{-time}','\it{time}'},'Ylabel',{'\it{ }','\it{frequency}'},'Zlabel',{'\it{-real}','\it{real}'})
catch
    warning('Visualizations in this package are not yet fully supported using R2014B and later. The visualization may differ in appearance than those shown in the manual.')
    xlabel('time','FontSize',16);
    ylabel('frequency','FontSize',16);
    zlabel('real','FontSize',16);
end

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
    fileNameStr = 'BeatFT_HD';
    oaxes('TickLength',aaFactor*[6,8]);
    pause(1);
    myaa([aaFactor,floor(aaFactor/2)])
    movefile('myaa_temp_screendump.png',[fileNameStr,'.png'],'f')
    pause(1);
    close gcf;
end


%====================================================================
%ASSUMING A SINGLE AM COMPONENT
%==================================================================

%UNDERLYING SIGNAL MODEL
a = cos(2*pi*fdelta.*t);
m = zeros(size(t));
fi = fc.*ones(size(t))+m;
[psi,s] = amfmmod(a,m,fc,fs);

%3D   SPECTRUM
isa2 = ISA3dPlotPrint(t,s,fi,abs(a),fs,1.75*fc,[1024*8,32]);
%title(' ','FontSize',20,'Interpreter','latex','string','$x(t) = \Re\left\lbrace 2\cos\left[\left(\omega_\mathrm{b}-\omega_\mathrm{a}\right)t/2\right]\exp\left[j\left(\omega_\mathrm{b}+\omega_\mathrm{a}\right)t/2\right]\right\rbrace$');

try
    set(isa2.oa,'XTick',[])
    set(isa2.oa,'YTick',[fc])
    set(isa2.oa,'ZTick',[])
    set(isa2.oa,'XTickLabel',{})
    set(isa2.oa,'YTickLabel',{'${(\omega_\mathrm{b}+\omega_\mathrm{a})}~~~/{2}~~~$'})
    set(isa2.oa,'TickLabelFontSize',20,'TickLabelInterpreter','latex')
    set(isa2.oa,'Xlabel',{'\it{-time}','\it{time}'},'Ylabel',{'\it{ }','\it{frequency}'},'Zlabel',{'\it{-real}','\it{real}'})
catch
    warning('Visualizations in this package are not yet fully supported using R2014B and later. The visualization may differ in appearance than those shown in the manual.')
    xlabel('time','FontSize',16);
    ylabel('frequency','FontSize',16);
    zlabel('real','FontSize',16);
end
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
    fileNameStr = 'BeatAM_HD';
    oaxes('TickLength',aaFactor*[6,8]);
    pause(1);
    myaa([aaFactor,floor(aaFactor/2)])
    movefile('myaa_temp_screendump.png',[fileNameStr,'.png'],'f')
    pause(1);
    close gcf;
end



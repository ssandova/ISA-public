%*********************************************************************
% The Instantaneous Spectrum: Code Examples for Reproducible Research
%*********************************************************************
%
% Description: This script demonstrates the functionality of `amfmmod.m', `Argand.m', `ISA2dPlot.m', and `ISA3dPlot.m' by synthesizing 
%              a multi-component AM--FM signal and generating several visualizations. 
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

%---------------------------------------------------------------------

%UNDERLYING SIGNAL MODEL
fs = 16000;                 %sampling freq
Ts = 1/fs;                  %sampling period
t = 0:Ts:1-Ts;              %time index 

%DEFINE 3 COMPONENTS
S = [];PSI = [];IF = [];A = [];
for k = 1:3;
    if k==1
        a = gausswin(length(t),5)';
        m = 50*sin(2*pi*2*t);
        fc = 70;
    elseif k==2
        a = 0.5*ones(size(t))+1/3.*sin(20.*t);
        m = zeros(size(t));
        fc = 100;
    elseif k==3
        a = hamming(length(t))';
        m = exp(t+4.5)-exp(4.5);
        fc = 10;
    end
    [psi,s] = amfmmod(a,m,fc,fs);
    fi = fc.*ones(size(t))+(m);
    PSI = [PSI,psi(:)];
    S = [S,s(:)];
    IF = [IF,fi(:)];
    A = [A,a(:)];
end

%==================================================================

%PARAMETERS
fMax = 180;                %max plotting freq
STFTparms = [1024*2,1];       %STFT window length and advance

%3D ARGAND DIAGRAM
h1 = Argand(t,sum(PSI,2));

%INSTANTANEOUS SPECTRUM
h2 = ISA2dPlot(t,S,IF,A,fs,fMax);

%3D HILBERT SPECTRUM
h3 = ISA3dPlot(t,S,IF,A,fs,fMax,STFTparms);

%==================================================================






















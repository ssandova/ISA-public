%*********************************************************************
% The Instantaneous Spectrum: Code Examples for Reproducible Research
%*********************************************************************
%
% Description: This script demonstrates the functionality of `amfmmod.m', `Argand.m', `ISA2dPlot.m', and `ISA3dPlot.m' by synthesizing 
%              a simple harmonic component (SHC) and several visualizations. 
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
fs = 16000;                     %sampling freq
Ts = 1/fs;                      %sampling period
t = 0:Ts:1;                     %time index
a = ones(size(t));              %IA
fc = 100;                       %initial frequency (Hz)
m = zeros(size(t));             %FM message (Hz)

a = a(:);
m = m(:);

[psi,s,sigma,fi] = amfmmod(a,m,fc,fs);   %AM--FM component

%==================================================================

%PARAMETERS
fMax = 2*fc;                 %max plotting freq
STFTparams = [1024*8,128];   %STFT window length and advance

%3D ARGAND DIAGRAM
h1 = Argand(t,sum(psi,2));

%INSTANTANEOUS SPECTRUM
h2 = ISA2dPlot(t,s,fi,a,fs,fMax);

%3D INSTANTANEOUS SPECTRUM
h3 = ISA3dPlot(t,s,fi,a,fs,fMax,STFTparams);

%==================================================================











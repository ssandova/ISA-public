%*********************************************************************
% The Instantaneous Spectrum: Code Examples for Reproducible Research
%*********************************************************************
%
% Description: This Demo script estimates the approximate computation
%              of an intergral using various methods.
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
drawnow;

%----------------------------------------------------------------------

%UNDERLYING SIGNAL MODEL
fs=10;                                       %sampling frequency
t = (0:1/fs:2*pi)';                          %time index
x = sin(t);                                  %signal

%CALCULATON OF THE INTEGRAL APPROXIMATION
yi1 = intApprox(x,fs,'left');
yi2 = intApprox(x,fs,'right');
yi3 = intApprox(x,fs,'center');
yi4 = intApprox(x,fs,'trapz');
yi5 = intApprox(x,fs,'simps');

%PLOT
figure()
hold on;
plot(-cos(t)+ cos(0),'g','linewidth',3)     %actual integral
plot(yi1)
plot(yi2,'k:')
plot(yi3,'y','linewidth',2)
plot(yi4,'r')
plot(yi5,'m--','linewidth',2)
axis tight;
legend('truth','left','right','center','trapz','simps')


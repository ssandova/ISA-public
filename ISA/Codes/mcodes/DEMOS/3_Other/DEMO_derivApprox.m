%*********************************************************************
% The Instantaneous Spectrum: Code Examples for Reproducible Research
%*********************************************************************
%
% Description: This Demo script estimates the approximate computation
%              of a derivative using various methods.
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
fs = 10;                                    %sampling frequency
t = (0:1/fs:2*pi)';                         %time index
x = sin(t);                                 %signal

%CALCULATION OF THE DERIVATIVE APPROXIMATION
yd1 = derivApprox(x,fs,'forward');          
yd2 = derivApprox(x,fs,'backward');
yd3 = derivApprox(x,fs,'center3');
yd4 = derivApprox(x,fs,'center5');
yd5 = derivApprox(x,fs,'center7');
yd6 = derivApprox(x,fs,'center9');
yd7 = derivApprox(x,fs,'center11');
yd8 = derivApprox(x,fs,'center13');
yd9 = derivApprox(x,fs,'center15');

%PLOT
figure()
hold on;
plot(cos(t),'g','linewidth',3)              %actual derivative
plot(yd1)
plot(yd2,'r')
plot(yd3,'m--','linewidth',2)
plot(yd4,'k:','linewidth',2)
plot(yd5,'c:','linewidth',2)
plot(yd6,'y--','linewidth',2)
plot(yd7,'k--','linewidth',2)
plot(yd8,'g:','linewidth',2)
plot(yd9,'b --','linewidth',2)
axis tight;
legend('truth','forward','backward','center3','center5','center7','center9','center11','center13','center15')


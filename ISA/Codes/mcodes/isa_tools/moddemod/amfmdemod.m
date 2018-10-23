function [A,IF,S,SIGMA,THETA] = amfmdemod(PSI,varargin)
%==========================================================================
% Call Syntax: [A,IF,S,SIGMA,THETA] = amfmdemod(PSI,varargin)
%
% Description:  This function demodulates a complex AM-FM component.
%
% Input Arguments:
%   Name: PSI
%   Type: complex matrix (or vector)
%   Description: the $k$th column is the $k$th component $\psi_k(t)$
%
% Optional Input Arguments:
%	Name: demodPhaseDeriv
%	Type: String
%   Default: 'center9'
%	Description: numerical differentation method:
%       'forward'
%       'backward'
%       'center3'
%       'center5'
%       'center7'
%       'center9'
%       'center11'
%       'center13'
%       'center15'
%
%	Name: fs
%	Type: integer
%   Default: 1
%	Description: sampling frequency
%
% Output Arguments:
%   Name: A
%   Type: real matrix (or vector)
%   Description: the $k$th column is the IA of $\psi_k(t)$
%
%   Name: IF
%   Type: real matrix (or vector)
%   Description: the $k$th column is the IF of $\psi_k(t)$
%
%   Name: S
%   Type: real matrix (or vector)
%   Description: the $k$th column is the real part of $\psi_k(t)$
%
%   Name: SIGMA
%   Type: real matrix (or vector)
%   Description: the $k$th column is the imaginary part of $\psi_k(t)$
%
%   Name: THETA
%   Type: real matrix (or vector)
%   Description: the $k$th column is the instantaneous angle of $\psi_k(t)$
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
%
% Notes:
%
%
% Function Dependencies:    derivApprox.m
%                          
%
%--------------------------------------------------------------------------
% Author: Steven Sandoval
%--------------------------------------------------------------------------
% Creation Date: July 2017
%
% Revision History:  
%
%==========================================================================

%------------------
% Check valid input
%------------------

params.fs = 1;
params.demodPhaseDeriv = 'center9';

params = parse_pv_pairs(params,varargin);


%-----------
% Initialize
%-----------

IF = zeros(size(PSI)); %allocate memeory space


%-----
% Main
%-----

for j= 1:size(PSI,2);                               %loop over each column in PSI
    THETA = unwrap(angle(PSI(:,j)));               %unwrap the phase function
    fi = derivApprox(THETA,params.fs,params.demodPhaseDeriv)./(2*pi);   %compute the instantaneous frequency in Hz
    IF(:,j) = fi(:);                                %store result as a column vector 
end                                                 %end loop over each column in PSI

A = abs(PSI);       %extract the instantaneous amplitude
S = real(PSI);      %extract the real signal part
SIGMA = imag(PSI);  %extract the imaginary signal part






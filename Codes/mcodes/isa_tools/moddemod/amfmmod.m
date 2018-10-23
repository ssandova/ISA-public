function [psi,s,sigma,fi,t,theta] = amfmmod(a,m,fc,fs,phi,method)
%==========================================================================
% Call Syntax: [psi,s,sigma,fi,t,theta] = amfmmod(a,m,fc,fs,phi,method)
%
% Description:  This function synthesizes an AM-FM component based on a specified instantaneous amplitude, FM message, frequency reference, sampling frequency, 
%               and phase reference. Additionally, there is an optional parameter to specify the method for integration approximation.
%
% Input Arguments:
%   Name: a
%   Type: vector
%   Description: instananeous amplitude
%
%   Name: m
%   Type: vector
%   Description: FM message
%
%   Name: fc
%   Type: scalar
%   Description: center freq (carrier)
%
%   Name: fs
%   Type: scalar
%   Description: sampling freq
%
%   Name: phi
%   Type: scalar
%   Description: phase reference
%
%   Name: method
%   Type: string
%   Description: numerical integration method: 'left' or 'right' or
%   'center' or 'trapz'[default] or 'simps'
%
% Output Arguments:
%   Name: psi
%   Type: vector (complex)
%   Description: AM-FM component
%
%   Name: s
%   Type: vector (real)
%   Description: real part of the AM-FM signal
%
%   Name: sigma
%   Type: vector (real)
%   Description: imaginary part of the AM-FM signal
%
%   Name: fi
%   Type: vector (real)
%   Description: instantaneous frequency of the AM-FM signal
%
%   Name: t
%   Type: vector (real)
%   Description: time instants
%
%   Name: theta
%   Type: vector (real)
%   Description: instantaneous angle of the AM-FM signal
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
%
% Notes:
%
%
% Function Dependencies:  intApprox.m
%
%--------------------------------------------------------------------------
% Author: Steven Sandoval
%--------------------------------------------------------------------------
% Creation Date: August 2012
%
% Revision History:  July 2017 (S.Sandoval) - Added numerical integration options
%
%==========================================================================

%------------------
% Check valid input
%------------------

a = a(:); %force column vector
m = m(:); %force column vector

if (nargin ~= 4)&&(nargin ~= 5)&&(nargin ~= 6)
    error('Error (amfmmod): must have 4 to 6 input arguments.');
end;

if (nargin <5)
    phi = 0;
end;

if (nargin <6)
    method = 'trapz';
end;

if length(a)~=length(m)
    error('Error (amfmmod): a and m must be of same length')
end


%-----------
% Initialize
%-----------
t = (0:length(m)-1)./fs;    %make time index
t = t(:);                   %force column vector


%-----
% Main
%-----

%SYNTHESIZE AM-FM COMPONENT
M = intApprox(m,fs,method);             %compute phase message from FM message
theta =  2*pi.*fc.*t + 2*pi.*M + phi;   %compute phase function
psi = a.*exp(1i*theta);                 %compute complex AM-FM component
s = real(psi);                          %extract real part of complex AM-FM component
sigma = imag(psi);                      %extract imaginary part of complex AM-FM component
fi = fc + m;                            %compute the instananeous frequency

%RESHAPE
psi = psi(:);
s = s(:);
fi = fi(:);
a = a(:);





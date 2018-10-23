function Y = derivApprox(X,fs,method) 
%==========================================================================
% Call Syntax: Y = derivApprox(X,fs,method)
%
% Description: This function estimates the approximate computation of a 
%              derivative using various mumerical techniques.  
%
% Input Arguments:
%   Name: X
%   Type: matrix (or vector)
%   Description:  the $k$th column is the $k$th signal
%
%   Name: fs (optional)
%   Type: scalar 
%   Description: sampling frequency [default = 1] 
%
%   Name: method (optional)
%   Type: string
%   Description: numerical differentiation method: 
%                   'forward'   - use the forward difference
%                   'backward'  - use the backward difference
%                   'center3'   - use the 3-pt stencil central difference 
%                   'center5'   - use the 5-pt stencil central difference 
%                   'center7'   - use the 7-pt stencil central difference 
%                   'center9'   - use the 9-pt stencil central difference 
%                   'center11'  - use the 11-pt stencil central difference 
%                   'center13'  - use the 13-pt stencil central difference 
%                   'center15'  - use the 15-pt stencil central difference [default]
%
% Output Arguments:
%   Name: Y
%   Type: matrix (or vector)
%   Description:  the $k$th column is the derivative estimate of the $k$th signal
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
% References: [1] http://www.holoborodko.com/pavel/numerical-methods/numerical-derivative/central-differences/
%             [2] http://web.media.mit.edu/~crtaylor/calculator.html
%
% Notes: See DEMO_derivApprox.m
%
%
% Function Dependencies:  
%
%--------------------------------------------------------------------------
% Author: Steven Sandoval
%--------------------------------------------------------------------------
% Creation Date: May 2017
%
% Revision History: 9-12-2017 S. Terrazas - update function call
%
%==========================================================================

%------------------
% Check valid input
%------------------

if nargin<3
    method = 'center15';
end

if nargin<2
    fs = 1;
end

if not(strcmp(method,'forward')||strcmp(method,'backward')||strcmp(method,'center3')||strcmp(method,'center5')||strcmp(method,'center7')||strcmp(method,'center9')||strcmp(method,'center11')||strcmp(method,'center13')||strcmp(method,'center15')) %check c11 c13 c15
    error('Error (derivApprox): invalid derivative method.')
end

%DEAL WITH MATRIX INPUT
rows=size(X,1);
cols=size(X,2);
if cols>1
    Y=zeros(rows, cols);
    for k=1:size(X,2)
        [Y(:,k)]=derivApprox(X(:,k), fs,method);
    end
    return
end



%-----------
% Initialize
%-----------


%-----
% Main
%-----

switch method
    case 'forward'
        Y = diff(X);
        Y = [NaN;Y];
    case 'backward'
        Y = diff(X);
        Y = [Y;NaN];
    case 'center3'
        Y =  ( X(3:end)-X(1:end-2) )./2;
        Y = [NaN;Y;NaN];
    case 'center5'
        Y = ( X(1:end-4)-8.*X(2:end-3)+8.*X(4:end-1)-X(5:end) )./12;
        Y = [NaN(2,1);Y;NaN(2,1)];
    case 'center7'
        Y = ( -X(1:end-6)+ 9.*X(2:end-5)- 45.*X(3:end-4) +45.*X(5:end-2) -9.*X(6:end-1) + X(7:end)   )./60;
        Y = [NaN(3,1);Y;NaN(3,1)];
    case 'center9'
        Y = (3.*X(1:end-8) - 32.*X(2:end-7) + 168.*X(3:end-6) -672.*X(4:end-5) + 672.*X(6:end-3) -168.*X(7:end-2) + 32.*X(8:end-1) -3.*X(9:end)  )./840;
        Y = [NaN(4,1);Y;NaN(4,1)];
    case 'center11'
        Y = (-2.*X(1:end-10) +25.*X(2:end-9) -150.*X(3:end-8) +600.*X(4:end-7) -2100.*X(5:end-6)         + 2100.*X(7:end-4)  -600.*X(8:end-3) +150.*X(9:end-2) -25.*X(10:end-1) +2.*X(11:end)  )./2520;
        Y = [NaN(5,1);Y;NaN(5,1)];
    case 'center13'
        Y = (5.*X(1:end-12) - 72.*X(2:end-11) + 495.*X(3:end-10) -2200.*X(4:end-9)   +7425.*X(5:end-8)  -23760.*X(6:end-7)                 +23760.*X(8:end-5)   + -7425.*X(9:end-4)   + 2200.*X(10:end-3) -495.*X(11:end-2) + 72.*X(12:end-1) -5.*X(13:end)  )./27720;
        Y = [NaN(6,1);Y;NaN(6,1)];
    case 'center15'
        Y = (-67553994410557440.*X(1:end-14) +1103381908705771500.*X(2:end-13) -8606378887905019000.*X(3:end-12) +43031894439525120000.*X(4:end-11) -157783612944925330000.*X(5:end-10)  + 473350838834776000000.*X(6:end-9)  -1.4200525165043282e21.*X(7:end-8)             +1.4200525165043282e21.*X(9:end-6)-473350838834776000000.*X(10:end-5)+157783612944925330000.*X(11:end-4)-43031894439525120000.*X(12:end-3)  +8606378887905019000.*X(13:end-2) -1103381908705771500.*X(14:end-1) +67553994410557440.*X(15:end)  )./1.622917161719232e21;
        Y = [NaN(7,1);Y;NaN(7,1)];
end
Y = Y.*fs;

end

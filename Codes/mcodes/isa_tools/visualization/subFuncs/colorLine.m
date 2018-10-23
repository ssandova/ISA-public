function hl = colorLine(x,y,z,c)
%==========================================================================
% Call Syntax: h1 = colorLine(x,y,z,c)
%
% Description: This function plots a line in a three dimentional space and
% importantly allows specification of line color at every point. 
%
% Input Arguments:
%	Name: x
%	Type: vector
%	Description: x-coordinates   
% 
%	Name: y
%	Type: vector
%	Description: y-coordinates  
%
%	Name: z
%	Type: vector
%	Description: z-coordinates   
%
%	Name: c
%	Type: vector
%	Description: number range representing color values 
% 
% Output Arguments:
%	Name: h1
%	Type: handle 
%	Description: figure handle 
%
%--------------------------------------------------------------------------
% If you use these files please cite the following:
%
%       @article{HSA2017,
%           title={The Hilbert Spectrum: A General Framework for Time-Frequency Analysis},
%           author={Sandoval, S. and De~Leon, P.~L.~},
%           journal={{IEEE Trans.~Signal Process.}},
%           year = {\noop{2017}in review},  }
%
%--------------------------------------------------------------------------
%
% References:
%
%
% Notes:
%
%
% Function Dependencies:  
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


x = x(:);
y = y(:);
z = z(:);
c = c(:);

epsilon = 1e-12;
hl = surf([x';x'+epsilon],[y';y'+epsilon],[z';z'+epsilon],[c';c'],'edgecol','interp');

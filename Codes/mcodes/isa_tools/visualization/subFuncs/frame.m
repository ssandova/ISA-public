function x_k = frame(x,win_func,frame_advance)
%==========================================================================
% Call Syntax: [ x_k ] = frame(x,win_func,frame_advance)
%
% Description: This function windows and frames the signal x, using the
% specified windowing function and frame advance
%
% Input Arguments:
%	Name: x
%	Type: vector (signal length x 1)
%	Description: signal to be windowed and framed
%
%	Name: win_func
%	Type: vector (window-length x 1)
%	Description: the desired windowing function 
%
%	Name: frame_advance
%	Type: scalar
%	Description: the frame advance in samples
%
% Output Arguments:
%	Name: x_k
%	Type: matrix (window length x number of frames)
%	Description: windowed and framed signal
%
% References:
%
%--------------------------------------------------------------------------
% Notes:
%
% 
%
%--------------------------------------------------------------------------
% Author: Steven Sandoval
%
% This code may have been derived from codes by Phillip De Leon or Laura E.
% Boucheron.
%
% Creation Date: June 2011
%
%--------------------------------------------------------------------------
% Revision History:
% 
%
%==========================================================================


%------------------
% Check valid input
%------------------
if (nargin ~= 3)
   error('Error (frame): must have 3 input arguments.');
end;

%-----------
% Initialize
%-----------
frame_length = length(win_func);
win_func = win_func(:);
x = x(:);
N = length(x);
x_k = zeros(frame_length,floor((N-frame_length)/frame_advance)+1);

%-----
% Main
%-----

%WINDOW SIGNAL
for k = 1:floor((N-frame_length)/frame_advance)+1
    x_k(:,k) = x((k-1)*frame_advance+1:(k-1)*frame_advance+frame_length).*win_func; % window signal
end

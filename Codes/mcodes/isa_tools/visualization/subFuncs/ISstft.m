function [X,x_k] = ISstft(x,win_func,frame_advance,fftLen)
%==========================================================================
% Function Call: [X,x_k] = ISstft(x,win_func,frame_advance,fftLen)
%
% Description: This function computes the short-time Fourier transform of a
% signal using a specifed windowing function and frame advance.
%
% Input Arguments:
%	Name: x
%	Type: vector (signal length x 1)
%	Description: time domain signal
%
%	Name: win_func
%	Type: vector (window-length x 1)
%	Description: the desired windowing function for STFT computation
%
%	Name: frame_advance
%	Type: scalar
%	Description: the frame advance in samples
%
%	Name: fftLen (optional)
%	Type: integer
%	Description: lenght of the fft
%
% Output Arguments:
%	Name: X
%	Type: matrix (window-length x number of frames)
%	Description: the short-time Fourier transfrom of x
%
%	Name: x_k
%	Type: matrix (window length x number of frames)
%	Description: windowed and framed signal
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
% [1] T. F. Quatieri, "Discrete-Time Speech Signal Processing Principles 
%  and Practice," Prentice Hall, 2002.  pp. 342-343
%
% Notes:
%
%
% Function Dependencies:  frame.m
%
%
%--------------------------------------------------------------------------
% Author: Steven Sandoval
%--------------------------------------------------------------------------
%
% Revision History:
%
%========================================================================== 

%------------------
% Check valid input
%------------------
if (nargin ~= 3)&&(nargin ~= 4)
   error('Error (ISstft): must have 3 or 4 input arguments.');
end;

%-----------
% Initialize
%-----------
frame_length = length(win_func);

if (nargin == 3)
    fftLen = frame_length;
end

%-----
% Main
%-----

x =  [     zeros(  floor(frame_length/(2)),1  );      x ;zeros(floor(frame_length/(2)),1)];

%FRAME AND WINDOW THE SIGNAL
x_k = frame(x,win_func,frame_advance);

%COMPUTE FFT OF EACH COLUMN
X = fft(x_k,fftLen);
%X = [     zeros(size(X,1)  ,  floor(frame_length/(2*frame_advance))  ),      X,zeros(size(X,1),floor(frame_length/(2*frame_advance)))];


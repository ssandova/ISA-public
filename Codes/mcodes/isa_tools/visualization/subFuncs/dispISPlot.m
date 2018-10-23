function dispISPlot(Ione,Itwo,S,IF,A,fs,fMax,t)
%==========================================================================
% Call Syntax: [ h ] = dispISPlot(Ione,Itwo,S,IF,A,fs,fMax,t)
%
% Description: This function generates a two dimensional instantaneous spectrum plot from the GUI environment
%
% Input Arguments:
%	Name: Ione
%	Type: matrix
%	Description: internal GUI variable 
% 
%	Name: Itwo
%	Type: matrix
%	Description: internal GUI variable
%
%	Name: S
%	Type: matrix
%	Description: each column is the real signal
%
%	Name: IF
%	Type: matrix
%	Description: each column is the inst. frequency corresponding to a
%	single component
%
%	Name: A
%	Type: matrix
%	Description: each column is the int amplitude corresponding to a single
%	component
%
%	Name: fs
%	Type: integer
%	Description: sampling frequency
%
%	Name: fMax
%	Type: vector
%	Description: maximum plotting frequency 
%
%	Name: t
%	Type: vector
%	Description: time vector
% 
% Output Arguments:
%	Name: h
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
% Function Dependencies:  ISplot.m
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

figure('color',[1,1,1]);hold on;
ISplot(S,IF,A,fs,fMax,t);
xlabel('Time (sec)','FontSize',16);
ylabel('Frequency (Hz)','FontSize',16);
%title('INSTANTANEOUS SPECTRUM','FontSize',16)
set(gca,'FontSize',16)



end

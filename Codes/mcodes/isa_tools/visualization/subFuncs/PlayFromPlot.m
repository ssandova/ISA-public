function PlayFromPlot(Ione,Itwo,S,fs)
%==========================================================================
% Function Call: PlayFromPlot(Ione,Itwo,S,fs)
%
% Description: This function plays audio corresponding to the signal from
% the GUI enviroment. Only applicable for real signal part with appropriate
% sampling rate. 
%
% Input Arguments:
%	Name: Ione
%	Type: 
%	Description: internal GUI variable 
% 
%	Name: Itwo
%	Type: 
%	Description: internal GUI variable
%
%	Name: S
%	Type: matrix
%	Description: each column is the real signal 
%
%	Name: fs
%	Type: integer
%	Description: sampling frequency
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
%
% Revision History:
%
%========================================================================== 
x = S./max(abs(S));
sound(x,fs);

% 
%  
% % frameRate = 15; %fps
% % frameT = 1/frameRate;
% % 
% % playHeadLoc = 0;
% % 
% % ax1 = plot3([playHeadLoc playHeadLoc], [a(3), a(4)], [a(6),a(6)], 'r', 'LineWidth', 3);
% % ax2 = plot3([playHeadLoc playHeadLoc], [a(3), a(3)], [a(5),a(6)], 'r', 'LineWidth', 3);
% % 
% % 
% player = audioplayer(x, fs);
% % myStruct.playHeadLoc = playHeadLoc;
% % myStruct.frameT = frameT;
% % myStruct.ax1 = ax1;
% % myStruct.ax2 = ax2;
% % 
% % set(player, 'UserData', myStruct);
% % set(player, 'TimerFcn', @apCallback);
% % set(player, 'TimerPeriod', frameT);
% % 
% playblocking(player);
% % 
% % set(ax1,'Visible','off');
% % set(ax2,'Visible','off');



















end

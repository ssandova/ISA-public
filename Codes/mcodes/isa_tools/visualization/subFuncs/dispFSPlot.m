function [ h ] = dispFSPlot(Ione,Itwo,X,fs,fMax,t)
%==========================================================================
% Call Syntax: [ h ] = dispFSPlot(Ione,Itwo,X,fs,fMax,t)
%
% Description: This function generates a short-time Fourier transform magnitude plot  from the GUI enviroment 
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
%	Name: X
%	Type: matrix
%	Description: 
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
% Function Dependencies:  pmkmp.m
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
if length(fMax)==1
    fMin = 0;
elseif    length(fMax)==2
    fMin = fMax(1);
    fMax = fMax(2);
end

figure('color',[1,1,1]); hold on
cmap = colormap(pmkmp(256));
colorimg = ind2rgb(round(X.*256),pmkmp(256));
imgzposition = 0;
surf( [t(1),t(end)], [fMin fMax], repmat(imgzposition, [2 2]), 'CData',colorimg,'facecolor','texturemap');

%surf(linspace(t(1),t(end),size(X,2)),fInd,X,'EdgeColor','none');
xlabel('Time (sec)','FontSize',16); 
ylabel('Frequency (Hz)','FontSize',16);
    set(gca,'FontSize',16)

%title('SHORT-TIME FOURIER SPECTRUM')
view([0,90]);
axis([t(1),t(end),fMin ,fMax]);


MaxVal = max(max(abs(X)));

box off
set(gca,'TickLength',[0,0])

a = axis;
epsilon1 = (a(2)-a(1))/1000;
epsilon2 = (a(4)-a(3))/1000;
plot3([a(1)+epsilon1,a(1)+epsilon1],[a(3),a(4)],[MaxVal-1e-3,MaxVal-1e-3],'k')
plot3([a(2)-epsilon1,a(2)-epsilon1],[a(3),a(4)],[MaxVal-1e-3,MaxVal-1e-3],'k')
plot3([a(1),a(2)],[a(3)+epsilon2,a(3)+epsilon2],[MaxVal-1e-3,MaxVal-1e-3],'k')
plot3([a(1),a(2)],[a(4)-epsilon2,a(4)-epsilon2],[MaxVal-1e-3,MaxVal-1e-3],'k')


end

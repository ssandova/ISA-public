function h=dispAMPPlot(Ione,Itwo,t,A)
%==========================================================================
% Call Syntax: [h]=dispAMPPlot(Ione,Itwo,t,A)
%
% Description: This function generates a plot of the instantaneous amplitudes for each signal component  from the GUI environment 
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
%	Name: t
%	Type: vector
%	Description: time vector 
%
%	Name: A
%	Type: matrix
%	Description: matrix of inst. amplitudes  
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
% Note:
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
figure();hold on;
plotHands = plot(t,A,'LineSmoothing','on','LineWidth',1);
axis tight;
xlabel('time (sec)')
grid on;
title(' ','FontSize',14,'Interpreter','latex','string','$a_k(t) = |\psi_k(t)|$')
H.Rleg = legend(plotHands,strtrim(cellstr(num2str((0:size(A,2)-1)'))'),'box','off');
set(H.Rleg,'Visible','off');
h.cb = uicontrol('Style','checkbox',...
    'String','Legend','Value',0,...
    'units','normalized','Position',[0.93 .4 1/32 1/32],...
    'callback',{@ToggleLegend,H.Rleg});
set(gcf,'toolbar','figure');
set(gcf,'menubar','figure');


end



function h = ToggleLegend(hObject,eventdata,H2)

if get(hObject,'Value')
    set(H2,'Visible','on');
else
    set(H2,'Visible','off');
end

end

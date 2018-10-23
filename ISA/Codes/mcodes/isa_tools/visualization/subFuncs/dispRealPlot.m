function h=dispRealPlot(Ione,Itwo,t,S,fs)
%==========================================================================
% Call Syntax: [ h ] = dispRealPlot(Ione,Itwo,t,S,fs)
%
% Description: This function generates a figure showing the real part
% of the signal as well as the real part of its components from the GUI
% enviroment.
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
%	Description: time vector index 
%
%	Name: S
%	Type: matrix
%	Description: matrix of IMF modes (each as a column vector), with
%	residual on last column
%
%	Name: fs
%	Type: integer
%	Description: sampling frequency
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

if min(size (S))==1
    figure();hold on;
    plot(t,sum(S,2),'color',rgb('Purple'),'LineSmoothing','on','LineWidth',1)
    axis tight;
    a = axis;
    axis([a(1),a(2),1.15*a(3),1.15*a(4)])
    xlabel('time (sec)')
    title(' ','FontSize',14,'Interpreter','latex','string','$x(t) = \Re\left\lbrace \psi(t)\right\rbrace$')
    grid on;
else
    h.fig = figure();
    
    h.sp(1) = subplot(2,1,1);
    hold on;
    plot(t,sum(S,2),'color',rgb('Purple'),'LineSmoothing','on','LineWidth',1)
    axis tight;
    a1 = axis;
    xlabel('time (sec)')
    title(' ','FontSize',14,'Interpreter','latex','string','$x(t) = \sum\limits_{k=0}^{K-1} s_k(t)$')
    grid on;
    
    h.sp(2) = subplot(2,1,2);
    hold on;
    plotHands = plot(t,S,'LineSmoothing','on','LineWidth',1);
    axis tight;
    a2 = axis;
    xlabel('time (sec)')
    title(' ','FontSize',14,'Interpreter','latex','string','$s_k(t)$')
    grid on;
    H.Rleg = legend(plotHands,strtrim(cellstr(num2str((0:size(S,2)-1)'))'),'box','off');
    set(H.Rleg,'Visible','off');
        
    subplot(2,1,1);
    axis([min([a1(1),a2(1)]),max([a1(2),a2(2)]),1.15*min([a1(3),a2(3)]),1.15*max([a1(4),a2(4)])])
    subplot(2,1,2);
    axis([min([a1(1),a2(1)]),max([a1(2),a2(2)]),1.15*min([a1(3),a2(3)]),1.15*max([a1(4),a2(4)])])
    linkaxes(h.sp)
end




h.b1_p = uicontrol('Parent',gcf,'String','Play','units','normalized','BusyAction','cancel','Interruptible','off',...
    'Position',[.93 .7 1/16 0.05]);
set(h.b1_p,'callback',{@PlayFromPlot,sum(S,2),fs,[]})



if size(S,2)>1
    
    h.st1 = uicontrol('Style','text',...
        'String',num2str(0),...
        'units','normalized','Position',[0.93 .35 1/16 0.03]   );
    h.sl1 = uicontrol('Style','slider','Min',1,'Max',size(S,2),...
        'SliderStep',[1 1]./(size(S,2)-1),'Value',1,...
        'units','normalized','Position',[0.93 .32 1/16 0.025], 'Callback', {@SliderText,h.st1});
    
    h.st2 = uicontrol('Style','text',...
        'String',num2str(size(S,2)-1),...
        'units','normalized','Position',[.93 .25 1/16 0.03]   );
    h.sl2 = uicontrol('Style','slider','Min',1,'Max',size(S,2),...
        'SliderStep',[1 1]./(size(S,2)-1),'Value',size(S,2),...
        'units','normalized','Position',[.93 .22 1/16 0.025], 'Callback', {@SliderText,h.st2});
    
    h.b2_p = uicontrol('Parent',gcf,'String','Play','units','normalized','BusyAction','cancel','Interruptible','off',...
        'Position',[0.93 .13 1/16 0.05],'callback',{@PlayComponents,S,fs,h.sl1,h.sl2});
    
    
   
    
    h.cb = uicontrol('Style','checkbox',...
                'String','Legend','Value',0,...
                'units','normalized','Position',[0.93 .4 1/32 1/32],...
                'callback',{@ToggleLegend,H.Rleg});
     
end

set(gcf,'toolbar','figure');
set(gcf,'menubar','figure');


end

function SliderText(hObj,event,Htext)
Value = round(get(hObj,'Value'));
set(Htext,'String',num2str(Value-1));
end

function PlayComponents(Ione,Itwo,S,fs,H1,H2)
S = S(:, min([get(H1,'Value'),get(H2,'Value')]):max([get(H1,'Value'),get(H2,'Value')]) );
S = sum(S,2);
x = S./max(abs(S));
sound(x,fs);
end



function h = ToggleLegend(hObject,eventdata,H2)

    if get(hObject,'Value') 
        set(H2,'Visible','on');
        %legend boxoff;
    else
        set(H2,'Visible','off');
    end

end









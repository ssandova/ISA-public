function  h = ISplot(S,IF,A,fs,fMax,t)
%==========================================================================
% Function Call: [h] = ISplot(S,IF,A,fs,fMax,t)
%
% Description: This function generates a two dimensional instantaneous
% spectrum plot
%
% Input Arguments:
%	Name: S
%	Type: matrix
%	Description: each column is the real signal
%
%	Name: IF
%	Type: matix
%	Description: each column is the inst. frequency corresponding to a single component
%
%	Name: A
%	Type: matrix
%	Description: each column is the int amplitude corresponding to a single component 
%
%	Name: fMax 
%	Type: vector
%	Description: maximum plotting frequency 
%
%	Name: t
%	Type: integer
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
% Function Dependencies:  
%
%--------------------------------------------------------------------------
% Author: Steven Sandoval
%--------------------------------------------------------------------------
%
% Revision History:
%
%========================================================================== 




if nargin<6;
    timInd = [1:size(IF,1);1:size(IF,1)];
    if nargin<5
        lims = [1,size(A,1),0,0.5];
    else
        lims = [1,size(A,1),0,fMax];
    end
    xlabel('time (samples)','FontSize',16)
else
    timInd = t';
    if nargin<5
        lims = [t(1),t(end),0,0.5];
    else
        if length(fMax)==1
            fMin = 0;
        elseif    length(fMax)==2
            fMin = fMax(1);
            fMax = fMax(2);
        end
        lims = [t(1),t(end),fMin,fMax];
    end
    xlabel('time (sec)','FontSize',16)
end;







%figure('units','normalized','position',[0,0,1,1]);hold on;
cmap = pmkmp(256);
colormap(cmap);


for j = 1:size(A,2)
    h.l(j) = colorLine(timInd,IF(:,j)',S(:,j),abs(A(:,j))');
    set(h.l(j),'LineSmoothing','on','EdgeAlpha',0.9,'FaceAlpha',0.9,'LineWidth',0.9)
end
set(gca,'color',cmap(1,:));
axis tight;
axis(lims)
a = axis;
amin = min(min(S))-1e-3;
h.p1 = patch([a(1),a(1),a(2),a(2)],[a(3),a(4),a(4),a(3)],[amin,amin,amin,amin],cmap(1,:),'EdgeColor',cmap(1,:),'EdgeAlpha',.1);


MaxVal = max(max(A));
caxis([0,MaxVal])

box off
set(gca,'TickLength',[0,0])

a = axis;
epsilon1 = (a(2)-a(1))/1000;
epsilon2 = (a(4)-a(3))/1000;
plot3([a(1)+epsilon1,a(1)+epsilon1],[a(3),a(4)],[MaxVal-1e-3,MaxVal-1e-3],'k')
plot3([a(2)-epsilon1,a(2)-epsilon1],[a(3),a(4)],[MaxVal-1e-3,MaxVal-1e-3],'k')
plot3([a(1),a(2)],[a(3)+epsilon2,a(3)+epsilon2],[MaxVal-1e-3,MaxVal-1e-3],'k')
plot3([a(1),a(2)],[a(4)-epsilon2,a(4)-epsilon2],[MaxVal-1e-3,MaxVal-1e-3],'k')





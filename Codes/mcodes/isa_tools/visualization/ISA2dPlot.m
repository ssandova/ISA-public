function h = ISA2dPlot(t,S,IF,A,fs,fMax)
%==========================================================================
% Call Syntax:  h = ISA2dPlot(t,S,IF,A,fs,fMax)
%
% Description: This function plots an instantenous spectrum.
%
% Input Arguments:
%   Name: t
%   Type: vector (real)
%   Description: time instants
%
%   Name: S
%   Type: real matrix (or vector)
%   Description: the $k$th column is the real part of $\psi_k(t)$
%
%   Name: IF
%   Type: real matrix (or vector)
%   Description: the $k$th column is the IF of $\psi_k(t)$
%
%   Name: A
%   Type: real matrix (or vector)
%   Description: the $k$th column is the IA of $\psi_k(t)$
%
%	Name: fs
%	Type: scalar
%	Description: sampling freq
%
%	Name: fMax or [fMax,fMin](optional)
%	Type: scalar or [scalar,scalar]
%	Description: maximum plotting frequency and optionally the minimum plotting frequency
%
% Output Arguments:
%
%	Name: h
%	Type: handle
%	Description: figure handle
%
%--------------------------------------------------------------------------
%
% If you use these files please cite the following:
%
%       @article{ISA2018_Sandoval,
%           title = {The Instantaneous Spectrum: A General Framework for Time-Frequency Analysis},
%           author = {S.~Sandoval and P.~L.~De~Leon},
%           journal = {{IEEE Trans.~Signal Process.}},
%           volume = {61},
%           number = {16},
%           year = {2018},
%           month = {Nov},
%           pages = {5679-?5693} 
%       }
%
%--------------------------------------------------------------------------
%
% References:
%
% Notes:
%
%
%
%--------------------------------------------------------------------------
% Author: Steven Sandoval
%--------------------------------------------------------------------------
% Revision History:
%
%
%--------------------------------------------------------------------------
%
%   History:    V1.00 (S.Sandoval)
%
% WARNING: This software is a result of our research work and is supplied without any guaranties.
%          We would like to receive comments on the results and report on bugs.
%
%==========================================================================   

h = figure('color',[1,1,1]);hold on;
if iscell(t)
    for c = 1:length(t)
        if not(isempty(S{c}))
            ISplot(abs(S{c}),IF{c},A{c},fs,fMax,t{c});
        end
    end
    tMin = min([t{:}]);
    tMax = max([t{:}]);
    if length(fMax)==1
        fMin = 0;
    elseif    length(fMax)==2
        fMin = fMax(1);
        fMax = fMax(2);
    end
    lims = [tMin,tMax,fMin,fMax];
    axis(lims);
else
    ISplot(abs(S),IF,A,fs,fMax,t);
end
xlabel('Time (sec)','FontSize',14);
ylabel('Frequency (Hz)','FontSize',14);
set(gca,'FontSize',14)
%set(gcf,'units','normalized','outerposition',[0 0 1 1])
drawnow;






end




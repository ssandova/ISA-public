function h = STFT2dPlot(z,fs,fMax,STFTparams)
%==========================================================================
% Call Syntax:  h = STFT2dPlot(z,fs,fMax,STFTparams)
%
% Description: This function plots the short-time Fourier transform
% magnitude using a Hamming window.
%
% Input Arguments:
%	Name: z
%   Type: vector
%   Description: complex signal
%
%	Name: fs
%	Type: scalar
%	Description: sampling freq
%
%	Name: fMax or [fMax,fMin](optional)
%	Type: scalar or [scalar,scalar]
%	Description: maximum plotting frequency and optionally the minimum plotting frequency
%
%	Name: STFTparams (optional)
%	Type: vector (1x2)
%	Description: STFT parameters: [N_FFT,frame_advance]
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
%           volume = {66},
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

if nargin<4
    STFTparams(1) = 1024;
    STFTparams(2) = 4;
    STFTparams(3) = 1024;
end

if length(STFTparams) < 3
    STFTparams(3) = STFTparams(1);
end


if length(fMax)==1
    fMin = 0;
elseif    length(fMax)==2
    fMin = fMax(1);
    fMax = fMax(2);
end


t = ((1:length(z))-1)./fs;
X = ISstft(z,hamming(STFTparams(1)),STFTparams(2),STFTparams(3));

fInd = (0:size(X,1)-1)./(size(X,1)-1).*fs;
if fMin==0
    planeimg = abs(X(fInd<=fMax,:));
else 
    fInd(fInd>fs/2) = fInd(fInd>fs/2)-fs;
    planeimg = abs(X(  (fInd<=fMax)&(fInd>=fMin)  ,:));
    planeimg = fftshift(planeimg,1);
end
planeimg = planeimg./max(max(abs(planeimg)));
dispFSPlot([],[],planeimg,fs,[fMin,fMax],t)
xlabel('Time (sec)','FontSize',14);
ylabel('Frequency (Hz)','FontSize',14);
set(gca,'FontSize',14)
%set(gcf,'units','normalized','outerposition',[0 0 1 1])
drawnow;



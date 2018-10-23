function changeview(hObject,eventdata,h,v,home)
%==========================================================================
% Call Syntax: h = changeview(hObject,eventdata,h,v,home) 
%
% Description: This function changes the view for the GUI enviroment. 
%
% Input Arguments:
%	Name: hObject
%	Type: 
%	Description:  internal GUI variable
% 
%	Name: eventdata
%	Type: 
%	Description:  internal GUI variable
%
%	Name: h
%	Type: handle
%	Description: internal GUI variable
%
%	Name: v
%	Type:
%	Description:  internal GUI variable
% 
%	Name: home
%	Type: 
%	Description:  internal GUI variable
%
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

[AZ,EL] = view; %get current view
N = 15;

if v ==[AZ,EL]
    %do nothing
elseif v==home
    
    ang1 = linspace(AZ, v(1), N);
    ang2 = linspace(EL, v(2), N);
    for i = 1:N
        view([ang1(i),ang2(i)]) ;
        drawnow;
    end
else
    ang1 = linspace(AZ, home(1), N);
    ang2 = linspace(EL, home(2), N);
    for i = 1:N
        view([ang1(i),ang2(i)]) ;
        drawnow;
    end
    ang1 = linspace(home(1), v(1), N);
    ang2 = linspace(home(2), v(2), N);
    for i = 1:N
        view([ang1(i),ang2(i)]) ;
        drawnow;
    end
    
end


%view(v)

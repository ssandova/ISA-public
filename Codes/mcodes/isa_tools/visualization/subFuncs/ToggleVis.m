function  ToggleVis(hObject,eventdata,h,hObj)
%==========================================================================
% Function Call: ToggleVis(hObject,eventdata,h,hObj)
%
% Description: This function toggles the visibility of an object in the GUI
% environment.
%
% Input Arguments:
%	Name: hObject
%	Type: 
%	Description: internal GUI variable
%
%	Name: eventdata
%	Type: 
%	Description: internal GUI variable
%
%	Name: h
%	Type: handle
%	Description: internal GUI variable
%
%	Name: hObj 
%	Type: handle
%	Description: internal GUI variable 
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
%
% Revision History:
%
%========================================================================== 

try
    if strcmp(get(hObj(1),'Visible'),'off')
        set(hObj,'Visible','on');
    else
        set(hObj,'Visible','off');
    end
catch
    if strcmp(get(hObj,'Visible'),'off')
        set(hObj,'Visible','on');
    else
        set(hObj,'Visible','off');
    end
end

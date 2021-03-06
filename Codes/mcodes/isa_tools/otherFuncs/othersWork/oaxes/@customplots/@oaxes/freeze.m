function freeze(OA)
% Disable listeners attached to parent axes and oaxes properties to prevent
% the oaxes from updating in response to changes in the parent axes or
% oaxes properties.

% $$FileInfo
% $Filename: freeze.m
% $Path: $toolboxroot/@customplots/@oaxes
% $Product Name: oaxes
% $Product Release: 2.4
% $Revision: 2
% $Toolbox Name: Custom Plots Toolbox
% $$
%
% Copyright (c) 2010-2012 John Barber.
%

%%

OA.ListenersEnabled = 'off';

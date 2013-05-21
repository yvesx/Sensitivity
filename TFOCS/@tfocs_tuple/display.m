function display( x )

% DISPLAY	Automatic display.

long = ~isequal(get(0,'FormatSpacing'),'compact');
if long, disp( ' ' ); end
disp([inputname(1) ' =']);
if long, disp( ' ' ); end
disp(x,'    ',inputname(1))
if long, disp( ' ' ); end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

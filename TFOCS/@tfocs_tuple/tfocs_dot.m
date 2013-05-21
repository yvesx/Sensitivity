function v = tfocs_dot( x, y )

% TFOCS_DOT    Dot products.

if isempty( x ) || isempty( y ),
	v = 0;
else
	v = sum( cellfun( @tfocs_dot, x.value_, y.value_ ) );
end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

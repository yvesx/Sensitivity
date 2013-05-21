function y = times( x, y )

% TIMES   Multiplication. Multiplication by scalars only.

if isnumeric( y ),
	y = times( y, x );
elseif ~isnumeric( x ) || ~isscalar( x ),
	error( 'Multiplication by scalars only.' );
elseif x == 0,
	y = packSVD( y.sz(1), y.sz(2) );
else
	y.s = x * y.s;
	y.X = x * y.X;
end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

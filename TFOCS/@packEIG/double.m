function v = double( x )

% DOUBLE   Conversion to double.

m = x.sz(1);
n = x.sz(2);

% Sparse portion
if isempty( x.X ),
	v = zeros(m,n);
else
	v = x.X;
end

% Low-rank portion
if ~isempty( x.s ),
	if v.sz(1) < v.sz(2),
		v = v + bsxfun( @times, x.U, x.s' ) * x.V';
	else
		v = v + x.U * bsxfun( @times, x.V, x.s' )';
	end
end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.




function x = plus( x, y )

% PLUS   Addition.

x = packSVD( x );
y = packSVD( y );
if isempty( x.X ),
	x.X = y.X;
elseif ~isempty( y.X ),
	x.X = x.X + y.X;
end
if ~isempty( x.s ),
	if ~isnumeric( y ) && ~isempty( y.s ),
		x.s = [ x.s, y.s ];
		x.U = [ x.U, y.U ];
		x.V = [ x.V, y.V ];
		x.orth = false;
	end
else
	if ~isnumeric( y ) && ~isempty( y.s ),
		x.s = y.s; x.U = y.U; x.V = y.V;
		x.orth = y.orth;
	end		
end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

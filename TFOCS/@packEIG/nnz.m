function v = nnz( x )

% NNZ   Number of possible nonzeros.

if ~isempty( x.s ),
	v = prod( x.sz );
else
	v = nnz( x.X );
end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

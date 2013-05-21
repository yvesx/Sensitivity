function v = tfocs_normsq( x )

% TFOCS_NORMSQ    Squared norm. By default, TFOCS_NORMSQ(X) is equal
%                 to TFOCS_NORMSQ(X,X), and this numerical equivalence
%                 must be preserved. However, an object may overload
%                 TFOCS_NORMSQ to compute its value more efficiently.

v = sum( cellfun( @tfocs_normsq, x.value_ ) );

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

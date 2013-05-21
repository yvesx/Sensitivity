function x = svd_shrink( x, thresh )

% SVD_SHRINK   SVD with shrinkage.

[s,U,V] = svd(x);
s       = s - thresh;
tt      = s <= 0;
s(:,tt) = [];
U(:,tt) = [];
V(:,tt) = [];
x = packSVD( s, U, V );
x.orth = true;

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

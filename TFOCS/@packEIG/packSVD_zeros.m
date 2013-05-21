function z = packSVD_zeros( x )
% PACKSVD_ZEROS( X )
%   returns an all-zero object of the same type and size as X

%function z = tfocs_zeros( x )
% TFOCS_ZEROS( X )
%   returns an all-zero object of the same type and size as X

% call the class selector:
z = packSVD( x.sz(1), x.sz(2) );

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

function v = size( x )

% SIZE   Size.

v = cellfun( @size, x.value_, 'UniformOutput', false );

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

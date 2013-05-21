function x = power( x, y )

% POWER     Matrix power, z = x.^y

if isa(y,'tfocs_tuple')
	x.value_ = cellfun( @power, x.value_, y.value_, 'UniformOutput', false );
elseif isscalar(y)
	x.value_ = cellfun( @power, x.value_, {y}, 'UniformOutput', false );
else 
	x.value_ = cellfun( @power, x.value_, {y}, 'UniformOutput', false );
end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

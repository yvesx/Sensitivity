function op = prox_l1pos( q )
%PROX_L1POS    L1 norm, restricted to x >= 0
%    OP = PROX_L1( q ) implements the nonsmooth function
%        OP(X) = norm(q.*X,1) + indicator_{ X >= 0 }
%    Q is optional; if omitted, Q=1 is assumed. But if Q is supplied,
%    then it must be a positive real scalar (or must be same size as X).

% New in v1.0d

if nargin == 0,
	q = 1;
elseif ~isnumeric( q ) || ~isreal( q ) ||  any( q < 0 ) || all(q==0) %|| numel( q ) ~= 1
	error( 'Argument must be positive.' );
end

op = tfocs_prox( @f, @prox_f );

function v = f(x)
    if any( x(:) < 0 )
        v = Inf;
    elseif isscalar(q)
        v = q*sum( x(:) );
    else
        v = sum( q(:).*x(:) );
    end
end

% The proximity operator is a simplified version of shrinkage:
function x = prox_f(x,t)  
    x   = max( 0, x - t*q );
end


end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

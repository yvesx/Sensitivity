function op = prox_hingeDual( q , r, y)

%PROX_HINGEDUAL    Dual function of the Hinge-loss function.
%    OP = PROX_HINGEDUAL( q , r , y) implements the nonsmooth function
%        that is dual to the Hinge-loss function f, where 
%        f(x) = q * sum( max( r - y.*x, 0 ) ).
%    Q is optional; if omitted, Q=1 is assumed. But if Q is supplied,
%    then it must be a positive real scalar.
%    R is also optional; if omitted, R = 1 is assumed. R may be any real scalar.
%
%   There is a simple form for the dual and its proximity operator.
%   In the case q = r = 1, the dual is:
%       f^*(y) = { +y, if y >= -1 and y <= 0
%                { +Inf, otherwise
%
% See also PROX_HINGE
%
%   Note: if the primal is PROX_HINGE( q, r, y )
%       then TFOCS expects conjnegF to be PROX_HINGEDUAL( q, r, -y)
%       (the -y is because the conjugate should be composed
%        with the function x --> -x )

if nargin < 3
    y = [];
elseif ~isempty(y) && ( ~isnumeric(y) || ~isreal(y) )
    error( 'Argument 3 must be a real vector');
end
if nargin < 2
	r = 1;
elseif ~isnumeric( r ) || ~isreal( r ) %|| numel( r ) ~= 1
	error( 'Argument must be real.' );
end
if nargin < 1
	q = 1;
elseif ~isnumeric( q ) || ~isreal( q ) || numel( q ) ~= 1 || q <= 0,
	error( 'Argument must be positive.' );
end

if isempty(y)
    if isscalar(r)
        sumXR = @(x) r*sum(x);
    else
        sumXR = @(x) x'*r;
    end
    op = tfocs_prox( @hingeDual, @prox_hingeDual );
else
    ry  = r./y;
    qy  = -q.*abs(y);
    sy  = sign(y);
    if isscalar(r) && isscalar( y )
        sumXR = @(x) ry*sum(x);
    else
        sumXR = @(x) x'*ry;
    end
    op = tfocs_prox( @hingeDualY, @prox_hingeDualY );
end


function v = hingeDual(x)
    feasible = ( x >= -q & x <= 0 );
    if any( ~feasible )
        v = Inf;
        return;
    end
%     v = sum( x*r );
    v = sumXR( x );
%     v = sum( x*r.*( feasible ) + Inf.*( ~feasible ) );  % 0*Inf leads to NaN. bad!
end

function v = hingeDualY(x)
%     feasible = ( sign(y).*x >= -q.*abs(y) & sign(y).*x <= 0 );
    feasible = ( sy.*x >= qy & sy.*x <= 0 ); % using precomputed vectors
    if any( ~feasible )
        v = Inf;
        return;
    end
%     v = sum( x.*ry );
    v = sumXR(x);
end


%   PROX_F( Y, t ) = argmin_X  F(X) + 1/(2*t)*|| X - Y ||^2
function x = prox_hingeDual(x,t)  
    x = max( min( x - t*r, 0), -q );
end
function x = prox_hingeDualY(x,t)  
    x = sy.*max( min( sy.*(x - t*ry), 0), qy );
end


end

% Added Feb, 2011; support for y added Dec 2011

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

function op = proj_psdUTrace( q )

%PROJ_PSDUTRACE Projection onto the positive semidefinite cone with fixed trace.
%    OP = PROJ_PSDUTRACE( q ) returns a function that implements the
%    indicator for the cone of positive semidefinite (PSD) matrices with
%    fixed trace: { X | min(eig(X+X'))>=0, trace(0.5*(X+X'))<=q
%    Q is optional; if omitted, Q=1 is assumed. But if Q is supplied, 
%    it must be a positive real scalar. 
%
% This version uses a dense eigenvalue decomposition; future versions
% of TFOCS will take advantage of low-rank and/or sparse structure.
%
% If the input to the operator is a vector of size n^2 x 1, it will
% be automatically reshaped to a n x n matrix. In this case,
% the output will also be of length n^2 x 1 and not n x n.
%
% Note: proj_simplex.m (the vector-analog of this function)
% Duals: the dual function is prox_maxEig, which also requires
%   PSD inputs. The function prox_spectral(q,'sym') is also equivalent
%   to prox_maxEig if given a PSD input.
% See also prox_maxEig, prox_spectral, proj_simplex

if nargin == 0,
	q = 1;
elseif ~isnumeric( q ) || ~isreal( q ) || numel( q ) ~= 1 || q <= 0,
	error( 'Argument must be positive.' );
end
q = proj_simplex( q );
%op = @(x,t)proj_psdUTrace_q( q, x, t );
op = @(varargin)proj_psdUTrace_q( q, varargin{:} );

function [ v, X ] = proj_psdUTrace_q( eproj, X, t )

VECTORIZE   = false;
if size(X,1) ~= size(X,2)
    %error('proj_psdUTrace requires a square matrix as input');
    n = sqrt(length(X));
    X = reshape(X, n, n );
    VECTORIZE   = true;
end
v = 0;
X = full(0.5*(X+X')); % added 'full' Sept 5 2012
if nargin > 2 && t > 0,
    [V,D]=eig(X);
    [dum,D] = eproj(diag(D),t);
    tt = D > 0;
    V  = bsxfun(@times,V(:,tt),sqrt(D(tt,:))');
    X  = V * V';
    if VECTORIZE, X = X(:); end
elseif any(eig(X)<0),
    v = Inf;
end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.


function [ varargout ] = svd( x, flag )
% s = SVD( X )
% [U,S,V] = SVD( X )
% ... = SVD( X, 'econ' )
%   
% Note: the 'econ' flag is always in effect, so is not
%   necessary (but this function will accept it,
%   in order to mimick the functionality of Matlab's
%   builtin SVD ).
%
% See also svd


%function [ s, U, V ] = svd( x )

% Stephen's comments:
%   since we are overloading this, I think we need to follow
%   Matlab's conventions for their svd function.
%   In particular, output is either S = ... or [U,S,V] = ...
%   and not [S,U,V] = ...
% Also, we should make S either a vector or diagonal matrix
%   in the same way that svd does
%   (e.g. S = ... is a vector, [U,S,V] = ... means S is a diagonal
%       matrix ).

% SVD   SVD.

if x.orth && issparse( x.X ) && ~nnz( x.X ),

    s = abs( x.s );
    if nargout > 1,
	    U = x.U; 
    	V = conj(x.V);
    	if ( ~isreal( s ) || any( s < 0 ) ),
    		if x.sz(1) < x.sz(2),
	        	U = bsxfun( @times, U, x.s ./ s );
	        else
		        V = bsxfun( @times, V, x.s ./ s );
			end
		end	
    end
    
elseif nargout == 1,

    % we can as for 'econ' here, can't we??
	%s = svd(full(double(x)));
	s = svd(full(double(x)),'econ');
	
else	

    [U,s,V] = svd(full(double(x)),'econ');
    s  = diag(s)';
    tt = s == 0;
    if any(tt),
    	s(:,tt) = [];
    	U(:,tt) = [];
    	V(:,tt) = [];
	end
	
end

if nargout >= 2
    varargout{1} = U;
    varargout{2} = diag(s);
    if nargout >= 3
        varargout{3} = V;
    end
else
    varargout{1} = s;
end


% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

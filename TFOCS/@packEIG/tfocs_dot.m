function v = tfocs_dot( x, y )

% TFOCS_DOT Inner product.

if isnumeric( y ),
    if isnumeric( x ),
        v = tfocs_dot( x, y );
    elseif isempty( x.s ),
        v = tfocs_dot( x.X, y );
    else
        v = tfocs_dot( x.X, y ) + dotXUSV( y, x.U, x.s, x.V );
    end
elseif isempty( y.s ),
    if isnumeric( x ),
        v = tfocs_dot( x, y.X );
    elseif isempty( y.s ),
        v = tfocs_dot( x.X, y.X );
    else
        v = tfocs_dot( x.X, y.X ) + dotXUSV( y.X, x.U, x.s, x.V );
    end
elseif isnumeric( x ),
    v = tfocs_dot( x, y.X ) + dotXUSV( x, y.U, y.s, y.V );
elseif isempty( x.s ),
    v = tfocs_dot( x.X, y.X ) + dotXUSV( x.X, y.U, y.s, y.V );
else
    v = tfocs_dot( x.X, y.X ) + ...
	    dotXUSV( y.X, x.U, x.s, x.V ) + ...
	    dotXUSV( x.X, y.U, y.s, y.V );
	if ~isempty( x.s ) && ~isempty( y.s ),
		S1V1V2 = bsxfun( @times, x.s', x.V', y.V );
		U1U2S2 = bsxfun( @times, x.U' * y.U, y.s );
		v = v + real( S1V1V2(:)' * U1U2S2(:) );
	end
end

function v = dotXUSV( X, U, s, V )
X = double(X);
if isempty(X) || isempty(s),
	v = 0;
else	
	XU = X' * U;
	VS = bsxfun( @times, V, s );
	v = real(XU(:))' * real(VS(:));
    if ~isreal(XU) && ~isreal(VS),
        v = v + imag(XU(:))' * imag(VS(:));
    end
end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

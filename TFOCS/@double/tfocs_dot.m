function v = tfocs_dot( x, y )
% TFOCS_DOT   Dot product <x,y>.  Returns real(x'*y)
%   For matrices, this is the inner product that induces the Frobenius
%   norm, i.e. <x,y> = tr(x'*y), and not matrix multiplication.

% Note: this is real(x'*y) and not real(x.'*y)


% Allow scalar times vector multiplies:
if isscalar(x) && ~isscalar(y)
    if ~x, 
        v = 0; 
        return;
    else
        x = repmat(x,size(y,1),size(y,2) ); % doesn't work if y is a cell
    end
elseif isscalar(y) && ~isscalar(x)
    if ~y
        v = 0;
        return;
    else
        y = repmat(y,size(x,1),size(x,2) );
    end
end


if isempty( x ) || isempty( y ),
    v = 0;
elseif isreal( x ) || isreal( y ),
    if issparse( x ) || issparse( y ),
        v = sum( nonzeros( real(x) .* real(y) ) );
    else
        if size(x,2) == 1 && size(y,2) == 1 && isreal(x) && isreal(y)
            v = sum( x'*y );
        else
            v = sum( real(x(:))' * real(y(:)) );  % why the "sum" ?
        end
    end
else
    if issparse( x ) || issparse( y ),
        v = sum( nonzeros( real(x) .* real(y) ) ) + ...
            sum( nonzeros( imag(x) .* imag(y) ) );
    else
        % SRB: this is very slow:
%         v = sum( real(x(:))' * real(y(:)) ) + ...
%             sum( imag(x(:))' * imag(y(:)) );
        if size(x,2) == 1 && size(y,2) == 1
            v = sum(real(   x'*y ) );
        else
            v = sum(real(   x(:)'*y(:) ) );
        end
    end
end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.
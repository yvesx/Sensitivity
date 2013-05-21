function v = tfocs_normsq( x )

% TFOCS_NORMSQ   Squared Euclidean norm
%   For matrices, this is squared Frobenius norm

if ~isempty( x.s ),
    if x.orth,
   		% 2 r
        vs = real( x.s * x.s' );
       % SRB: wouldn't vs = norm(x.s)^2 be better? less overflow chance, etc.
    else
    	% 2 r^2 ( m + n )
    	SVV = bsxfun( @times, x.s, x.V' * x.V );
        UUS = bsxfun( @times, x.U' * x.U, x.s(:) );
        vs = real( UUS(:).' * SVV(:) );
    end
end
if isempty( x.X ),
    %v = vs;  % SRB: ?  vs isn't defined
    v = 0;
else
    vx = nonzeros( x.X );
    vx = vx' * vx;
    if isempty( x.s ),
        v = vx;
    else
        XV = x.X * x.V;
        US = bsxfun( @times, x.U, x.s(:) );
        v = vx + vs + 2 * real( XV(:)' * US(:) );
    end
end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

        
        
        

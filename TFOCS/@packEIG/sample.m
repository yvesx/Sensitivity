function b = sample( x, i, j )

% SAMPLE   Sample individual elements.

if isempty(x.s),
	bS = ( x.U(i,:) .* conj(x.V(j,:)) ) * x.s.';
else
	bS = 0;
end
if ~issparse(x.X) || nnz(x.X),
	bX = full(reshape(x.X(i+x.sz(2)*(j-1)),numel(i),1));
else
	bX = 0;
end
b = bX + bS;
if numel(b) == 1,
	b = zeros(numel(i),1);
end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

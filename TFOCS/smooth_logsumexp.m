function op = smooth_logsumexp()
% SMOOTH_LOGSUMEXP The function log(sum(exp(x)))
%   returns a smooth function to calculate
%   log( sum( exp(x) ) )
%
% For a fancier version (with offsets),
% see also smooth_LogLLogistic.m

op = @smooth_logsumexp_impl;

function [ v, g ] = smooth_logsumexp_impl( x )
expx = exp(x);
sum_expx = sum(expx(:));
v = log(sum_expx);
if nargout > 1,
    g = expx ./ sum_expx;
end

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

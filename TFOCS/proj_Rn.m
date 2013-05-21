function op = proj_Rn

%PROJ_RN    "Projection" onto the entire space.
%    OP = PROX_0 returns an implementation of the function OP(X) = 0. Use
%    this function to specify a model with no nonsmooth component. It is
%    identical to both PROX_0 and SMOOTH_CONSTANT( 0 ).
% Dual: proj_0.m

op = smooth_constant( 0 );

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

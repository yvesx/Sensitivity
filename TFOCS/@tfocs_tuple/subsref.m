function varargout = subsref( x, varargin )
[ varargout{1:nargout} ] = subsref( x.value_, varargin{:} );

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

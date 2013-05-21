function er = recordPoints( x )

persistent history

if nargin == 0
    er = history;
    history = [];
    return;
end

history = [history, x ];
er  = 0;

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.


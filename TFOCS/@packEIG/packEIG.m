classdef packEIG
% PACKEIG
%   Constructor for the PACKEIG class
%   Possible calling sequences:
%
%   PACKEIG( X )
%       where X is a matrix (dense or sparse)
%
%   PACKEIG( M, N )
%       returns a zero matrix of size M x N
%
%   PACKEIG( D, V )
%       returns a matrix implicitly formed as X = V*diag(D)*V'
%       V is not required to have orthonormal columns
%       (although this is typical)


    % see matlabroot/help/techdoc/matlab_oop/examples/@DocPolynom/DocPolynom.m
    % By default, these properties are public
    properties
        sz
        s
        U
        V
        X
        orth
    end

    % clas methods
    methods

function v = packEIG( varargin )
switch nargin,
    case 0,
    
        error( 'Must supply at least one argument.' );
        
    case 1,
    
        X = varargin{1};
        switch class( X ),
            case 'packEIG',
            
                v = X;
                return
                
            case { 'double', 'sparse' },
            
                if isempty(X),
                    error( 'Input cannot be empty.' );
                end
                [m,n] = size(X);
                nz = nnz(X); ne = numel(X);
                if ne == 0,
                	X = [];
               	elseif ne / nz > 2,
                	X = sparse(X);
                else
                	X = full(X);
                end
                v.sz = [m,n];
                v.s = []; v.U = []; v.V = [];
                v.X = X;
                v.orth = true;
                
            otherwise,
            
                error( 'Cannot convert class %s to packEIG', class(v) );
                
        end
        
    case 2,
    
        [ m, n ] = deal(varargin{:});
        if ~isnumeric(m) || ~isreal(m) || ~isscalar(m) || m <= 0 || floor(m)~=m,
            error( 'Size must be a positive integer.' );
        elseif ~isnumeric(n) || ~isreal(n) || ~isscalar(n) || n <= 0 || floor(n)~=n,
            error( 'Size must be a positive integer.' );
        end
        v.sz = [m,n];
        v.s = []; v.U = []; v.V = []; 
        v.X = [];
        v.orth = true;
        
    case 3,
    
        [ s, U, V ] = deal(varargin{:});
        r = length(s);
        % We don't allow diag(s) currently
        if ~isnumeric(s) || ~isreal(s) || numel(s) ~= r,
            error( 'First element must be a real vector.' );
        end
        if ~isnumeric(U) || issparse(U),
            error( 'Second element must be a dense matrix.' );
      % SRB: shouldn't this be size(U,2) or length(U) ?
        elseif size(U,2) ~= r,
            error( 'Second element must have %d columns.', r );
        elseif size(U,2) == 0,
            error( 'Second element cannot have 0 rows.', r );
        end
        if ~isnumeric(V) || issparse(V),
            error( 'Third element must be a dense matrix.' );
      % SRB: shouldn't this be size(V,2) or length(V) ?
        %elseif size(V) ~= r,
        elseif size(V,2) ~= r,
            error( 'Third element must have %d columns.', r );
        elseif size(V,2) == 0,
            error( 'Third element cannot have 0 rows.', r );
        end
        s      = s(:).';
        tt     = s ~= 0;
        v.sz   = [ size(U,1), size(V,1) ];
        v.s    = s(:,tt);
        v.U    = U(:,tt);
        v.V    = V(:,tt);
        v.X    = [];
        
end
% No longer necessary
%v = class( v, 'packEIG' );
end  % end of constructor

end % methods
end % classdef

% TFOCS v1.2 by Stephen Becker, Emmanuel Candes, and Michael Grant.
% Copyright 2012 California Institute of Technology and CVX Research.
% See the file TFOCS/license.{txt,pdf} for full license information.

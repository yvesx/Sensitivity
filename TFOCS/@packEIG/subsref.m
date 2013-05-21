function B = subsref(A,S)

switch S.type
    case '()'
        if ~isempty(A.X)
            B = subsref( A.X, S );
        elseif ~isempty( A.s ) && ~isempty( A.U ) && ~isempty(A.V)
            % for now, we do the naive thing:
            X = A.U*diag(A.s)*(A.V');
            B = subsref( X, S );
        else
            % the empty matrix is interpreted as the all-zero matrix
            B = zeros( size(S.subs{1}) );
        end

    case '{}'
        error('Cell indexing of packSVD object is not supported');
    case '.'
        B = A.(S.subs);
    otherwise
        error('bad value for subsref in packSVSD');
end


out = [];

% see also subsasn for A(S) = b

% and a subfuinction: subsindex

% Try "clear classes" to get this to work

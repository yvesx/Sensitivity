function disp(v)

% Possible fields:
%   sz, s, U, V, X, orth
if isfield(v,'orth') && v.orth
    orth = 1;
else
    orth = 0;
end

if ~isempty(v.X)
    explicitFlag = 'does';
else
    explicitFlag = 'does not';
end


fprintf('\tpackSVD object: %d x %d matrix, orth flag is %d, explicit representation %s exist\n',...
    v.sz(1), v.sz(2), orth, explicitFlag );

load walmart_exp;
[r,c] = size(walmart_top);
%brandUserSparse99 = walmart_top;
%brandUserSparse99(:,1) = brandUserSparse99(:,1).*(rand(r,1)<0.01); %95% sparse
%brandUserSparse999 = walmart_top;
%brandUserSparse999(:,1) = brandUserSparse999(:,1).*(rand(r,1)<0.001); %95% sparse
%brandUserSparse9999 = walmart_top;
%brandUserSparse9999(:,1) = brandUserSparse9999(:,1).*(rand(r,1)<0.0001); %95% sparse

big_M = brandUserSparse999;
[N,M]   = size(big_M);       % the matrix is N x N
omega = find(big_M);% this omega lists only nonzero cells and fills all zero entries
one_s = ones(N,M);
one_s(:,1)=big_M(:,1);
other_omega = find(one_s); % this omega treats 0s as 0s except 0s on walmart column; those will be filled
%rnk   = rank(big_M);        % the rank of the matrix
%df = rnk*(N+M-rnk);  % degrees of freedom of a N x N rank r matrix
%nSamples = min(5*df,round(.99*N*M) );
%omega = randsample(N*M,nSamples);  % this requires the stats toolbox
addpath ../TFOCS/

mu           = .001;        % smoothing parameter
% The solver runs in seconds
tic
X1 = solver_sNuclearBP( {N,M,omega}, big_M(omega), mu );
toc
tic
X2 = solver_sNuclearBP( {N,M,other_omega}, big_M(other_omega), mu );
toc
%disp('Recovered matrix (rounding to nearest .0001):')
%disp( round(Xk*10000)/10000 )
% and for reference, here is the original matrix:
%disp('Original matrix:')
%disp( big_M )
% The relative error (without the rounding) is quite low:
fprintf('Relative error fill all 0s: %.8f%%\n', norm(big_M-X1,'fro')/norm(big_M,'fro')*100 );
fprintf('Relative error only walmart 0s: %.8f%%\n', norm(big_M-X2,'fro')/norm(big_M,'fro')*100 );

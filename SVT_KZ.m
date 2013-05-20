function [x] = SVT_KZ(filename, users)

    clc;
    
    big_M = load(filename);
    sample = randsample(1:length(big_M), users);
    M = big_M(sample,:);
    [r,c] = size(M);

    % generate the projection matrix Omega
    Omega = zeros(r,c);
    num = 0; % number of existing entries
    for i=1:r
        for j=1:c
            if M(i,j) > 0
                Omega(i,j) = 1;
                num = num + 1;
            end
        end
    end
    disp(num);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                               %
    %         SVT algorithm         %
    %                               %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    maxiter = 500; %maximum iterations
    tau = 1000;

    y{1} = ones(r,c);
    
    % the singular vector thresholding algorithms
    for k=2:maxiter
        disp(k);
        [U, S, V] = svd(y{k-1});
        D = S - tau;
        D = max(D,0);
        x{k} = U*D*V';
        y{k} = y{k-1} + (M-x{k}).*Omega;
    end
    c=clock;
    save(strcat(mat2str(c),'.mat'))
end
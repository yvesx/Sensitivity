clear all;
load walmart_exp.mat;
% cosine dist turns out to be better than others i tried
cosClustSp999WalFil = kmeans(brandUserSparse999WalFill,10,'distance','cosine');
cosClustSp999AllFil = kmeans(brandUserSparse999AllFill,10,'distance','cosine');

brandUserEM999WalFill = zeros(size(brandUserSparse999WalFill));
for i=1:10 % 10 strata of users
    init_abc = init_abc_orig;
    % for each cluster of users
    idx = find(cosClustSp999WalFil==i);
    cur_mat = brandUserSparse999WalFill(idx,:);%M-step
    user_attri_mat = cur_mat * (init_abc') / (init_abc*init_abc');%E-step
    % 500 EM iterations
    for j = 1:300
        old_mat = cur_mat;
        cur_mat = user_attri_mat * init_abc; %M-step
        %fprintf('RltvErr: %.8f%%', norm(old_mat-cur_mat,'fro')/norm(cur_mat,'fro')*100 );
        %user_attri_mat = cur_mat * (init_abc') / (init_abc*init_abc');%E-step
        cur_mat = max(0,cur_mat);% also E-step
        [user_attri_mat,init_abc,D] = nnmf(cur_mat, 6 ,'h0',init_abc);
        if (norm(old_mat-cur_mat,'fro')/norm(cur_mat,'fro') * 100 < 0.1 ) &&...
           (D < 0.01), break, end
        %disp(D);
    end
    fprintf('RltvErr: %.8f%%', norm(old_mat-cur_mat,'fro')/norm(cur_mat,'fro')*100 );
    disp(D);
    % update the matrix
    brandUserEM999WalFill(idx,:) = cur_mat;
    %B = glmfit(user_attri_mat, [Y ones(10,1)], 'binomial', 'link', 'logit');
    disp(i);
end
brandUserEM999WalFill = max(0,brandUserEM999WalFill);
rank = zeros(18,5); % 18 brands and 5 kinds of rankings
for i=2:18
    diff_v = brandUserEM999WalFill(:,1)-brandUserEM999WalFill(:,i);
    rank(i,1)=norm(diff_v,1);
    rank(i,2)=norm(diff_v,2);
    rank(i,3)=norm(diff_v,Inf);
    rank(i,4)=norm(diff_v,'fro');
    rank(i,5)=mse(diff_v);
end
rank = rank';
for i=1:5
    [~,~,z] = unique(rank(i,:));
    rank(i,:) = z;
end
[~,~,z] = unique(sum(rank));
z = max(z) - z  + 1; % reverse the rank
rank = z';
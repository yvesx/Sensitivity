load walmart_exp;
[r,c] = size(walmart_top);
X = walmart_top;
X(:,1) = X(:,1).*(rand(r,1)<0.001); %95% sparse
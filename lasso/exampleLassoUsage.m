%==========================================================================
%
%               AUTHOR: GAUTAM V. PENDSE                                  
%               DATE: 11 March 2011                                   
%
%==========================================================================
%
%==========================================================================
%               
%               PURPOSE:
%
%   Example usage of LASSO
%   
%==========================================================================


% load example data
%data = load('sampleDataForLasso.mat');
%y=data.y;
%X=data.X;
%beta=data.beta;
% data contains the following fields:
% X: [100x23 double] = dummy design matrix
% y: [100x1 double] = dummy response vector
% beta: [23x1 double] = true parameter vector (only first 3 parameters are non-zero)
% sigma: 0.5000 = noise std
%
% y was generated using:
%
% y = X*beta + sigma*randn(100,1);
%

% set lambda range to investigate
lambda_min = 0;
lambda_max = 6;
nlambda = 100;
lambda_vec = linspace(lambda_min, lambda_max, nlambda);

% set kfold = 10 for 10-fold cross validation
kfold = 10;

% call lambda estimation routine
estLambda = estimateLassoLambda( y, X, kfold, lambda_vec );

% plot lambda_vec versus mean MSEerror across folds
fh1 = figure(1);
set(fh1,'color',[1,1,1]);set(gca,'FontSize',12);
plot( estLambda.lambda_vec, estLambda.MSEerror,'m.-','LineWidth',1);xlabel('\lambda');ylabel('Mean MSE error across folds');hold on;
% plot the minimum point
plot( estLambda.lambda_vec( estLambda.min_index ), estLambda.MSEerror( estLambda.min_index ),'ro','LineWidth',1,'MarkerSize',8,'MarkerFaceColor',[0.5,0.5,0.5],'MarkerEdgeColor','g');

% plot predicted, true and noise response vector
fh2 = figure(2);
set(fh2, 'color',[1,1,1]);set(gca,'FontSize',12);
plot( y ,'r.-','LineWidth',1);hold on;
plot( X * beta, 'b-', 'LineWidth',2);

% fit Lasso using optimal lambda determined using cross validation
sL = solveLasso( y, X, estLambda.lambda );
plot( X * sL.beta, 'g-', 'LineWidth', 2 );
ylabel('noisy, true and LASSO fitted responses');
legend('noisy','true','LASSO');

% finally plot the LASSO estimated coefficient vector
fh3 = figure(3);
set(fh3,'color',[1,1,1]);set(gca,'FontSize',12);
plot( beta, 'bd-', 'LineWidth', 1, 'MarkerFaceColor','c', 'MarkerSize',10 );hold on;
plot( sL.beta, 'go','MarkerSize',6,'MarkerFaceColor',[0.5,0.5,0.5],'MarkerEdgeColor','r','LineWidth',1 );
ylabel('LASSO estimated coefficients');xlabel('index');
legend('true','LASSO');
function z = estimateLassoLambda( y, X, kfold, lambda_vec )
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
%   Estimate L1 regularization parameter in LASSO via cross validation.
%
%
%   Algorithm for solving the Lasso problem:
%
%           0.5 * (y - X*beta)'*(y - X*beta) + lambda * ||beta||_1
%                                               
%   where ||beta||_1 is the L_1 norm i.e., ||beta||_1 = sum(abs( beta ))
%
%   We use the method proposed by Fu et. al based on single co-ordinate
%   descent. For more details see GP's notes or the following paper:
%
%   Penalized Regressions: The Bridge Versus the Lasso
%   Wenjiang J. FU, Journal of Computational and Graphical Statistics, 
%   Volume 7, Number 3, Pages 397?416, 1998
%   
%==========================================================================
%
%==========================================================================
%               
%               USAGE:
%
%               z = estimateLassoLambda( y, X, kfold, lambda_vec )
%
%==========================================================================
%
%==========================================================================
%               
%               INPUTS:
%
%       =>          y = n by 1 response vector
%
%       =>          X = n by p design matrix
%
%       =>      kfold = use kfold cross validation (e.g., kfold = 5)
%
%       => lambda_vec = a column vector of potential regularization
%                       parameters to consider
%
%==========================================================================
%
%==========================================================================
%               
%               OUTPUTS:
%
%
%       =>     z.lambda = optimal lambda value computed by kfold cross-validation
%
%    
%       => z.lambda_vec = user supplied vector of potential lambda values
%    
%    
%       =>   z.MSEerror = average MSE over kfold folds for each lambda value
%    
%    
%       =>  z.min_index = index of minimum of MSEerror
%    
%    
%       =>        z.CVO = kfold cross-validation structure
%    
%    
%       =>          z.y = user supplied response vectors
%    
%    
%       =>          z.X = user supplied design matrix
%
%    
%       =>      z.kfold = user supplied value for kfold 
%    
%==========================================================================
%
%==========================================================================
%   
%       Copyright 2011 : Gautam V. Pendse
%
%               E-mail : gautam.pendse@gmail.com
%
%                  URL : http://www.gautampendse.com
%
%==========================================================================


%==========================================================================
%               check input args

    if ( nargin ~= 4 )
        disp('Usage: z = estimateLassoLambda( y, X, kfold, lambda_vec )');
        z = [];
        return;
    end
    
    % check size of y
    [n1, p1] = size(y);
    
    % is y a column vector?
    if ( p1 ~= 1 )
        disp('y must be a n by 1 vector!!');
        z = [];
        return;
    end
    
    % check size of X
    [n2,p2] = size(X);
    
    % does X have the same number of rows as y?
    if ( n2 ~= n1 )
        disp('X must have the same number of rows as y!!!');
        z = [];
        return;
    end
    
    % make sure kfold is positive
    kfold = floor(kfold);
    if ( kfold < 2 )
        disp('kfold must be >= 2!');
        z = [];
        return;
    end
    
    % make sure lambda_vec(i) > 0
    for r = 1:length(lambda_vec)
        
        if ( lambda_vec(r) < 0 )
            disp('all entries of lambda_vec must be >= 0!');
            z = [];
            return;
        end
        
    end
    
    
    % get size of X
    [n, p] = size(X);
    
%==========================================================================

%==========================================================================
%   partition input data for cross-validation
    
    CVO = cvpartition( n, 'kfold' , kfold );

%==========================================================================


%==========================================================================
%   compute cross-validation error for each regularization parameter

    % initialize a variable to hold average MSEerror across folds
    MSEerror = zeros( length(lambda_vec), 1 );

    for k = 1:length( lambda_vec )
        
      % vector to store MSE error for each fold  
      err = zeros(CVO.NumTestSets,1);
      
      for i = 1:CVO.NumTestSets
          
          % get ith training set
          trIdx = CVO.training(i);
          
          % get ith test set
          teIdx = CVO.test(i);
          
          % train LASSO using training set
          sL = solveLasso( y(trIdx), X(trIdx,:), lambda_vec(k) );

          % test using testing set          
          ypred = X(teIdx,:) * sL.beta;
                    
          % calculate MSE error            
          temp = y(teIdx) - ypred;
                    
          % clear ypred
          clear ypred;
          
          % calculate average error for the ith test set
          err(i) = (temp'*temp)/length(temp);  
                    
      end
      
      % calculate the mean error over all test sets
      MSEerror(k) = mean(err);
                    
    end     
    
    % where do we get the smallest MSE?
    min_index = find( MSEerror == min(MSEerror) );
    min_index = min_index(1);
    
%==========================================================================


%==========================================================================
%   set outputs
    
    
    z.lambda = lambda_vec( min_index );

    z.lambda_vec = lambda_vec;
    
    z.MSEerror = MSEerror;
    
    z.min_index = min_index;
    
    z.CVO = CVO;
    
    z.y = y;
    
    z.X = X;
    
    z.kfold = kfold;
    
%==========================================================================

end
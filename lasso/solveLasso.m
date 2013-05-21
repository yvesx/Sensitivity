function z = solveLasso( y, X, lambda )
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
%               z = solveLasso( y, X, lambda )
%
%==========================================================================
%
%==========================================================================
%               
%               INPUTS:
%
%       =>      y = n by 1 response vector
%
%       =>      X = n by p design matrix
%
%       => lambda = regularization parameter for L1 penalty
%
%==========================================================================
%
%==========================================================================
%               
%               OUTPUTS:
%
%       =>      z.X = supplied design matrix
%
%       =>      z.y = supplied response vector
%
%       => z.lambda = supplied regularization parameter for L1 penalty
%
%       =>   z.beta = computed L1 regularized solution
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

    if ( nargin ~= 3 )
        disp('Usage: z = solveLasso( y, X, lambda )');
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
    
    % make sure lambda > 0
    if ( lambda < 0 )
        disp('lambda must be >= 0!');
        z = [];
        return;
    end
    
    % get size of X
    [n, p] = size(X);

%==========================================================================

%==========================================================================
%               initialize the Lasso solution

   % This assumes that the penalty is lambda * beta'*beta instead of lambda * ||beta||_1
   beta = (X'*X + 2*lambda) \ (X'*y);

%==========================================================================


%==========================================================================
%               start while loop

    % convergence flag
    found = 0;
    
    % convergence tolerance
    TOL = 1e-4;
    
    while( found == 0 )
    
        % save current beta
        beta_old = beta;
        
        % optimize elements of beta one by one
        for i = 1:p
            
            % optimize element i of beta
            
            % get ith col of X
            xi = X(:,i);
            
            % get residual excluding ith col
            yi = (y - X*beta) + xi*beta(i);           
            
            % calulate xi'*yi and see where it falls
            deltai = (xi'*yi); % 1 by 1 scalar
            
            if ( deltai < -lambda )
                
                beta(i) = ( deltai + lambda )/(xi'*xi);
            
            elseif ( deltai > lambda )
            
                beta(i) = ( deltai - lambda )/(xi'*xi);
            
            else
                
                beta(i) = 0;
            
            end
            
        end
        
        % check difference between beta and beta_old
        if ( max(abs(beta - beta_old)) <= TOL )
            found = 1;
        end
                      
    end
    
%==========================================================================

%==========================================================================
%   save outputs
    
    z.X = X;
    z.y = y;
    z.lambda = lambda;
    
    z.beta = beta;

%==========================================================================


end

Sensitivity
===========

Recommendation systems automatically recommend relevant items to users based on their preferences, which are vital to the success of online retailers and content providers. Collaborative filtering works well in practice at web scale. However, one common difficulty in collaborative filtering rec- ommendation systems is the “cold start” problem. The word “cold” refers to the items that are not yet rated by any user or the users who have not yet rated any items. We propose ELVER, an algorithm for recommending cold items from large, sparse user-item matrices. We use ELVER to recommend and optimize page-interest targeting on Facebook. Special traits of a social network like Facebook have influenced the design of ELVER. Existing techniques for cold recommendation mostly rely on content features in the event of lacking user ratings. Traditional items (e.g., movies or music) have rich, organized content features like actors, directors, awards, etc. Since it is very hard to construct universally meaningful features for the millions of Facebook pages, ELVER makes minimal assumption of content features. ELVER employs iterative matrix completion technology and nonnegative factorization procedure to work with meagre content inklings. Experiments on Facebook data shows the effectiveness of ELVER at different levels of sparsity.

* Publication
``2013 IEEE International Conference on Big Data`` Yusheng Xie, Zhengzhang Chen, Kunpeng Zhang, Yu Cheng, Chen Jin, Ankit Agrawal, and Alok Choudhary. *Elver: Recommending Facebook Pages in Cold Start Situation Without Content Features*


Background
==========

* Recommending traditional items and social entities
![alt tag](https://raw.github.com/yvesx/Sensitivity/master/imgs/1.png)
![alt tag](https://raw.github.com/yvesx/Sensitivity/master/imgs/2.png)
* Collaborative Filtering Algorithm
![alt tag](https://raw.github.com/yvesx/Sensitivity/master/imgs/3.png)

The Problem
===========

* The cold item situation: items do not have enough user ratings.
![alt tag](https://raw.github.com/yvesx/Sensitivity/master/imgs/4.png)
![alt tag](https://raw.github.com/yvesx/Sensitivity/master/imgs/5.png)
![alt tag](https://raw.github.com/yvesx/Sensitivity/master/imgs/6.png)
* Limitations of Collaborative Filtering
![alt tag](https://raw.github.com/yvesx/Sensitivity/master/imgs/7.png)
![alt tag](https://raw.github.com/yvesx/Sensitivity/master/imgs/8.png)
* The proposed framework and components
![alt tag](https://raw.github.com/yvesx/Sensitivity/master/imgs/9.png)
![alt tag](https://raw.github.com/yvesx/Sensitivity/master/imgs/10.png)
* An iterative algorithm (stochastic Expectation-Maximization algorithm)
![alt tag](https://raw.github.com/yvesx/Sensitivity/master/imgs/11.png)

Evaluation
==========
* Convergence of the algorithm
![alt tag](https://raw.github.com/yvesx/Sensitivity/master/imgs/12.png)
* Matrix-wise recommendation mean square errors.
![alt tag](https://raw.github.com/yvesx/Sensitivity/master/imgs/13.png)

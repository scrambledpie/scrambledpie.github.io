---
layout: post
title:  "Continuous Multi-Task Bayesian Optimization with Correlation"
date:   2018-10-21 17:46:02 +0100
categories: jekyll update
---

See the paper [here][REVI_paper] and some toy source code in R [here][REVI_git].

Standard Bayesian optimisation deal with finding the best input to a stochastic noisy expensive black box function. Well, what if I had, say, 10 expensive black box functions all over the same input domain X, surely I do not need to optimise all 10 independently? 

We consider this problem and show that when given a range of objective functions (multiple tasks), optimizing one can optimize the rest. Specifically collecting data (pick one function, pick one $$ x \in X $$, observe one $$y$$) accounting for how that new data point influences all functions can lead to significant performance improvement. 

We propose the Regional expected Value of Improvement algorithm for this purpose and it looks like this:

![image-title-here](/Pics/REVI/MTKGREVI_sparse-2.gif){:class="img-responsive"}

The horizontal axis is the task parameter, the vertical axis the input for that task, and we aim to find the best input for each task, i.e. optimize each vertical slice. Blue points are observed points, the green point is one possible new point whose y value is random, and the black points show the predicted peak of each slice, that will change as a result of the new green addition.

The acquisition funciton, REVI, simply says, find the single green point that maximses the avergae height of all black points.




[REVI_git]: https://github.com/scrambledpie/Conditional-Multi-Task-BayesOpt
[REVI_paper]: https://www.sciencedirect.com/science/article/abs/pii/S0377221718302261


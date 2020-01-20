---
layout: post
title:  "Continuous Multi-Task Bayesian Optimization with Correlation"
date:   2018-10-21 17:46:02 +0100
categories: jekyll update
img: Pics/REVI/MTKGREVI_sparse-2.gif
paper: https://www.sciencedirect.com/science/article/abs/pii/S0377221718302261
code: https://github.com/scrambledpie/Conditional-Multi-Task-BayesOpt
googlescholar: https://scholar.google.co.uk/citations?user=OOtbjJ0AAAAJ&hl=en#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26hl%3Den%26user%3DOOtbjJ0AAAAJ%26citation_for_view%3DOOtbjJ0AAAAJ%3ARHpTSmoSYBkC%26tzom%3D0
---

<!-- * See the paper [here][REVI_paper] and a newer rewritten version in Chapter 6 of my thesis [here][MP_thesis] -->
<!-- * toy source code in R [here][REVI_git] -->

Standard Bayesian optimisation deals with finding the best input $$ x \in X $$ to a stochastic noisy expensive black box function $$ f(x) $$. If I had, say, 10 expensive black box functions all over the same input domain $$ f_{1}(x),..., f_{10}(x) $$, surely I do not need to optimise all 10 independently? 

We consider this problem and show that when given a range of objective functions (multiple tasks), optimizing one can speed up optimisation of the rest. Specifically collecting data (pick one $$ f_{i}(x) $$, pick one $$ x \in X $$, observe one $$y$$) accounting for how that new data point influences all functions can lead to significant performance improvement across all functions. 

We propose the Regional expected Value of Improvement algorithm for this purpose and it looks like this:

![image-title-here]({{site.baseurl}}/assets/img/Pics/REVI/MTKGREVI_sparse-2.gif){:class="img-responsive"}

The horizontal axis is the task parameter $$ i $$, the depth/vertical axis the input for that task $$ x $$, and we aim to find the best input for each task $$ max_x f(i,x) $$, i.e. optimize each vertical slice. Blue points are observed points, the green point is one possible new point whose y value is random, and the black points show the predicted peak of each slice, that will change as a result of the new green addition.

The acquisition funciton, REVI, simply says, find the single green point that maximses the average height of all black points.


[MP_thesis]:/Pics/thesis(1).pdf
<!-- [REVI_git]:  -->
<!-- [REVI_paper]:  -->


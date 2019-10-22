---
layout: post
title:  "Bayesian Optimization Allowing for Common Random Numbers"
date:   2019-10-21 17:46:02 +0100
categories: jekyll update
---

The paper is [here][CRN_paper] and source code is soon to follow.

We consider the global optimisation of an expensive function with stochastic noisy outputs $$f(x)$$ over a search space $$ x \in X $$. The goal is to find the input $$x$$ that has the best output on average $$ max_x\mathbb{E}[f(x)]$$. 

In reality, the stochastic black box $$f(x)$$ is often a computer program e.g. a neural network, a simulator, or an agent in an environment. The stochasticity comes from random number generation within the function. So we may make this explicit $$ f(x,s) $$ where $$s$$ is the random number generator seed that controls all stochasticity inside the function. As a result, $$f(x,s)$$ for a given seed is now a deterministic function! 

If we enforce that every call to the funciton requires a new unique seed we are back to standard global optimisation.

Instead, we can optimise seed 1 and learn $$ max_x f(x,1)$$ which is much easier than optmising $$ max_x\mathbb{E}[f(x,\cdot)]$$. Of course the optimum of one seed is not the optimum of the average over seeds so we need to a Bayesian optimisation algortihm that can trade off optimising one seed and optimizing many seeds.



[CRN_paper]: https://jekyllrb.com/docs/home
[CRN_git]:   https://github.com/jekyll/jekyll

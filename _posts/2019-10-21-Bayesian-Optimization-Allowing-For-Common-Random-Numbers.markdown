---
layout: post
title:  "Bayesian Optimization Allowing for Common Random Numbers"
date:   2019-10-21 17:46:02 +0100
categories: jekyll update
---

The paper can be found [here][CRN_paper] and source code is soon to follow.

We consider the global optimisation of an expensive function with stochastic noisy outputs $$\theta(x)$$ over a search space $$ x \in X $$. The goal is to find the input $$x$$ that has the best output on average $$ max_x\mathbb{E}[\theta(x)]$$.

For example, an algorithm collects data $$(x,y)$$ (in black) and predicts the average $$\mathbb{E}[\theta(x)]$$ (grey),


![image-title-here](/Pics/CRN/not-CRN.jpg){:class="img-responsive"}

In reality, the stochastic black box $$\theta(x)$$ is often a computer program e.g. a neural network, a simulator, or an agent in an environment. The stochasticity comes from random number generation within the function. So we may make this explicit $$ \theta(x,s) $$ where $$s$$ is the random number generator seed that controls all stochasticity inside the function. Therefore the data collected was actually $$(x,s,y)$$ triplets where $$s$$ was unique. Coloring data points by seed used we would get 

![image-title-here](/Pics/CRN/CRN-IID.jpg){:class="img-responsive"}

The question naturally arises, what would happen if we call the objective function with only 5 seeds. For example, there may be an objective function that produces data that looks the same as before

![image-title-here](/Pics/CRN/CRN-no-cor.jpg){:class="img-responsive"}

Other objective functions may produce data that looks like each seed has some structure,
![image-title-here](/Pics/CRN/CRN-ideal.jpg){:class="img-responsive"}

Or in the best possible case, some applications may produce data where a single seed is exactly the same as the average only with a constant offset
![image-title-here](/Pics/CRN/CRN-full_corr.jpg){:class="img-responsive"}

So the next question naturally arises, in the final case pictured above, surely it is possible to optimise $$\theta(x,1)$$ (red) and find $$ argmax_x \theta(x,1) $$ since this is the same as $$ argmax_x\mathbb{E}[\theta(x,\cdot)]$$ (grey). If they Optimising the deterministic red funciton above is much easier than optimising the stochastic black function at the very begining of the post!

The standard approach to global optimisation, places a Gaussian process prior over the underlying average $$\bar{\theta}(x)=\mathbb{E}[\theta(x,\cdot)]$$

The **difference functions** $$ \epsilon_s(x) = \theta(x,s)- \mathbb{E}[\theta(x,\cdot)]$$ show how one seed differs from the avergae over seeds. Since there are (in theory) infintely have many possible seeds, there are many difference functions, and we require a distribution over difference functions, or, another Gaussian process.



[CRN_paper]: https://jekyllrb.com/docs/home
[CRN_git]:   https://github.com/jekyll/jekyll

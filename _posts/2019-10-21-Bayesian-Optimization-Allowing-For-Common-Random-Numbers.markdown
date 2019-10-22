---
layout: post
title:  "Bayesian Optimization Allowing for Common Random Numbers"
date:   2019-10-21 17:46:02 +0100
categories: jekyll update
---

The paper can be found [here][CRN_paper] and source code is soon to follow. This is joint work with Matthias Poloczek from Uber AI and Arizona University, and Juergen Branke of Warwick business school.

We consider the global optimisation of an expensive function with stochastic noisy outputs $$\theta(x)$$ over a search space $$ x \in X $$. The goal is to find the input $$x$$ that has the best output on average $$ \max_x\mathbb{E}[\theta(x)]$$.

For example, an algorithm collects data $$(x,y)$$ (in black) and predicts the average $$\mathbb{E}[\theta(x)]$$ (grey),

<span style="color: white">1<span style="color: white">

![image-title-here](/Pics/CRN/not-CRN.jpg){:class="img-responsive"}

<span style="color: white">1<span style="color: white">

In reality, the stochastic black box $$\theta(x)$$ is often a computer program e.g. training of a neural network with stochastic dropout, executing a simulator with randomly generated scenarios, or measuring reward for an agent in an random environment. The stochasticity comes from random number generation within the function. So we may make this explicit $$ \theta(x,s) $$ where $$s$$ is the random number generator seed that controls all stochasticity inside the function. Therefore, the data collected is actually $$(x,s,y)$$ triplets where the seed $$s$$ is unique for each data point. Coloring data points by seed used we would plot 

<span style="color: white">1<span style="color: white">

![image-title-here](/Pics/CRN/CRN-IID.jpg){:class="img-responsive"}

<span style="color: white">1<span style="color: white">

The question naturally arises, what would happen if we call the objective function with only a few seeds, say 6. For example, there may be an objective function that produces data that is just as random as calling the objective with unique seeds as above:

<span style="color: white">1<span style="color: white">

![image-title-here](/Pics/CRN/CRN-no-cor.jpg){:class="img-responsive"}

<span style="color: white">1<span style="color: white">

Other objective functions may produce data that looks like each seed has some structure,

<span style="color: white">1<span style="color: white">

![image-title-here](/Pics/CRN/CRN-ideal.jpg){:class="img-responsive"}

<span style="color: white">1<span style="color: white">

Or in the best possible case, some applications may produce data where a single seed is exactly the same as the average (grey empty points) only with a constant offset

<span style="color: white">1<span style="color: white">

![image-title-here](/Pics/CRN/CRN-full_corr.jpg){:class="img-responsive"}

<span style="color: white">1<span style="color: white">

So the second question naturally arises, in the final case pictured above, surely it is possible to optimise $$\theta(x,1)$$ (red) and find $$ argmax_x \theta(x,1) $$ since this is the same as $$ argmax_x\mathbb{E}[\theta(x,\cdot)]$$ (grey). Presumably, optimising the **deterministic** red function above is much easier than optimising the **stochastic** black function at the very begining of the post! In other words, fixing the seed leads to **emergent structure in the noise** of a function that can be exploited if it exists. This is commonly known as optimisation with common random numbers.

## The Model

The standard approach to global optimisation, places a Gaussian process prior over the underlying average 
$$\bar{\theta}(x)=\mathbb{E}[\theta(x,\cdot)]$$ which we call the **target**. $$\bar{\theta}(x)$$ is one sample from a known distribution over functions. Then, given $$x$$, we assume $$y$$ values are the underlying function with added Gaussian noise $$ y = \bar{\theta}(x)+\epsilon $$, specifically $$\epsilon$$ is a Gaussian variable realisation.

We augment the standard approach by considering a differnt form of noise $$ y = \bar{\theta}(x)+\epsilon_s(x)$$ where $$\epsilon_{s}(x)$$ is a Gaussian process realisation and we call them **difference functions** and $$\theta(x,s) = \bar{\theta}(x)+\epsilon_s(x)$$. These difference functions show how one seed differs from the average over seeds. Since there are (in theory) infintely have many possible seeds, there are many difference functions, and we require a distribution over difference functions, or, another Gaussian process. In general we model the underlying average (black) with one GP, and all differences (red, green) as coming from one common GP,

![image-title-here](/Pics/CRN/GENmodel.png){:class="img-responsive"}


## The Acquisition Function
The Knowledge Gradient (KG) acquisition function is a noise generalised version of popular Expected Improvement (EI) function, and naturally extends to this use case, we collect data triplets $$ (x, s, \theta(x,s)) $$ and we aim to learn 
$$ \bar{\theta}(x) $$ and find its peak. Knowledge Gradient is easily adapted to collect data over over one domain (inputs and seeds) in order to maximise a Gaussian proces over a different space (inputs averaged over seeds).

![image-title-here](/Pics/CRN/CRNKG.png){:class="img-responsive"}

The model and acquisition function together define the **Knowledge Gradient for Common Random Numbers** (CRN-KG) algorithm.

## Experiments
We compare against the standard Knowledge Gradient and the Knowledge Gradient with pairwise samples designed for the same problem setting. We apply the algorithm to two simulation optimisation problems, optimising shop restocking levels where the random number seed defines a stream of customers. The goal is to maximise profit, of all algortihm variants, KG-CRN results in fewer seeds being used, and fewer function calls to convergence. Optiizing one single realisation of customer stream leads to a very good optimum of the average over infinitely many random customer streams (seeds).

![image-title-here](/Pics/CRN/ATO.png){:class="img-responsive"}

The second application we consider is optimising ambulance base locations on a map to serve patients where the random number seed defines a stream of patients across the map. Contrasting with the previous application, optimizing one particular patient realisation does not help optimise the infinite average over seeds,

![image-title-here](/Pics/CRN/AMB.png){:class="img-responsive"}


Compared to KG for standard global optmisation with identical algortihm setings and implementation, the CRN-KG algorithm has approximltely 10%-30% more computational overhead. This is due to two more Gaussian process hyperparameters and a similar acquisition function optimisation cost. And yet these changes can yield much improved convergence. In implementaiton, computatinal overhead can be set to whatever a user desires. 

For more details, please see the [paper][CRN_paper]!


[CRN_paper]: https://arxiv.org/abs/1910.09259
[CRN_git]:   https://github.com/jekyll/jekyll

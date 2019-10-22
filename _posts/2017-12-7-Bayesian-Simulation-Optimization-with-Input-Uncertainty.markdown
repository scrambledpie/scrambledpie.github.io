---
layout: post
title:  "Bayesian Simulation Optimization with Input Uncertainty"
date:   2017-12-7 17:46:02 +0100
categories: jekyll update
---

Bayesian Optimisation has long been studied in engineering and simulation optimisation communities. In the simulation optimisation community, a user designs a simulator as a surrogate of the real world, such a simulator must be collibrated to real world data and then the controllable variables may be optmized to find the best alues that would work in reality. For example to optimise traffic light timings at a given road intersection, a user may write a simulator. First design the roads with locations of cars to be spawned and drive towards to the intersection. For the simulaotr to be useful, we would hope the arrival rate of cars to the intersection would be similar to the real arrival rate of cars.

In general, fiven a funciton of two variables, $$ \nabla_\boldsymbol{x} J(\boldsymbol{x}) $$
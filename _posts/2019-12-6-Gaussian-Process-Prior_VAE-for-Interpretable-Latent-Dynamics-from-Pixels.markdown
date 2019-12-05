---
layout: post
title:  "Gaussian Process Prior VAE for Interpretable Layent Dynamics from Pixels"
date:   2019-11-6 17:46:02 +0100
categories: jekyll update
---

Source code is available [here][GPVAE_git] and the paper is soon to follow.

## The Problem

Given a set of videos that looks like this:

<p align="center">
  <img width="600" height="350" src="/Pics/GPVAE/out.gif">
</p>


we know that the images have low-dimensional structure, in this case there is only so many white pixels on screen at once, and there is also a lot of similarity between consecutive frames.
Can we use this simple underlying structure and correlation-through-time to compress these videos into a series of physically plausible $$(x,y)$$ coordinates?

In this work we consider doing just that, however with a few extra requirements:

* For any frame, we could obviously just use indeces of the most top left white pixel as a prediction of $$(x,y)$$ location. But such a solution is unique to this dataset and won't generalise to colorful real world video (future work).

* It must be amortised: we want a method that goes from videos $$v_1,...,v_T$$ to $$(x_1,y_1),...,(x_T, y_T)$$. (As opposed to mean-field methods that try to find $$(x_t,y_t)$$ by some optimisation to match $$v_t$$).

* It must be able to handle different length videos: 2 frames, 10 frames, 100 frames, videos vary in length.


## The Solution

Let's assume that the underlying $$(x,y)$$ time series can be modelled by a standard Gaussian process. We can take each frame, $$v_1,...,v_{30}$$, use a neural network to encode it into a pair $$(\mu^*_x(v_t), \mu^*_y(v_t))\in\mathbb{R}^2$$.

Next, take all of the $$x$$ values of the encodings and their time stamps $$(1,\mu_x^*(v_1),....,(30, \mu_vx^*v_{30}))$$, and simply treat them as points for standard 1D Gaussian process regression over time. This way we get a prediction for $$x_t$$ at any time. We do the same for the y-values too. We take a video (left) and fit a GP to the encoded $$x$$ locations and encoded $$y$$ locations, so we can learn latent paths. Below is a video with frames overlayed and shaded by time, right is the GP encoded time series.

<p align="center">
  <img width="600" height="300" src="/Pics/GPVAE/VID_latent.png">
</p>

And the Gaussian process for each coordinate looks like
<p align="center">
  <img width="650" height="300" src="/Pics/GPVAE/GPR.png">
</p>


Fianlly, we derive the evidence lower bound and train in tensorflow shown below. Notice how to begin with, the encoded (x,y) points are rather tangled and messy, but, they get "unwrapped" and ironed out as training continues, focus on the top-right points of the circle plot,

<p align="center">
<iframe width="650" height="600" src="https://www.youtube.com/embed/riVhb6K_iMo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</p>



As a simple Naive Baseline, we also trained a VAE without and corellation through time, the images are encoded in an i.i.d. fashion, as a result the latent space is rather messy and disorganised, the top row is input video, middle row is VAE encoded latent $$(x,y)$$ and the bottom row is the GP-VAR encoded $$(x,y)$$

<p align="center">
  <img width="460" height="480" src="/Pics/GPVAE/vin_VAE_GPVAE.png">
</p>



[GPVAE_git]:https://github.com/scrambledpie/GPVAE

---
layout: post
title:  "Gaussian Process Prior VAE for Interpretable Layent Dynamics from Pixels"
date:   2019-12-4 17:46:02 +0100
categories: jekyll update
---

* Source code is available [here][GPVAE_git], 
* The paper [here][GP_VAE_paper]
* The poster to be presented at [AABI 2019][AABI_link] is [here][AABI_poster].

## The Problem

Given a set of videos that looks like this:

<p align="center">
  <img width="600" height="350" src="/Pics/GPVAE/out.gif">
</p>


we know that the videos have low-dimensional structure, in this case there is only so many white pixels on screen at once, and there is also a lot of similarity between consecutive frames.
Can we use this simple underlying structure and correlation-through-time to learn a physically plausible time series of $$(x,y)$$ coordinates?

In this work we consider doing just that, however with a few extra requirements:

* For any frame, we could obviously just use indeces of the most top left white pixel as a prediction of $$(x,y)$$ location. But such a solution is unique to this dataset and won't generalise to colorful real world video (future work).

* For speed at test time, it must be amortised: we desire a single function that goes from videos, image time series $$v_{1:T}$$, to location time series, $$(x_1,y_1),...,(x_T, y_T)$$. (As opposed to mean-field methods that find $$(x_t,y_t)$$ by an inner optimisation to match $$v_t$$).

* It must be able to handle different length videos: 2 frames, 10 frames, 100 frames, videos vary in length.

Previous solutions, such as the Kalman-VAE, have combined high-capacity LSTM with low capacity Kalman-filtering. This allowed interpretable physically plausible latent space but required training tricks: reweighting loss function terms, freeze-thaw of parameters, a handcrafted training schedule....
We skip the Kalman filter + LSTM and consider a Gaussian process. This simplifies the maths, reduces Monte-Carlo approximations, stabilises training...


## The Solution

Let's assume that the underlying $$(x,y)$$ time series can be modelled by a standard Gaussian process. For simlpicity, le't say we have 30 frames, we can take each frame, $$v_1,...,v_{30}$$, use a neural network to encode it into a pair $$(\mu^*_x(v_t), \mu^*_y(v_t))\in\mathbb{R}^2$$.

Next, take all of the $$x$$ values of the encodings and their time stamps $$(1,\mu_x^*(v_1)),....,(30, \mu_x^*(v_{30}))$$, and simply treat them as points for standard 1D Gaussian process regression over time. This way we get a prediction for $$x_t$$ at any time. We do the same for the $$y$$ values too. We take a video (left) and fit a GP to the encoded $$x$$ locations and encoded $$y$$ locations, so we can learn latent paths. Below left is a video with frames overlayed and shaded by time, right is the GP encoded time series.

<p align="center">
  <img width="600" height="300" src="/Pics/GPVAE/VID_latent.png">
</p>

And the Gaussian process for each coordinate looks like
<p align="center">
  <img width="650" height="300" src="/Pics/GPVAE/GPR.png">
</p>


Finally, we derive the evidence lower bound and train in tensorflow shown below. Notice how to begin with, the encoded (x,y) points are rather tangled and messy, but, they get "unwrapped" and ironed out as training continues, focus on the top-right points of the circle plot,

<p align="center">
<iframe width="650" height="600" src="https://www.youtube.com/embed/riVhb6K_iMo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</p>



As a simple naive Baseline, we also trained a VAE without and correlation through time, the images are encoded in an i.i.d. fashion, as a result the latent space is rather messy and discontinuous, the top row is input video, middle row is VAE encoded latent $$(x,y)$$ and the bottom row is the GP-VAE encoded $$(x,y)$$

<p align="center">
  <img width="460" height="480" src="/Pics/GPVAE/vin_VAE_GPVAE.png">
</p>

If we consider a fixed pattern of images, and ask the encoder for an $$(x,y)$$ position in latent space, one would hope that a set of frames where the ball movies smoothly from one side of the screen to another would lead to a continuous set of latent points. However, this continuity from pixels to latents is not preserved by a standrard VAE, but is preserved by the GP-VAE.
<p align="center">
  <img width="460" height="322" src="/Pics/GPVAE/circ_grid.png">
</p>

Here we present some simple proof-of-concept results and, on this toy application at least, training is easy, yields an interpretable latent space that maps directly to pixel space. Next steps are to use the model on real data and reduce the cubic cost of GP inference for really long time series and evenetually augment an RL agent with the ability to predict physcially plausible latent states with uncertainty from visual input.

Feel free to play with the code and get in touch! scrambledpie@gmail.com


[GPVAE_git]:https://github.com/scrambledpie/GPVAE
[GP_VAE_paper]:/Pics/GPVAE/AABI2019_paper.pdf
[AABI_poster]:/Pics/GPVAE/AABI2019_poster.pdf
[AABI_link]:http://approximateinference.org/

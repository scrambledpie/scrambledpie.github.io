---
layout: post
title:  "Gaussian Process Prior for Interpretable Layent Dynamics from Pixels"
date:   2019-12-6 17:46:02 +0100
categories: jekyll update
---

Given a set of videos that looks like this:
![image-title-here](/Pics/GPVAE/out.gif){:class="img-responsive"}

we know in advance that the images have low-dimensional structure, there is only so many white pixels on screen at once.
Can we compress these videos (high diemnsional time series) into a series of (x,y) coordinates (low dimensinoal time series)?

If we assume that the underlying time series is a standard Gaussian process, then we can drop this into the standard variational
autoencoder framework, replacing the independent Gaussian prior, with a correalted-over-time Gaussian prior.


<iframe width="560" height="315" src="https://www.youtube.com/embed/riVhb6K_iMo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
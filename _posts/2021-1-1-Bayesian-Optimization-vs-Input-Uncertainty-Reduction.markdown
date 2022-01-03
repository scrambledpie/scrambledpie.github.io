---
layout: post
title:  "Bayesian Optimisation vs. Input Uncertainty Reduction"
date:   2021-1-3 17:46:02 +0100
categories: jekyll update
permalink: /BICO/
img: Pics/BICO/BICO-post.png # Add image post (optional)
code: https://github.com/scrambledpie/GPVAE
paper: https://arxiv.org/pdf/2006.00643.pdf
googlescholar: https://scholar.google.com/citations?view_op=view_citation&hl=en&user=LqIcJ6EAAAAJ&alert_preview_top_rm=2&citation_for_view=LqIcJ6EAAAAJ:u5HHmVD_uO8C
---

Juan Ungredda [Scholar][https://scholar.google.com/citations?user=LqIcJ6EAAAAJ&hl=en&oi=sra] [Homepage][https://warwick.ac.uk/fac/sci/mathsys/people/students/2017intake/ungredda/]

## Problem Setting

In simulation optimization, we try to optimize real world problems, queing systems, productions lines, traffics lights, by using computer simulations (instead of playing with real systems in the real world directly) as they are faster and less risky. Optimization algorithms often applied ot these simualtions to make find the best possible setting that can then be used in the real world. However, these simulators require calibration, tuning to a given applicaiton.

Mathematically, we assume the simulator is a simply an expensive black box function with two arguments _f(x, a)_, a decision variable to optimize, _x_, as well as a calbration parameter, _a_. We want to collect real world data to tune the callibration parameter _a_ and make the simulator _f(x, a)_ an accurate duplicate of the real world as possible, find _a*_. We also want to search for the best _x*_ that is the best input to the simulator

_x* = argmax f(x, a*)_


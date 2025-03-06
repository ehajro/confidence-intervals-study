## How to run
I have included an R Script that only contains the code and a markdown file where the code, the project write-up, and the output can be seen. I recommend running these files in the latest version of RStudio.
For the markdown file, you will have to knit the file to HTML or pdf.

## Overview
This is a project that aims to examine how the correlation of observations affects the empirical coverage probability of normal-based CIs for random observations based on samples of size n=100 drawn from a normal population using a time series (autoregressive) model.

## Simulation Plan

1. Draw samples of varying levels of dependence by using time-series data in an autoregressive (AR) model. Assume n=100 observations, and use rho values in increments of 0.2 starting at -1 and stopping at 1.
2. Calculate the sample mean of the n=100 observations.
3. Calculate the SE of the sample mean.
4. Determine the critical value associated with a 95% (normal-based) confidence level.
5. Calculate the lower and upper bounds of the 95% (normal-based) confidence interval.
6. Check if the CI includes the true mean value.
7. Return 3 objects: CI lower bound, CI upper bound, and the result of the check.
8. Compare the empirical coverage probability results of different rho values.

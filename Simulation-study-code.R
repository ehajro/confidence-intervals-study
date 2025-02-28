# the libraries
library(ggplot2)
library(dplyr)

# Generate AR(1) sample
generate_ar1_sample <- function(n, rho, mu=0, sigma=1) {
  epsilon <- rnorm(n, mean=0, sd=sigma)
  X <- rep(0, n)
  X[1] <- epsilon[1]
  for (t in 2:n) {
    X[t] <- rho * X[t-1] + epsilon[t]
  }
  return(X + mu)
}



# Compute 95% CI
compute_ci <- function(sample) {
  n <- length(sample)
  # mean of the sample
  mean_val <- mean(sample)
  # standard error calculation
  se <- sd(sample) / sqrt(n)
  # z scores for a 95% CI
  z <- abs(qnorm(0.05/2))
  # calculate lower and upper bounds of CI
  ci_lower <- mean_val - z * se
  ci_upper <- mean_val + z * se
  # check if the interval includes the true mean
  cover <- ci_lower <= 0 & 0 <= ci_upper
  return(c(ci_lower=ci_lower, ci_upper=ci_upper, cover=cover))
}


# function for one trial
trial <- function(n=100, rho_val) {
  # generate a sample of size n from a normal distribution 
  # with mean = 0, sd = 1 and with a correlation value rho_val
  sample <- generate_ar1_sample(n, rho=rho_val)
  compute_ci(sample)
}



set.seed(341)
# the values that rho will take
rho_values <- c(-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1)
# a vector to save the coverage values
coverage <- rep(0, 11)
# a variable for the index in coverage
i <- 1
for (x in rho_values) {
  # replicate the trial 5000 times
  results <- replicate(5000, trial(rho_val = x))
  # save the results in a data frame
  results <- data.frame(t(results))
  # column names in the dataframe
  names(results) <- c("lower", "upper", "cover")
  # empirical coverage rate
  coverage[i] <- mean(results$cover)
  # increment the index of coverage
  i <- i+1
}
# make a dataset 
coverage_data <- data.frame(coverage, rho_values)
# plot the coverage values against the rho values
plot <- coverage_data %>% ggplot(aes(y = coverage, x = rho_values)) + geom_line() + ggtitle("Empirical Coverage For Different Rho Values")

# see results
coverage_data
plot

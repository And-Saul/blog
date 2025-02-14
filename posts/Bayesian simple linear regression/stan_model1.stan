// Stan model with simulations for simple linear regression

data {
  int<lower=0> N;          // Number of observations
  vector[N] x;             // Predictor (height)
  vector[N] y;             // Response (weight)

}

parameters {
  real alpha;              // Intercept
  real beta;               // Slope
  real<lower=0> sigma;     // Standard deviation of the residuals
}

model {
  // Priors
  alpha ~ normal(75, 10);
  beta ~ lognormal(0, 1);
  sigma ~ exponential(0.1);    // Weakly informative prior for sigma

  // Likelihood
  y ~ normal( alpha + beta * x, sigma);
}

 generated quantities {
   vector[N] ysim;        // Predicted values

   for (i in 1:N) {
     ysim[i] = normal_rng(alpha + beta * x[i], sigma);
   }    
  }  // posterior distribution

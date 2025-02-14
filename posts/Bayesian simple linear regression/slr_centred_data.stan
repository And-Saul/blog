// data{
//   int n;
//   real y[n];
//   real x[n];
// }
// 
// parameters{
//   real alpha;
//   real beta;
//   real sigma;
// }
// 
// transformed parameters {
//   // Need to loop as vector * scalar = vector
//   real mu[n];
//   for(i in 1:n){
//     mu[i] = alpha + beta * x[i];
//   }
// }
// 
// model{
//   //Priors
//   alpha ~ normal(0, 100);
//   beta ~ normal(0, 100);
//   sigma ~ uniform(0, 100);
// 
//   //Likelihood
//     y ~ normal(mu, sigma);
// }

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

// transformed parameters {
//   // Need to loop as vector * scalar = vector
//   real mu[N];
//   for(i in 1:N){
//     mu[i] = alpha + beta * x[i];
//   }
// }
model {
  // Priors
  alpha ~ normal(75, 10);
  beta ~ lognormal(0, 1);
  sigma ~ exponential(5);    // Weakly informative prior for sigma

  // Likelihood
  y ~ normal( alpha + beta * x, sigma);
}

 generated quantities {
   vector[N] y_pred;        // Predicted values

   for (n in 1:N) {
     y_pred[n] = normal_rng(alpha + beta * x[n], sigma);
  }
}

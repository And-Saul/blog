
data {
  int<lower=0> N;
  vector[N] x;
  vector[N] y;
  int<lower=0> N_new;
  vector[N_new] x_new;
}
parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}
model {
  y ~ normal(alpha + beta * x, sigma);
}
generated quantities {
  vector[N_new] y_pred;
  for (n in 1:N_new) {
    y_pred[n] = normal_rng(alpha + beta * x_new[n], sigma);
  }
}

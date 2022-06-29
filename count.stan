data {
  int<lower=0> num_obs; // Number of observations
  int<lower=0> num_dyads; // Number of dyads
  int<lower=0> count[num_obs]; // Count corresponding to each observation 
  int<lower=0> dyad_ids[num_obs]; // Dyad ID corresponding to each data point
}

parameters {
  vector[num_dyads] log_edge; // Log edge weights for each dyad.
}

model {
  for (i in 1:num_obs){
    count[i] ~ poisson(exp(log_edge[dyad_ids[i]]));
  }
}

generated quantities {
  int count_pred[num_obs];
  for (i in 1:num_obs){
  count_pred[i] = poisson_rng(exp(log_edge[dyad_ids[i]]));
  }
}


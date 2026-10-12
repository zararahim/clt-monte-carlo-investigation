generate_population <- function(population, n) {
  if (population == "normal") {
    return(rnorm(n, mean = 0, sd = 1))
  }
  
  if (population == "die") {
    return(sample(1:6, size = n, replace = TRUE))
  }
  
  if (population == "exponential") {
    return(rexp(n, rate = 1))
  }
  
  if (population == "binomial") {
    return(rbinom(n, size = 5, prob = 0.10))
  }
  
  if (population == "cauchy") {
    return(rcauchy(n, location = 0, scale = 1))
  }
  
  stop("Unknown population")
}


calculate_skewness <- function(x) {
  mean(((x - mean(x)) / sd(x))^3)
}


calculate_excess_kurtosis <- function(x) {
  mean(((x - mean(x)) / sd(x))^4) - 3
}


run_population <- function(
    population,
    sample_sizes,
    student_id,
    B = 10000,
    focus_n = NULL
) {
  set.seed(student_id)
  
  results <- data.frame()
  
  for (n in sample_sizes) {
    sample_means <- replicate(
      B,
      mean(generate_population(population, n))
    )
    
    theoretical_mean <- if (population == "normal") 0 else NA
    theoretical_sd <- if (population == "normal") 1 else NA
    
    simulated_se <- sd(sample_means)
    theoretical_se <- theoretical_sd / sqrt(n)
    
    new_row <- data.frame(
      sample_size = n,
      simulated_mean = mean(sample_means),
      theoretical_mean = theoretical_mean,
      simulated_se = simulated_se,
      theoretical_se = theoretical_se,
      se_ratio = simulated_se / theoretical_se,
      skewness = calculate_skewness(sample_means),
      excess_kurtosis = calculate_excess_kurtosis(sample_means)
    )
    
    results <- rbind(results, new_row)
  }
  
  return(list(results = results))
}


results_table <- function(results) {
  knitr::kable(
    results,
    digits = 3,
    caption = "Simulation results"
  )
}
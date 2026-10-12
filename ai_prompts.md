# AI Prompt Record

## How I used AI

I used AI as a support tool while working on this project. It helped me with R and Quarto syntax, explained statistical ideas, formatting of markdown text, and suggested questions that guided my investigation. I checked the generated code against the project instructions and verified the results using my simulations, graphs, theoretical calculations, and numerical summaries. The final decisions and conclusions were based on my own analysis of the evidence.

## Standard Normal Analysis

### Iteration 1: Planning the simulation

**Prompt:**
I need to investigate the Central Limit Theorem using a standard normal population. What code should I start with, and how should I compare simulated results with theoretical results?

**AI response:**\
The simulation should repeatedly generate samples from a standard normal population, calculate each sample mean, and compare the simulated mean and standard error with the theoretical values.

**How I checked it:**\
I checked the project instructions and confirmed that I needed more than one graph. I needed multiple sample sizes, histograms, Q-Q plots, skewness, kurtosis, and standard-error comparisons.

------------------------------------------------------------------------

### Iteration 2: Creating a Reusable Simulation

**Improved prompt:**\
Help me create a reusable R simulation for a standard normal population. I want to investigate sample sizes 5, 10, 20, 30, 40, 50, 60, 70, 80, and 100, using 10,000 repetitions for each sample size. The results should include the simulated mean, theoretical mean, simulated standard error, theoretical standard error, standard-error ratio, skewness, and excess kurtosis.

**AI response:**\
The simulation was organized into reusable functions in a file named `R/clt_functions.R`. The main function was called `run_population()`. The normal analysis could then use:

``` r
fit <- run_population(
  "normal",
  sample_sizes,
  student_id,
  focus_n = c(5, 30, 100)
)

results <- fit$results
```

**How I checked the response:**\
I checked whether the function could be used in my Quarto document and whether the results included the measurements required by the project. I also checked that the sample size `n` was separate from the number of repetitions `B = 10,000`.

------------------------------------------------------------------------

### Iteration 3: Reconsidering the Meaning of n = 5

**Problem I found:**\
My report said that n = 5 was the sample size at which normality began. However, this wording may be inaccurate because the original population is already normal.

**Investigative prompt:**\
The table does not support the claim that normality begins at n = 5. Analyze whether n = 5 was really a turning point and explain what the results show instead.

**What I learned:**\
The sample mean of independent normal observations is exactly normal for every sample size. Therefore, n = 5 is only the smallest sample size I tested, not the point where normality began. The main change as n increases is that the standard error decreases and the distribution becomes narrower.

**How I improved the report:**\
I changed my conclusion to describe the standard normal population as a control case. I will use the other populations to investigate how quickly a non-normal population approaches normality.

------------------------------------------------------------------------

### Iteration 4: Are the Numerical Diagnostics Showing a Trend?

**Investigative prompt:**

In my standard normal simulation, skewness and excess kurtosis are close to zero for every sample size. Should I expect them to decrease as \(n\) increases, or should they remain roughly constant? Explain how Monte Carlo variation affects these estimates when I use 10,000 simulated means.

**What I checked:**

I compared the skewness and kurtosis columns across sample sizes and checked whether the small differences were larger than expected simulation noise.

**What I learned:**

Because the sampling distribution is exactly normal at every \(n\), the theoretical skewness and excess kurtosis are always zero. Small changes in the table are caused by Monte Carlo variation, not by the distribution becoming more normal.

------------------------------------------------------------------------

### Iteration 5: Are the Graphs Really Identical?

**Investigative prompt:**

My histograms for the standard normal sample means look almost identical at different sample sizes. Could this be caused by each histogram using its own x-axis? Create a better way to compare the shape and spread across sample sizes.

**What I checked:**

I compared the original histograms with a shared horizontal scale and examined the theoretical standard errors.

**What I learned:**

The shape remains normal, but the width decreases as \(n\) increases. Separate axes make the graphs look more identical than they really are. The standard error shows the narrowing more clearly than the individual histograms.

------------------------------------------------------------------------

### Iteration 6: Does \(n=30\) Matter for a Normal Population?

**Investigative prompt:**

The usual rule of thumb says \(n=30\), but my population is standard normal. Does \(n=30\) have any special meaning in this case? Use the exact distribution of the sample mean and my simulation results to explain the difference between becoming more normal and becoming narrower.

**What I checked:**

I compared the results at \(n=1\), \(n=5\), \(n=30\), and \(n=100\), focusing on shape and standard error separately.

**What I learned:**

\(n=30\) is not a normality threshold for a normal population. The sampling distribution is normal at \(n=1\). Increasing \(n\) only reduces the standard error from \(1/\sqrt{n}\).

------------------------------------------------------------------------

### Iteration 7: Did a New Seed Change the Conclusion?

**Investigative prompt:**

After completing one of my analyses, I reran it using a different seed. Did the exact results change? Did my scientific conclusion change? Explain what this tells you about Monte Carlo simulation and reproducibility.

**What I checked:**

The reproducibility check is included only in `normal.qmd`, after the seed-1069 table. I used the same sample sizes and 10,000 repetitions with seed 1070, which is the student ID plus one. The reported answer is still based on the seed-1069 table. The other reports were not rerun, and the second seed was not used to choose a sample size.

**What I learned:**

The exact simulated means and skewness values changed because a different seed creates a different random sample. However, the scientific conclusion did not change. Every sample size still met the rule, including sample size 1, and there was still no sample size where normality began. A Monte Carlo result is reproducible when the code, number of repetitions, and seed are fixed.

------------------------------------------------------------------------

### Iteration 8: What Does the Seed Actually Affect?

**Investigative prompt:**

If I rerun my standard normal simulation with a different seed, which results should change and which conclusions should remain the same? Explain how this would test reproducibility.

**What I checked:**

I compared the exact simulated means, standard errors, skewness, and kurtosis rather than expecting every decimal to be identical.

**What I learned:**

A different seed should slightly change the numerical values, but the overall conclusion should remain the same. The sampling distribution is normal for every sample size. This separates random simulation noise from the mathematical conclusion.

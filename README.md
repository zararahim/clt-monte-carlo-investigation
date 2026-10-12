# How Fast Does Normal Happen?

This project explores the Central Limit Theorem through Monte Carlo simulations in R. I wanted to see how the shape of a population affects the distribution of sample means and whether the common rule of thumb that \(n=30\) is enough works in every case.

I compared five required populations: a standard normal distribution, a six-sided die, an exponential distribution, a small binomial distribution, and a Cauchy distribution. I also included three extra-credit cases where the usual CLT assumptions are changed.

For each population, I repeatedly generated samples at different sample sizes and recorded the sample means. I compared the results with theoretical means and standard errors using histograms, Q–Q plots, skewness, kurtosis, and other numerical summaries. This helped me investigate not only when the sample means looked approximately normal, but also why some populations approached normality faster than others.

## Where to start

For a general understanding of the entire project, [`summary.qmd`](summary.qmd) explains the overall findings of this project. It compares the results from all five required populations and explains the main conclusions.

The rendered version of the summary is available here:

[Read the summary report](https://zararahim.github.io/clt-monte-carlo-investigation/summary.html)

The individual population reports are located in the `reports/` folder. Their rendered HTML versions are in the `docs/` folder.

## Project organization

- [`summary.qmd`](summary.qmd) gives the overall comparison.
- `reports/` contains the detailed population investigations.
- `reports/extra-credit/` contains the additional population investigations.
- `docs/` contains the rendered HTML reports.
- `R/clt_functions.R` contains shared R simulation and summary code.
- [`ai_prompts.md`](ai_prompts.md) records how I used, evaluated, and improved AI-generated assistance.
- `Project 1 - CLT.Rproj` is the RStudio project file.
- `.gitignore` prevents temporary RStudio and Quarto files from being uploaded.

The main question throughout the project is:

> What is the smallest sample size at which the sampling distribution of the sample mean is approximately normal, and is \(n=30\) enough?

## What counts as close enough to normal

For a population with a finite variance, a sample size counts as close enough to normal only when all four of these are true:

1. The absolute skewness of the 10,000 sample means is under 0.25.
2. The absolute excess kurtosis of those means is under 0.50. Excess kurtosis is the fourth moment minus 3, so a normal distribution is 0.
3. The simulated standard error is within 10% of the theoretical standard error. Where the observations are independent and a variance exists, that standard error is σ/√n.
4. When a formula for the skewness of the mean exists, that formula is also under 0.25 in absolute value. A simulated skewness under 0.25 does not pass while the formula is still over it.

The reported sample size is the smallest tested size after which every larger tested row passes. An isolated pass does not count if a later tested row fails.

Histograms and Q–Q plots are evidence alongside these numbers. They are not a separate cutoff.

But, there are two populations that do not fit this rule entirely. The Cauchy distribution has no finite variance, so the four conditions are not available. That report uses the median, the interquartile range, and the share of means outside −10 to 10, and the answer is that no finite sample size was found. The machine-failure times are dependent, so there is no σ/√n. That report still requires the skewness and excess kurtosis cutoffs, and it does not use the comparison with 1/√n as a pass or a fail.

## Required populations

| Population | Report |
|---|---|
| Standard normal | [`normal.html`](https://zararahim.github.io/clt-monte-carlo-investigation/normal.html) |
| Six-sided die | [`die.html`](https://zararahim.github.io/clt-monte-carlo-investigation/die.html) |
| Exponential | [`exponential.html`](https://zararahim.github.io/clt-monte-carlo-investigation/exponential.html) |
| Small binomial | [`binomial.html`](https://zararahim.github.io/clt-monte-carlo-investigation/binomial.html) |
| Cauchy | [`cauchy.html`](https://zararahim.github.io/clt-monte-carlo-investigation/cauchy.html) |

## Extra-credit populations

The extra-credit investigations examine cases where the usual CLT assumptions are changed:

- Non-identical Bernoulli trials
- Dependent machine-failure times
- A custom age-at-death distribution

These reports are located in `reports/extra-credit/`, with their rendered HTML versions in `docs/`.

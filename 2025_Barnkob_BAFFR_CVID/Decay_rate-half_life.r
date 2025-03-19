#CODE FOR CALCULATING DECAY RATES OF NEUTRALIZING ANTIBODIES OVER TIME

#The following code is for calculation of decay rates of neutralization against WT and Omicron variants of SARS-CoV-2 in the paper.
#Written by Mike B Barnkob, march 2025. 

#Please cite paper if used.

#--- PACKAGES

if (!require('tidyverse')) install.packages('tidyverse'); library('tidyverse')
if (!require('dplyr')) install.packages('dplyr'); library('dplyr')

#--- GENERATE EXAMPLE DATA

# Set seed for reproducibility
set.seed(42)

# Number of rows
n <- 100

# Generate the "Individual" column with random choices between "CVID" and "Control"
individuals <- sample(c("CVID", "Control"), size = n, replace = TRUE)

# Generate "DeltaDays" values between 5 and 300
delta_days <- sample(5:300, size = n, replace = TRUE)

# Generate "neutral_WT" values randomly selected from the specified list of values
neutral_WT_values <- c(10, 20, 40, 80, 160, 320, 640, 1280, 2560, 5120)
neutral_WT <- sample(neutral_WT_values, size = n, replace = TRUE)

# Create the dataframe
df_decay <- data.frame(
  Individual = individuals,
  DeltaDays = delta_days,
  neutral_WT = neutral_WT
)

#--- CALCULATE DECAY RATES AND HALFLIFE OF ANTIBODIES NEUTRALISING CAPACITY

# Fit linear models for each cohort (Individual)
decay_rates <- df_decay %>%
  group_by(Individual) %>%
  do({
    # Fit a linear model to the log-transformed neutral_WT
    model <- lm(log(neutral_WT) ~ DeltaDays, data = .)
    
    # Extract the decay rate (slope of the line) which is the coefficient for DeltaDays
    decay_rate <- coef(model)[2]
    
    # Return the decay rate in a tibble
    tibble(decay_rate = decay_rate)
  }) %>%
  ungroup()  # Remove the grouping

# Add a column to the decay_rates dataframe with the half-life calculation
decay_rates <- decay_rates %>%
  mutate(
    half_life = log(2) / abs(decay_rate)  # Use the formula: t_half = ln(2) / |lambda|
  )

# Print the decay rates and half-life values for each cohort
print(decay_rates)



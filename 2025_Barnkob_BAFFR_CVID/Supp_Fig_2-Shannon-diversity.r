#CODE FOR CALCULATING SHANNON DIVERSITY AMONG B-CELL SUBPOPULATIONS

#The following code is for calculation the Shannon Diversity used for Supplementary Figure 2 in the paper.
#Written by Mike B Barnkob, march 2025. 

#Please cite paper if used.

#--- PACKAGES

if (!require('tidyverse')) install.packages('tidyverse'); library('tidyverse')
if (!require('entropy')) install.packages('entropy'); library('entropy')
if (!require('dplyr')) install.packages('dplyr'); library('dplyr')

#--- GENERATE EXAMPLE DATA
# Replase this data with your own, where 'Clusters' are individual subpopulations, and 'Counts' are the number of events counted in that cluster.

set.seed(123)  # Set seed for reproducibility

# Number of rows (100 samples)
n <- 100

# Define possible values for 'Type' and 'Cluster'
types <- c("CVID", "Control")
clusters <- c("cd3_cd19_count", "plasmablast_count", "switched_mem_count", 
              "unswitched_mem_count", "mature", "naive", "cd27_cd38", "transitory")

# Generate the dataframe
df_bcell_shannon <- data.frame(
  Type = sample(types, n, replace = TRUE),  # Randomly sample between "CVID" and "Control"
  Cluster = sample(clusters, n, replace = TRUE),  # Randomly sample between the defined clusters
  LabID = paste0("S", sample(1:20, n, replace = TRUE)),  # Randomly assign 20 possible sample IDs
  Count = sample(100:50000, n, replace = TRUE)  # Randomly generate counts between 100 and 50,000
)

# Print first few rows to verify the dataframe
head(df_bcell_shannon)

#--- CALCULATE SHANNON DIVERSITY OF B CELL SUBPOPULATIONS

shannon_results <- df_bcell_shannon %>%
  group_by(LabID, Type) %>%   # Group by sample and cohort
  summarise(
    Shannon = entropy(Count, method = "ML"),  # Shannon entropy (natural log base e)
    .groups = "drop"  # Prevent nested grouping
  )

print(shannon_results)

#Visualize results
ggplot(shannon_results, aes(x = Type, y = Shannon, fill = Type)) +
  geom_boxplot(alpha = 0.4) +
  labs(title = "Shannon Diversity by Cohort on all B cell subsets") +
  ylab("Shannon Diversity") +
  scale_color_manual(values=c("#338FA4", "#8A1105")) +
  scale_fill_manual(values = c("#338FA4", "#8A1105")) +
  theme_minimal()

#Statistical test
wilcox.test(Shannon ~ Type, data = shannon_results)



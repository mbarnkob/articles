# Code related to *ARTICLE NAME*

## Introduction

The following files were used for data analysis in the paper *ARTICLE NAME*.

### Concerning decay-rate and half-life calculations:

*Decay rates*

The decay rate of neutralizing antibodies over time is calculated by fitting a linear regression model to the data, where the neutralization values (neutral_WT) are log-transformed, and the time (DeltaDays) is used as the independent variable. The relationship between antibody neutralization and time follows an exponential decay model:

y(t) = y0 ⋅ e<sup>−λt</sup>

Where:
- y(t) is the neutralization level at time t,
- y0 is the initial neutralization level (at t=0),
- λ is the decay rate (slope of the line),
- t is the time in days.

By taking the natural logarithm of both sides, we linearize the relationship:

ln⁡(y(t)) = ln⁡(y0) − λt

In this linearized equation, the slope of the line (λ) represents the decay rate. The decay rate indicates how quickly the neutralization ability of antibodies decreases over time.

*Half-Life Calculation*

The half-life is the time it takes for the neutralizing antibody level to reduce to half of its initial value. For exponential decay, the half-life is related to the decay rate (λ) by the following formula:

t<sub>1/2</sub> = ln⁡(2) / λ

Where:
- t<sub>1/2</sub> is the half-life,
- λ is the decay rate.

Given the decay rate obtained from the linear model, the half-life is calculated by dividing the natural logarithm of 2 by the absolute value of the decay rate. This provides the time it takes for the neutralization to decay by 50%.

### Concerning Shannon diversity calculations

The Shannon Diversity Index (H') is a measure of diversity that takes into account both the richness (the number of different categories, or clusters, in this case) and the evenness (the relative abundance of each category).

In the context the B-cell data presented in the paper, the clusters are the different categories (e.g., Naive B cells, Transitory B cells, Switched Memory B cells, ect), and the counts represent the abundance of cells in each cluster. 

The Shannon Diversity Index (H') is calculated using the following formula:

H′ = −∑p<sub>i</sub>⋅log⁡(p<sub>i</sub>)

Where:
- p<sub>i</sub>​ is the proportion of the total count that belongs to cluster i (i.e., the relative abundance of each cluster),
- The sum is taken over all clusters in the sample.

## Custom scripts

[01 - R script to organize images from Opera phenix.r](https://github.com/mbarnkob/articles/blob/main/2023%20-%20Bogetofte%20-%20Cell%20Reports/01%20-%20R%20script%20to%20organize%20images%20from%20Opera%20phenix.r)

[02 - ImageJ script for merging and prepping images.ijm](https://github.com/mbarnkob/articles/blob/main/2023%20-%20Bogetofte%20-%20Cell%20Reports/02%20-%20ImageJ%20script%20for%20merging%20and%20prepping%20images.ijm)

## Citation

If you use this code, please cite it as follows:

> Barnkob MB et al....

## References

(1) R Core Team (2022). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/.

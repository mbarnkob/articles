# Code related to Bogetofte et al, Cell Reports, 2023.

## Intro

The following two files were used to analyze images:

*"01 - R script to organize images from Opera phenix.r"* was used to merge and stich images aqcuired by a Opera Phenix Plus High-Content Screening System on a 96-well plate. 81 images were taken from each well and saved in the following file format: r01c01f01p01-ch1sk1fk1fl1. The first 12 characters were used to define row (r), column (c), image (f), position in image (p). Only one position was used and so the position was not used in this script. Note that the Phenix microscope labelles each individual image (f) in a well, in a particular way. In our case, using 81 images for each well, the first image taken (f01), is actually corresponding to the middle image of the entire, stiched well. The layout of the stiched image can be inputted in the script, with each number corresponding to an f number. This script was written in R (1). The output of this script is a working folder with a subfolder for each well. For the example file name above, the output folder would be r01c01, corresponding to row 1, column 1. 

*02 - ImageJ script for merging and prepping images.ijm* was used on the folders generate by the R script to remove lines and contrast problems between individual images. This script was written in ImageJ Java Macro format and can be run with FIJI/ImageJ, including the plugin "Resize", which can be downloaded here: http://bigwww.epfl.ch/algorithms/ijplugins/resize/. The output is one image pr. day pr. well, in a stack image that can then be analyzed further in ImageJ.

## Files

[01 - R script to organize images from Opera phenix.r](https://github.com/mbarnkob/articles/blob/main/2023%20-%20Bogetofte%20-%20Cell%20Reports/01%20-%20R%20script%20to%20organize%20images%20from%20Opera%20phenix.r)

[02 - ImageJ script for merging and prepping images.ijm](https://github.com/mbarnkob/articles/blob/main/2023%20-%20Bogetofte%20-%20Cell%20Reports/02%20-%20ImageJ%20script%20for%20merging%20and%20prepping%20images.ijm)

## Reference

(1) R Core Team (2022). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/.

If you use this code, please cite it as follows:

> Bogetofte H et al, "Post-translational proteomics platform identifies neurite outgrowth impairments in Parkinson’s disease GBA-N370S dopamine neurons", Cell Report, 2023.

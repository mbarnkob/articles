#Script to organize and merge TIFF images 
#=======================================

# Written by Mike Barnkob, 2022.

# To quote:
# 2023-01-12: Bogetofte H et al, "Post-translational proteomics platform identifies neurite outgrowth impairments in Parkinson’s disease GBA-N370S dopamine neurons", Cell Report, 2023.

# References:
# http://stackoverflow.com/questions/28682712/how-to-merge-images-into-one-file-in-a-defined-order
# http://gastonsanchez.com/Handling_and_Processing_Strings_in_R.pdf

### File structure

# Files used in the subsequent code has the following format: r01c01f01p01-ch1sk1fk1fl1
# r = row, c = column, 


### START UP

#Load libraries
if (!require('dplyr')) install.packages('dplyr'); library('dplyr')
if (!require('stringr')) install.packages('stringr'); library('stringr')
if (!require('png')) install.packages('png'); library('png')
if (!require('tiff')) install.packages('tiff'); library('tiff')
if (!require('raster')) install.packages('raster'); library('raster')
if (!require('rgdal')) install.packages('rgdal'); library('rgdal')
if (!require('rts')) install.packages('rts'); library('rts')

#Set Parent directory which contains all subfolders with files and make "merged" dir
parent.dir <- "C:/Data/Measurement 151/"   #- remember / at the end!
setwd(parent.dir)

save.into.folder <- "C:/Data/Working Folder 151/"   #- remember / at the end!
dir.create(save.into.folder)     #Make save-into-folder

### START ACTUAL IMAGE MERGE

setwd(parent.dir)
sub.directory.list <- list.dirs(full.names = FALSE, recursive = FALSE) #list with sub-directories

#Loop through sub-directories
for(k in 1:length(sub.directory.list)) {
  
  #Let user know whats going on
  cat(str_c("Folder: ", sub.directory.list[k]), fill=TRUE)
  cat("File #: ")
  
  #Set day number - gets incorporated into file-name of images
  day <- sub.directory.list[k]
  
  #Set working day folder
  working.dir.folder <- str_c(parent.dir,"/", sub.directory.list[k], "/", sep="")
  setwd(working.dir.folder)
  
  tiff.list <- list.files(pattern = ".tiff", full.names = FALSE) #list of tiff files
  head(tiff.list)

  #Generate list of sub-directories and create them in "save.into.folder" folder
  setwd(save.into.folder) #switch folder
  dir.list <- unique(str_sub(tiff.list, 1, 6))  #Identify individual images for each row/column, used below for layout
  
  sapply(dir.list, dir.create)  #create directories if not done so already
  setwd(working.dir.folder) #switch back to working dir

  #START MERGER by well name (= dir.list)

  for(j in 1:length(dir.list)) {     #loop through all unique wells in folder
    cat(dir.list[j], " ", sep = " ", fill=FALSE)
    file.list <- list.files(pattern = dir.list[j], full.names = FALSE)
    
    #Pair according to layout
    par(mar=c(0, 0, 0, 0), xaxs='i', yaxs='i') # setup layout
    
    layout(matrix(1:49, ncol=7, byrow=TRUE)) # layout of image files based how many images were taken pr well and their layout.Important that ncol = number of columns across well.
    for(i in c(2,3,4,5,6,7,8,
               15,14,13,12,11,10,9,
               16,17,18,19,20,21,22,
               28,27,26,1,25,24,23,
               29,30,31,32,33,34,35,
               42,41,40,39,38,37,36,
               43,44,45,46,47,48,49
    ))  
    {      
      
      img <- readTIFF(file.list[i])
      plot(NA,xlim=0:1,ylim=0:1,xaxt="n",yaxt="n", bty="n")
      rasterImage(img,0,0,1,1)
    }
    
    file.name <- paste(save.into.folder,dir.list[j],"/",dir.list[j], "-",day,".tiff",sep="") #generate file-name
    dev.print(tiff, file.name, width=3000, height=3000) #Print png file - set size here.
    dev.off()
    gc()
      
  }
}

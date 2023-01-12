//CREATE STACKS FROM LISTS OF IMAGES

//Written by Mike Barnkob, www.mikebarnkob.dk, 2022.

//To quote:
// Bogetofte H et al, "Post-translational proteomics platform identifies neurite outgrowth impairments in Parkinson’s disease GBA-N370S dopamine neurons", Cell Report, 2023.

//References:
//1. http://imagej.net/How_to_apply_a_common_operation_to_a_complete_directory
//2. http://forum.imagej.net/t/trouble-applying-recursive-processes-to-specific-folders/1135/4

//Choose directory made with R code
dir = getDirectory("Choose a Directory ");

//This function, defined below, will trawl through all sub-folders of choosen folder.
trawlDirectory(dir);

setBatchMode(true);

// Function for trawling through directory and finding sub-directories
function trawlDirectory(dir) {
    list = getFileList(dir);
    for (i=0; i<list.length; i++) {
        child = dir+list[i];
        if (File.isDirectory(child)) {  //found a directory
        	print(child);
        	
        	//run processFolder function
			processFolder(child, ".*plate.*");
        }
    }
}

// Function for processing all files in the given directory
function processFolder(dir, pattern) {
    list = getFileList(dir);

    // loops through filelist and find the pattern (ie image1, image2, ect) in the file names
    for (i=0; i<list.length; i++) {
        if (matches(list[i], pattern)) {
            print(list[i]); //prints a list of what files you actually get with this function
            filename = dir + list[i];
            open(filename);
			
			run("8-bit");		
			setMinAndMax(0, 40);
		    run("Apply LUT");
		
			// Resize - requires this plugin: http://bigwww.epfl.ch/algorithms/ijplugins/resize/
			//run("Resize ", "sizex=3000.0 sizey=1500.0 method=Least-Squares interpolation=Cubic unitpixelx=true unitpixely=true");

			run("Bandpass Filter...", "filter_large=40 filter_small=1 suppress=Vertical tolerance=1");
			
			run("Bandpass Filter...", "filter_large=40 filter_small=1 suppress=Horizontal tolerance=1");
			
			run("Sharpen");
			
			setOption("BlackBackground", true);
			run("Make Binary");

			//selectWindow(list[i]);
			//close();
			//selectWindow(list[i]);
	        
            print(substring(pattern, 2, lengthOf(pattern)-2));
            stackName = substring(list[i], 0, 6) + "-" + substring(pattern, 2, lengthOf(pattern)-2) + "-stacked"; //set name for later stack
        }
    }

	if (nImages !=0 ) {   //check if any files were found
		//Create a stack of all opened images
	    run("Images to Stack", "name="+stackName+"title=[] use");
	
		//Save image
		path = dir + stackName + ".tiff";
		saveAs("Tiff", path);
	
		//Close image
		close();
	}
}

setBatchMode(false);

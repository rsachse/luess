luess
=====

luess (landuse ecosystem services) is a R package for estimation of ecosystem services based on LPJmL model output. 
It provides functions to re-project CLUMondo model output to other geographic projections and to aggregrate CLUMondo 
grid cells to any other grid. The functionality encompasses the translation of CLUMondo cropland to LPJmL crop functional types. Functions returning ready to use LPJmL input files will be added soon.


Install the package
-----------------------------------------------------------------------------
The package depends on the R add-on packages: sp, rgdal, maptools, plot3D, RColorBrewer. 

You can install luess directly from github by using the devtools package. If you don't already have devtools
installed, type into the R command line:

	install.packages("devtools")
	
Afterwards you can install luess by typing:

	library(devtools)
	install_github("luess", username="rsachse")
	
The packages luess depends on will be downloaded and installed automatically from the CRAN Servers.
	
You also can download the source package or precompiled Windows binary packages 
from the [github releases page](https://github.com/rsachse/luess/releases).


Documentation
-----------------------------------------------------------------------------
You can get a documentation for all provided data sets and functions by typing into the R command line:
	
	library(luess)
	?luess

A package vignette is describing the resampling process of CLUMondo grids:
	
	browseVignettes(package="luess")

The vignettes can also be found in the directory tree of the package 
under [./inst/doc/](https://github.com/rsachse/luess/tree/master/inst/doc)

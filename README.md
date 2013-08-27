luess
=====

luess (landuse ecosystem services) is a R package for estimation of ecosystem services based on LPJmL model output. In its early state at the moment
it provides functions to re-project CLUMondo model output to other geographic projections and to aggregrate CLUMondo 
grid cells to any other grid.

It is intended to add further functionality to translate CLUMondo land use systems to LPJmL crop functional types and for
returning ready to use LPJmL input files.

The main purpose of the package will be to provide functions to derive and quantify ecosystem services from LPJmL model
output after driving LPJmL using translated CLUMondo model output.


Install the package
-----------------------------------------------------------------------------
The package depends on the R add-on packages: sp, rgdal, maptools, plot3D, RColorBrewer. You need to install them first.

	install.packages(c("sp", "rgdal", "maptools", "plot3D", "RColorBrewer"))

You can install the package directly from github by using the devtools package. If you don't already have devtools
installed, type into the R command line:

	install.packages("devtools")
	
Afterwards you can install luess by typing:

	library(devtools)
	install_github("luess", username="rsachse")

Documentation
-----------------------------------------------------------------------------
You can get a documentation for all provided data sets and functions by typing into the R command line:
	
	library(luess)
	?luess

A package vignette is describing the resampling process of CLUMondo grids:
	
	browseVignettes(package="luess")

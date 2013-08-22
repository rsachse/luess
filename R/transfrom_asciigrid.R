#' Reads an ASCII gridfile and performs spatial transformation
#'
#' The function reads a map from ASCII grid files and performs spatial transformation
#' to other projections. In most cases no regular grid results after reprojction, 
#' therefore the output in is a SpatialPointsDataFrame.
#'
#' @param file character string; file name
#' 
#' @param proj4_input character string; procjection arguments for the input Spatial Grid
#' 
#' @param proj4_output character string; projection arguments for the Spatial Data returned
#' 
#' @return returns a SpatialPointsDataFrame in most cases
#'
#' @author Rene Sachse \email{rene.sachse@@uni-potsdam.de}
#'
#' @keywords asc, asciigrid, map projection
#'
#' @seealso \code{\link[sp]{read.asciigrid}, \link[sp]{spTransform}} in package \pkg{sp}
transform_asciigrid <- function(
  file="land_systems.asc", 
  proj4_input="+proj=eck4 +lon_0=0 +x_0=0 +y_0=0",
  proj4_output="+proj=longlat",
  plotresult=FALSE
){
  print(paste("reading file", file))
  CLUeck4    <- read.asciigrid(file, proj4string=CRS(proj4_input))
  print("performing spatial re-projection")
  CLUlonglat <- spTransform(CLUeck4, CRS(proj4_output))
  if(plotresult == TRUE){
    print("plotting re-projected map")
    spplot(CLUlonglat, pch=".")
  }
  print(paste("finished processing", file))
  return(CLUlonglat)
}
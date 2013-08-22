#' Resampling of a high resolution grid for further use with a grid of coarser resolution
#'
#' The function reads a high resolution grid from an ascii grid file,
#' reprojects it and calculates the fractions of how much unique orginal
#' pixel types are covered by the coarser grid cells
#' 
#' @param grid_hr SpatialPointsDataFrame containing the geometry of cellcenters 
#' of the original high resolution grid. Other input geometries might be possible 
#' but have not been tested so far.
#'  
#' @param grid_lr SpatialGrid of the new grid
#' 
#' @param cells Only calculations for these cells will be returned (e.g. if these are cells
#' with landcover). If \code{NULL} values for all cells will be calculated.   
#' 
#' @return data frame containing...
#'
#' @author Rene Sachse \email{rene.sachse@@uni-potsdam.de}
#'
#' @keywords regridding, warping, aggregation, LPJmL, CLUMondo
#'
#' @seealso \code{\link[sp]{over} in package \pkg{sp}}
resample_grid <- function(grid_hr, grid_lr, cells=NULL){
  res         <- over(geometry(grid_hr), grid_lr)
  return(res)
}
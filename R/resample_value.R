#' Resampling by calculating the means of covered cell centers
#'
#' The function reads a spatialPointsDataFrame of high resolution
#' and a regular coarser grid. It than resamples by calculating the 
#' means of all covered cell centers within the grid cell of the 
#' coarser grid. The function will read only the first column of the 
#' data.frame.
#'
#' @param grid_hr spatialPointsDataFrame of high resultion with the value of interest in first column
#' 
#' @param grid_lr regular grid, used for resampling
#' 
#' @param cells vector of integers; indicating which cells of the the grid_lr should be returned. By that also the order of the output cells can be determined.
#'  
#' @return returns a SpatialPointsDataFrame
#'
#' @author Rene Sachse \email{rene.sachse@@uni-potsdam.de}
#'
#' @keywords resampling
#'
#' @seealso \code{\link[sp]{read.asciigrid}, \link[sp]{spTransform}} in package \pkg{sp}
resample_value <- function(grid_hr, grid_lr=generate_grid(), cells=lpj_long_clupos){
  clu     <- grid_hr
  #grid_lr <- generate_grid()
  res     <- over(geometry(clu), grid_lr)
  odat    <- data.frame(LU = clu@data[, 1], ID = res)
  oag     <- aggregate(list(LU=odat$LU), list(ID=odat$ID), mean)
  id      <- match(cells, oag[, 1])
  out     <- oag[id, 2]
  ## format output as spatialPointsDataFrame
  cr      <- CRSargs(grid_lr@proj4string)
  cc      <- SpatialPoints(cbind(coordinates(grid_lr)[cells, 1], coordinates(grid_lr)[cells, 2]), proj4string = CRS(cr))
  dd      <- SpatialPointsDataFrame(cc, data.frame(LU=out))
  row.names(dd@data) <- 1:nrow(dd@data)
  return(dd)
}
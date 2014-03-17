#' Calculates Grid Cell Areas for Grids with Geographical Coordinates
#'
#' The function estimates grid cell areas in km^2 for grids in geographical coordinates (long, lat).
#'
#' @param grid array, matrix or data.frame with two columns for longitude and lattitude of each grid cell
#' 
#' @param res numeric, resolution of the grid
#' 
#' @param dist.lat numeric, distance between two circles of lattitude in km
#'  
#' @return returns a vector with areas in km^2 for each grid cell
#'
#' @author Rene Sachse \email{rene.sachse@@uni-potsdam.de}
#'
#' @examples
#' areaCell(coordinates(lpjGrid))
#' 
areaCell <- function(grid, res=0.5, dist.lat=111) {
  ncell <- nrow(grid)
  y<-array(dist.lat*res, dim=ncell)#distance between two circles of latitude
  x<-array(0,dim=ncell) #distance between two meridians
  #calculate distance between two meridians according to latitude
  x <- 0.5 * cos(grid[,2]/180*pi)*pi/180*6371 #to calculate the distance between longitude
  # cell area km^2
  area.of.cell <- x * y
  return(area.of.cell)
}
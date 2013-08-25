#' Generates a Spatial Grid 
#'
#' The function generates a Spatial Grid. Default values
#' provide a grid fitting to the LPJ model requirements.
#' 
#' @param cellcentre.offset numeric; vector with the smallest coordinates 
#' for each dimension
#' 
#' @param cellsize numeric; vector with the cell size in each dimension
#' 
#' @param cells.dim integer; vector with number of cells in each dimension
#' 
#' @param proj4 A character string of projection arguments; 
#' the arguments must be entered exactly as in the PROJ.4 documentation
#' 
#' @return Returns a SpatialGrid.
#'
#' @author Rene Sachse \email{rene.sachse@@uni-potsdam.de}
#'
#' @keywords LPJmL, grid
#'
#' @seealso \code{\link[sp]{GridTopology}, \link[sp]{SpatialGrid}, \link[sp]{CRS}} 
#' in package \pkg{sp}
generate_grid <- function(
  cellcentre.offset=c(-179.75,-55.75), 
  cellsize=c(0.5,0.5), 
  cells.dim=c(720,280),
  proj4="+proj=longlat"
){
  y       <- GridTopology(cellcentre.offset, cellsize, cells.dim)
  lpjgrid <- SpatialGrid(grid=y,proj4string = CRS(proj4))
  return(lpjgrid)
}

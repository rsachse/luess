#' Identify positions of output grid cells in the input grid
#'
#' The function identifies positions of cells of the output grid within the input grid.
#' This is helpful in cases the output grid has a smaller number of cells than the input grid.
#' 
#' @param grid.in array with 2 dimensions or object of class SpatialGrid providing longitude and lattitude of 
#' cell centers of the input grid
#'  
#' @param grid.out array with 2 dimensions or object of class SpatialGrid providing longitude and lattitude of cell centers
#' of the output grid
#' 
#' @return vector of integers giving the positions of the output grid cells in the input grid
#'
#' @author Rene Sachse \email{rene.sachse@@uni-potsdam.de}
#'
#' @keywords grid, positions, grid cells, LPJ, LPJml, CLUMondo
#' 
#' @examples
#' mygrid       <- generate_grid()
#' pos_in_input <- matchInputGrid(coordinates(mygrid), lpj_short_outgrid)
#' plot(coordinates(mygrid)[pos_in_input,], col="green", pch=".")
matchInputGrid <- function(grid.in, grid.out){
  nn <- length(grid.out)/2
  pos_in_input <- array(data=NA,dim=nn)
  for (c in 1:nn){
    print(paste("matching cell", c, "of", nn))
    x_temp <- which(grid.in[,1]==grid.out[c,1], arr.ind=TRUE)
    y_temp <- which(grid.in[,2]==grid.out[c,2], arr.ind=TRUE)
    pos_in_input[c] <- intersect(x_temp, y_temp)
  }
  return(pos_in_input)                      
}
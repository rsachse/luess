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
#' @param datacolumn integer specifing which column of the SpaitalPointsDataFrame contains the
#' data of interest
#' 
#' @return list containing ...
#'
#' @author Rene Sachse \email{rene.sachse@@uni-potsdam.de}
#'
#' @keywords regridding, warping, aggregation, LPJmL, CLUMondo
#'
#' @seealso \code{\link[sp]{over} in package \pkg{sp}}
resample_grid <- function(grid_hr, grid_lr, cells=NULL, datacolumn=1){
  print("Resampling grid, this may take a while!")
  res         <- over(geometry(grid_hr), grid_lr)
  if(is.null(cells)){
    cells     <- unique(res)
  }
  uniquelu    <- sort(unique(grid_hr@data[,datacolumn]))
  out         <- lapply(
    cells, 
    function(x,res, datacolumn, grid_hr){
      #print(paste("processing cell", x-min(cells),"of", max(cells)-min(cells)))
      #(paste("processing cell", x))
      CLUcells <- which(res == x)
      out      <- grid_hr@data[CLUcells, datacolumn]
      return(out)
    }, 
    res=res, datacolumn=datacolumn, grid_hr=grid_hr
  )
  outlc      <- lapply(out, table)
  outlcall   <- sapply(
    outlc, 
    function(x,uniquelu){
      idLU          <- as.integer(unlist(dimnames(x)))+1
      lufrac        <- numeric(length(uniquelu))
      lufrac[idLU]  <- x/sum(x)
      return(lufrac)
    }, 
    uniquelu=uniquelu
  )
  print("Re-sampling finished.")
  return(
    list(
      cells    = cells, 
      xcoord   = coordinates(grid_lr)[cells,1], 
      ycoord   = coordinates(grid_lr)[cells,2],
      hrcells  = out,
      hrvalues = outlc,
      luid     = uniquelu,
      lufrac   = outlcall
    )
  )
}


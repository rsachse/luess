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
  res         <- over(geometry(grid_hr), grid_lr)
  #print(res)
  if(is.null(cells)){
    cells     <- unique(res)
  }
  #print(cells)
  out <- outlc <- outlcall <- list()
  for(i in 1:length(cells)){
    print(paste("aggregating land use systems for cell", i, "of", length(cells)))
    thecell       <- cells[i]
    CLUcells      <- which(res == thecell)
    #print(paste("id=",id))
    out[i]        <- list(grid_hr@data[CLUcells, datacolumn])
    outlc[i]      <- list(table(out[[i]]))
    uniquelu      <- sort(unique(grid_hr@data[,datacolumn]))
    #print(length(uniquelu))
    lufrac        <- numeric(length(uniquelu))
    idLU          <- as.integer(unlist(dimnames(outlc[[i]])))+1
    lufrac[idLU]  <- outlc[[i]]/sum(outlc[[i]])
    outlcall[i]   <- list(lufrac)
  }
  return(
    list(
      cells=cells, 
      xcoord=coordinates(grid_lr)[cells,1], 
      ycoord=coordinates(grid_lr)[cells,2],
      hrcells=out,
      hrvalues=outlc,
      luid=uniquelu,
      lufrac=outlcall
    )
  )
}


#' Disentangling multiple mosaics in a grid cell into their basic landuse classes 
#'
#' The function disentangles multiple mosaics into its basic land use classes of which
#' the mosaics in one grid cell consist.
#' 
#' @param data data.frame or SpatialPointsDataFrame providing 
#' fractions of the mosaic classes for each grid cell. 
#' Directly compatible to output of \code{\link[luess]{resample_grid}}.
#' Each row needs to sum up to exactly 1.
#' 
#' @param mosaicFractions data.frame providing fractions of basic land use classes
#' which form the mosaics. Needs to have as many rows as \code{data} has columns; 
#' each row needs to sum up to exactly 1.
#'  
#' @return 
#' if \code{data} is an object of class SpatialPointsDataFrame 
#' also an object of SpatialPointsDataFrame is returned. Otherwise
#' a simple matrix with basic landuse classes is returned.
#' 
#' @author Rene Sachse \email{rene.sachse@@uni-potsdam.de}
#'
#' @seealso \code{\link[luess]{resample_grid}} and \code{\link[sp]{SpatialPointsDataFrame}} 
#' in package \pkg{sp}
#'
#' @keywords LPJmL CLUMondo landuse mosaics
#'
#' @examples
#' mosaicFractions <- data.frame(
#'   PFT=c(0,.50,1,0,.10,.30),
#'   c1=c(.80,.30,0,0,.10,.70),
#'   c2=c(.20,0,0,.80,.10,0),
#'   g1=c(0,0,0,.10,.10,0),
#'   g2=c(0,.20,0,.10,.60,0)
#' )
#' 
#' grid_lr <- generate_grid(cellcentre.offset=c(-179.75, -59.75))
#' outMosaic <- resample_grid(smallarea, grid_lr)
#' 
#' outDisentangle <- aggregateMosaics(outMosaic, mosaicFractions)
#' 
#' outDisentangle
aggregateMosaics <- function(
  data, 
  mosaicFractions
)
{
  ## check if input is object of class SpatialPointsDataFrame
  isSpatial <- class(data) == "SpatialPointsDataFrame"
  if(isSpatial == TRUE){
    dat <- data@data
  } else {
    dat <- data
  }
  ## consistency checks
  if(ncol(dat) != nrow(mosaicFractions)){
    stop("mosaicFractions requires nrow(mosaicFractions) == ncol(data)")
  }
  #checkDataFractions <- any(rowSums(dat) !=1)
  #rsums <- rowSums(dat)
  #names(rsums) <- NULL
  #checkDataFractions <- all.equal(rsums, rep(1,nrow(dat)))
  #if(checkDataFractions == FALSE){
  #  stop("Data fractions don't sum up to 1!")
  #}
  #checkMosaicFractions <- any(rowSums(mosaicFractions) != 1)
  #if(checkMosaicFractions == TRUE){
  #  stop("Mosaic fractions don't sum up to 1!")
  #}
  ## matrix multiplication (this line is doing the actual transformation/aggregation)
  res <- as.matrix(dat) %*% as.matrix(mosaicFractions)
  ## return SpatialPointsDataFrame in case input was also spatial data
  if(isSpatial == TRUE){
    cr  <- CRSargs(data@proj4string)
    cc  <- SpatialPoints(coordinates(data), proj4string = CRS(cr))
    res <- SpatialPointsDataFrame(cc, as.data.frame(res))
  }
  ## return results
  return(res)
}
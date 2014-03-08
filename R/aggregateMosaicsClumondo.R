#' Aggregating CLUMondo mosaics to basic landuse classes (natveg, pasture, cropland) for the whole globe
#'
#' The function aggregates CLUMondo mosaics into its basic land use classes: natveg, pasture and cropland. 
#' Since CLUMondo is split in 24 world regions, the function applies the specific mosaic tables for each region.
#' 
#' @param data SpatialPointsDataFrame providing 
#' fractions of the mosaic classes for each grid cell. 
#' Directly compatible to output of \code{\link[luess]{resample_grid}}.
#' Each row needs to sum up to exactly 1.
#' 
#' @param mosaics data.frame providing fractions of basic land use classes
#' which form the mosaics. Needs to have as many rows as \code{data} has columns; 
#' each row needs to sum up to exactly 1.
#'  
#' @param worldregions SpatialPointsDataFrame providing the column CLUWORDREGION. Needs to have same order as \code{data}. 
#' Region names in this column need to correspond to dimnames in \code{mosaics}.
#'  
#' @param fixUS logical; when TRUE the lookup table of Canada is used for the USA. This is just a workaround until the falsy 
#' lookup table for the US can be replaced by a working one.
#'  
#' @return 
#' Returns an object of class SpatialPointsDataFrame. 
#' 
#' @author Rene Sachse \email{rene.sachse@@uni-potsdam.de}
#'
#' @seealso \code{\link[luess]{aggregateMosaics}}, \code{\link[luess]{resample_grid}} 
#' and \code{\link[sp]{SpatialPointsDataFrame}} 
#' in package \pkg{sp}
#'
#' @keywords LPJmL CLUMondo landuse mosaics
#'
#' @examples
#' out <- resample_grid(CLUlonglat, generate_grid(), cells=lpj_long_clupos)
#' cluAgg <- aggregateMosaicsClumondo(out, CLUMosaics, lpjGrid)
#' gridPlot(cluAgg@@data[,"pasture"], zlim=c(0,1), main="pasture")
#' gridPlot(cluAgg@@data[,"cropland"], zlim=c(0,1), main="cropland")
#' gridPlot(cluAgg@@data[,"natveg"], zlim=c(0,1), main="natveg")
#' gridPlot(rowSums(cluAgg@@data), main="cover")
aggregateMosaicsClumondo <- function(data, mosaics, worldregions, fixUS=TRUE){
  id <- match(paste(coordinates(worldregions)[,1], coordinates(worldregions)[,2]), paste(coordinates(data)[,1], coordinates(data)[,2]))
  checkcoords <- identical(id, 1:67420)  
  if(checkcoords == FALSE){
    stop("Order of coordinates of data and worldregions not the same!")
  }
  
  if(fixUS==TRUE){
    ##DIRTY HACK!!! Fix USA look up table for the moment
    #cropUS <- mosaics[,"crop","USA"]
    #pastUS <- mosaics[,"pasture","USA"]
    #mosaics[,"crop","USA"] <- pastUS
    #mosaics[,"pasture","USA"] <- cropUS
    ## Just using the look-up table of Canada
    mosaics[,,"USA"] <- mosaics[,,"Canada"] 
    ##
  }
  nrOfRegions <- dim(mosaics)[3]
  cluAgg <- array(NA, dim=c(nrow(data),3), dimnames=list(1:nrow(data),c("natveg", "cropland", "pasture")))
  
  for(i in 1:nrOfRegions){
    cluOri              <- mosaics[,4:8,i]
    theRegion           <- dimnames(mosaics)[[3]][i]
    theRows             <- which(worldregions@data$CLUWORLDREGION == theRegion)
    message(paste("Processing CLUMondo World Region Nr.", i, "of", nrOfRegions, ":", theRegion))
    cluUse              <- array(NA, dim=c(dim(mosaics)[1],3), dimnames=list(dimnames(mosaics)[[1]],c("natveg", "cropland", "pasture")))
    cluUse[,"cropland"] <- (cluOri[,"crop"]) 
    cluUse[,"pasture"]  <- (cluOri[,"pasture"])
    cluUse[,"natveg"]   <- (1 - cluUse[,"cropland"] - cluUse[,"pasture"])
    cluAgg[theRows,]    <- aggregateMosaics(data@data[theRows,], cluUse)
  }
  
  message("Create SpatialPointsDataFrame.")
  coords <- coordinates(data)
  row.names(coords) <- row.names(cluAgg)
  cluAgg <- SpatialPointsDataFrame(coords, as.data.frame(cluAgg), proj4string = CRS("+proj=longlat +ellps=WGS84"))
  message("Aggregation finished.")
  return(cluAgg)
}

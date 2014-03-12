#' Writes a new binary LPJmL landuse input file 
#'
#' The function writes a new binary LPJmL landuse input file.
#'   
#' @param data array with the dimenions \code{[years, pixels, cfts]}   
#'   
#' @param fileOut A character string naming the file to write to.
#' 
#' @param header a list providing the 10 elements of a valid header: 
#' \enumerate{
#'   \item header name
#'   \item header version
#'   \item order
#'   \item firstyear
#'   \item nyear
#'   \item firstcell
#'   \item ncell 
#'   \item nbands
#'   \item resolution
#'   \item scaling
#'  }
#' 
#' @author PIK, modified by Rene Sachse (rene.sachse@@uni-potsdam.de)
#'
#' @keywords LPJ, LPJmL
writeLpjLanduse <- function(data, fileOut, header){
  fileOut <- file(fileOut, "wb")
  writeLpjHeader(fileOut, header)
  nYears <- dim(data)[1]
  for(i in 1:nYears){
    message(paste("Writing year",i,"of",nYears,"."))
    ## transpose rows=cfts, columns=pixels
    landuse <- t(data[i,,]) 
    ## as.vector first reads columns 
    ## -> all cfts for a pixel than next pixel
    writeBin(as.vector(as.integer(landuse)), fileOut, size=2) 
  }
  close(fileOut)
  message("Done.")
}
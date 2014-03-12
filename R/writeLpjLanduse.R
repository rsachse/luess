#' Writes a new binary LPJmL landuse input file 
#'
#' The function writes a new or appends a binary LPJmL landuse input file. 
#'   
#' @param data Array with three dimensions: \code{[years, pixels, cfts]}.   
#'   
#' @param fileOut A character string naming the file to write to.
#' 
#' @param header A list providing the 10 elements of a valid header: 
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
#'  The header is only needed when \code{where} is \code{NULL} otherwise no new file
#'  needs to be created and the existing file already has a header.
#' 
#' @param append logical, specifying whether the data should be appended to an existing file
#' or not. If \code{FALSE} a new file will be created.
#' 
#' @author Rene Sachse (rene.sachse@@uni-potsdam.de)
#'
#' @keywords LPJ, LPJmL
writeLpjLanduse <- function(data, fileOut, header=NULL, append=FALSE){
  if(append == FALSE){
    mode <- "wb"
  } else {
    mode <- "ab"
  }
  fileOut <- file(fileOut, mode)
  if(append==FALSE){
    writeLpjHeader(fileOut, header)
  } 
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
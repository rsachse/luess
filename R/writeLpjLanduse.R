#' Writes a new binary LPJmL landuse input file 
#'
#' The function writes a new or appends a binary LPJmL landuse input file. 
#'   
#' @param data Array with three dimensions: \code{[years, pixels, cfts]}.   
#'   
#' @param fileOut A character string naming the file to write to.
#' 
#' @param header When \code{NULL} no header is written and data is appended to an existing file. Otherwise a
#' list providing the 10 elements of a valid header need to be given: 
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
#' @author Rene Sachse (rene.sachse@@uni-potsdam.de)
#'
#' @keywords LPJ, LPJmL
writeLpjLanduse <- function(data, fileOut, header=NULL){
  if(!is.null(header)){
    fileCon <- file(fileOut, "wb")
    writeLpjHeader(fileCon, header)
    close(fileCon)
  } 
  fileCon <- file(fileOut, open="ab")
  nYears <- dim(data)[1]
  for(i in 1:nYears){
    message(paste("Writing year",i,"of",nYears,"."))
    ## transpose rows=cfts, columns=pixels
    landuse <- t(data[i,,]) 
    ## as.vector first reads columns 
    ## -> all cfts for a pixel than next pixel
    writeBin(as.vector(as.integer(landuse)), fileCon, size=2) 
  }
  close(fileCon)
  message("Done.")
}
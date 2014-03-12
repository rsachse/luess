#' Writes the header to a new binary LPJmL input file 
#'
#' The function writes the header of a new binary LPJmL input file.
#'   
#' @param fileOut A \code{\link{connections}} object pointing to the file to write the header to.
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
writeLpjHeader <- function(fileOut, header){
  writeChar(header$name, fileOut, eos=NULL)         # header name
  writeBin(as.integer(1), fileOut, size=4)          # header version
  writeBin(as.integer(1), fileOut, size=4)          # order
  writeBin(as.integer(header$fy), fileOut, size=4)  # firstyear
  writeBin(as.integer(header$ny), fileOut, size=4)  # nyear
  writeBin(as.integer(0),fileOut, size=4)           # firstcell
  writeBin(as.integer(header$nc), fileOut, size=4)  # ncell
  writeBin(as.integer(header$nb), fileOut, size=4)  # nbands
  writeBin(as.double(header$r), fileOut, size=4)    # resolution
  writeBin(as.double(header$b), fileOut, size=4)    # scaling  
}
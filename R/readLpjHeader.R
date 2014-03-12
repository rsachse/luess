#' Reads the header of binary LPJmL input files
#'
#' The function reads the header of binary LPJmL input files.
#'   
#' @param fileIn character string naming the path and file to read the header from.
#' 
#' @param nChar integer, number of chars of the header name
#' 
#' @return Returns a list with 10 elements:
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
readLpjHeader <- function(fileIn, nChar=7){
  fileIn      <- file(fileIn, "rb")
  header      <- list()
  header$name <- readChar(fileIn, nChar)                     # header name
  header$v    <- readBin(fileIn,  integer(), n=1, size=4)    # header version
  header$o    <- readBin(fileIn,  integer(), n=1, size=4)    # order 1=cellyear
  header$fy   <- readBin(fileIn,  integer(), n=1, size=4)    # firstyear
  header$ny   <- readBin(fileIn,  integer(), n=1, size=4)    # nyear
  header$fc   <- readBin(fileIn,  integer(), n=1, size=4)    # firstcell
  header$nc   <- readBin(fileIn,  integer(), n=1, size=4)    # ncell
  header$nb   <- readBin(fileIn,  integer(), n=1, size=4)    # nbands
  header$r    <- readBin(fileIn,  double(),  n=1, size=4)    # resolution
  header$b    <- readBin(fileIn,  double(),  n=1, size=4)    # scaling
  close(fileIn)
  return(header)   
}
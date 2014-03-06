#' Reads binary LPJmL input and output files
#'
#' The function reads binary LPJmL input and output files into an array structure.
#'
#' @param filename character string; file name
#' 
#' @param first_year_ts integer; first year of the time series which should be read in
#' 
#' @param last_year_ts integer; last year of the time series which should be read in
#' 
#' @param first_year integer; first year which the data file contains
#' 
#' @param nband integer; number of data bands (e.g. number of CFTs or PFTs)
#' 
#' @param sizeof_data integer; size of each data entry in bytes
#' 
#' @param typeof_data \code{integer()} or \code{double()}; depends on \code{sizeof_data}.
#'  If \code{sizeof_data=2} than only \code{integer()} is possible. 
#' 
#' @param sizeof_header integer; size of the header in bytes
#' 
#' @param ncell integer, number of pixels
#' 
#' @param byrow logical; determines if bands are sorted by cells (\code{TRUE}) like 
#' the landuse input or by bands (\code{FALSE}) which is standard for the output files.
#' 
#' @return returns an array of dimensions \code{[years, pixels, nbands]}
#'
#' @author Rene Sachse \email{rene.sachse@@uni-potsdam.de}
#'
#' @keywords LPJml, binary data
#'
#' @seealso \code{\link{seek}, \link{readBin}}
#' 
#' @examples
#' \dontrun{
#'   cftfrac <- getLPJ("landuse.bin", 2000, 2000, 1700, 32, 2, sizeof_header=43)
#'   pftfrac <- getLPJ("fpc.bin", 2000, 2000, 1901, 10, 4, double(), byrow=FALSE)
#' }
getLPJ <- function(
  filename, 
  first_year_ts, 
  last_year_ts, 
  first_year, 
  nband,
  sizeof_data,
  typeof_data=integer(),
  sizeof_header = 0,
  ncell = 67420,
  byrow=TRUE
){
  ## set up
  #first_year_ts <- 2000
  #first_year <- 1700
  #last_year_ts <- 2000
  #sizeof_data = 2
  nyear_ts <- last_year_ts-first_year_ts+1
  start_rel_ts <- first_year_ts - first_year
  #ncell <- 67420
  #nband <- 32  
  
  ## empty data structure
  ts_frac <- array(data=NA,dim=c(nyear_ts,ncell,nband))
  
  ## connecting to file
  zz <- file(filename,"rb")
  
  ## put pointer to starting value of time series of interest
  seek(zz, where=start_rel_ts*nband*ncell*sizeof_data + sizeof_header, origin="start")
  
  ## read binary data from file
  for(y in 1:nyear_ts){
    ts_frac[y,,] <- matrix(
      readBin(
        zz,
        typeof_data,
        n=ncell*nband, 
        size=sizeof_data
      ),
      nrow=ncell,
      ncol=nband,
      byrow=byrow
    )
  }
  close(zz)
  return(ts_frac)
}



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


fillArray <- function(dat, nYears=35, nPixels=67420, nCfts=32){
  res <- array(NA, dim=c(nYears,nPixels,nCfts))
  for(i in 1:nYears){
    res[i,,] <- dat[1,,]
  }
  return(res)
}


## new header
## Number of years must match sum of all years appended!
cftHeader <- readLpjHeader("/iplex/01/2012/open/input_VERSION2/cft1700_2005_bioenergy_sc.bin")
cftHeader$ny <- 341

## write first 100 years with header
cftFrac   <- getLPJ("/iplex/01/2012/open/input_VERSION2/cft1700_2005_bioenergy_sc.bin", 1700, 1999, 1700, 32, 2, sizeof_header=43)
writeLpjLanduse(cftFrac, "landuseOECD2000_ny_341.bin", header=cftHeader)

## append secend 100 years
#rm(cftFrac)
#cftFrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 1801, 1900, 1700, 32, 2, sizeof_header=43)
#writeLpjLanduse(cftFrac, "N:/vmshare/landuse/landuseOECD2000_ny_341.bin", header=NULL)

## append third 100 years
#rm(cftFrac)
#cftFrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 1901, 1999, 1700, 32, 2, sizeof_header=43)
#writeLpjLanduse(cftFrac, "N:/vmshare/landuse/landuseOECD2000_ny_341.bin", header=NULL)


## now duplicate file by hand as often as needed


## append new landuse data
#load("out_trans_2_5.rda")
#load("out_trans_2_5_2040.rda")

#lu2000 <- fillArray(out_trans_2_5, nYears=41)
#lu2040 <- fillArray(out_trans_2_5_2040, nYears=41)

#writeLpjLanduse(lu2000, "landuseOECD2000_v02.bin", header=NULL)
#writeLpjLanduse(lu2040, "landuseOECD2040_v02.bin", header=NULL)

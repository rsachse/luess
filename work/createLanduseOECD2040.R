require(luess)

## new header
## Number of years must match sum of all years appended!
cftHeader <- readLpjHeader("N:/vmshare/landuse/landuse.bin")
cftHeader$ny <- 341

## write first 100 years with header
cftFrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 1700, 1800, 1700, 32, 2, sizeof_header=43)
writeLpjLanduse(cftFrac, "N:/vmshare/landuse/landuseOECD2000_ny_341.bin", header=cftHeader)

## append secend 100 years
rm(cftFrac)
cftFrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 1801, 1900, 1700, 32, 2, sizeof_header=43)
writeLpjLanduse(cftFrac, "N:/vmshare/landuse/landuseOECD2000_ny_341.bin", header=NULL)

## append third 100 years
rm(cftFrac)
cftFrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 1901, 1999, 1700, 32, 2, sizeof_header=43)
writeLpjLanduse(cftFrac, "N:/vmshare/landuse/landuseOECD2000_ny_341.bin", header=NULL)


## now duplicate file by hand as often as needed


## append new landuse data
load("out_trans_2_5.rda")
load("out_trans_2_5_2040.rda")


fillArray <- function(dat, nYears=35, nPixels=67420, nCfts=32){
  res <- array(NA, dim=c(nYears,nPixels,nCfts))
  for(i in 1:nYears){
    res[i,,] <- dat[1,,]
  }
  return(res)
}

lu2000 <- fillArray(out_trans_2_5, nYears=41)
lu2040 <- fillArray(out_trans_2_5_2040, nYears=41)


writeLpjLanduse(lu2000, "N:/vmshare/landuse/landuseOECD2000_v02.bin", header=NULL)
writeLpjLanduse(lu2040, "N:/vmshare/landuse/landuseOECD2040_v02.bin", header=NULL)


cft2000 <- getLPJ("N:/vmshare/landuse/landuseOECD2000_v02.bin", 2000, 2040, 1700, 32, 2, sizeof_header=43)
gridPlot(cft2000[1,,1])
gridPlot(cft2000[41,,1])

cft2040 <- getLPJ("N:/vmshare/landuse/landuseOECD2040_v02.bin", 2000, 2040, 1700, 32, 2, sizeof_header=43)
gridPlot(cft2040[1,,1])
gridPlot(cft2040[41,,1])

identical(cft2000[7,,1],cft2000[41,,1])
identical(cft2040[7,,1],cft2040[41,,1])

readLpjHeader("N:/vmshare/landuse/landuseOECD2000_v02.bin")
readLpjHeader("N:/vmshare/landuse/landuseOECD2040_v02.bin")



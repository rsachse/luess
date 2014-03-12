require(luess)

load("out_trans_2_5.rda")
load("out_trans_2_5_2040.rda")

#cftFrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 2000, 2000, 1700, 32, 2, sizeof_header=43)

fillArray <- function(dat, nYears=35, nPixels=67420, nCfts=32){
  res <- array(NA, dim=c(nYears,nPixels,nCfts))
  for(i in 1:nYears){
    res[i,,] <- dat[1,,]
  }
  return(res)
}

lu2000 <- fillArray(out_trans_2_5)
lu2040 <- fillArray(out_trans_2_5_2040)


writeLpjLanduse(lu2000, "N:/vmshare/landuse/landuseOECD2000.bin", append=TRUE)
writeLpjLanduse(lu2040, "N:/vmshare/landuse/landuseOECD2040.bin", append=TRUE)


cft2000 <- getLPJ("N:/vmshare/landuse/landuseOECD2000.bin", 2000, 2040, 1700, 32, 2, sizeof_header=43)
gridPlot(cft2000[1,,1])
gridPlot(cft2000[41,,1])

cft2040 <- getLPJ("N:/vmshare/landuse/landuseOECD2040.bin", 2000, 2040, 1700, 32, 2, sizeof_header=43)
gridPlot(cft2040[1,,1])
gridPlot(cft2040[41,,1])



identical(cft2000[7,,1],cft2000[41,,1])
identical(cft2040[7,,1],cft2040[41,,1])

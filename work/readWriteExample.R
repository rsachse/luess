cftFrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 2000, 2005, 1700, 32, 2, sizeof_header=43)
cftHeader <- readLpjHeader("N:/vmshare/landuse/landuse.bin")

## create completely new data set
writeLpjLanduse(cftFrac, "landuse-new.bin", cftHeader)
cftNew <- getLPJ("landuse-new.bin", 2000,2005,2000,32,2,sizeof_header=43)
identical(cftNew, cftFrac)


## append a data set
writeLpjLanduse(cftFrac, "landuse-new.bin", append=TRUE)
cftNew <- getLPJ("landuse-new.bin", 2000,2011,2000,32,2,sizeof_header=43)
gridPlot(cftNew[7,,1])
identical(cftNew[1:6,,], cftNew[7:12,,])


## overwrite years.

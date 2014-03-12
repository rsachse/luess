cftFrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 2000, 2005, 1700, 32, 2, sizeof_header=43)
cftHeader <- readLpjHeader("N:/vmshare/landuse/landuse.bin")
writeLpjLanduse(cftFrac, "landuse-new.bin", cftHeader)
cftNew <- getLPJ("landuse-new.bin", 2000,2005,2000,32,2,sizeof_header=43)
identical(cftNew, cftFrac)



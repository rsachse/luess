## read CLUMondo world region assignment of pixels
dat <- read.csv2("worldregion.csv", stringsAsFactors=FALSE)
dat <- dat[,-c(1:2)]
dat <- dat[order(dat$LPJ_ID),] ## sort for LPJ_ID


## create SpatialPointsDataFrame for the LPJ grid containing country and region information
lpjGrid <- SpatialPointsDataFrame(dat[,2:3], dat[,c(1,4:ncol(dat))], proj4string = CRS("+proj=longlat +ellps=WGS84"))
#save(lpjGrid, file="lpjGrid.Rd")


## resample CLUMondo map
out <- resample_grid(CLUlonglat, generate_grid(), cells=lpj_long_clupos)


## checking if coordinates are consistent
xdiff <- coordinates(lpjGrid)[,1] - coordinates(out)[,1]
ydiff <- coordinates(lpjGrid)[,2] - coordinates(out)[,2]

xdiff <- coordinates(lpjGrid)[,1] - lpj_ingrid[,1]
ydiff <- coordinates(lpjGrid)[,2] - lpj_ingrid[,2]

id <- match(paste(coordinates(lpjGrid)[,1], coordinates(lpjGrid)[,2]), paste(coordinates(out)[,1], coordinates(out)[,2]))
identical(id, 1:67420)


## aggregate test
cluOri <- CLUMosaics[,4:8,1]
cluUse <- array(NA, dim=c(30,3), dimnames=list(dimnames(cluOri)[[1]],c("natural", "cropland", "pasture")))
cluUse[,"cropland"] <- round(cluOri[,"crop"],8) 
cluUse[,"pasture"]  <- round(cluOri[,"pasture"],8)
cluUse[,"natural"]  <- (1 - cluUse[,"cropland"] - cluUse[,"pasture"])#round(cluOri[,"builtup"] + cluOri[,"tree"] + cluOri[,"bare"],8)-
                             

cluAgg <- aggregateMosaics(out, cluUse)

gridPlot(cluAgg@data[,"pasture"], zlim=c(0,1), main="pasture")
gridPlot(cluAgg@data[,"cropland"], zlim=c(0,1), main="cropland")
gridPlot(cluAgg@data[,"natural"], zlim=c(0,1), main="natural")

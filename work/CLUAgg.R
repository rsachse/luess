## load package
require(luess)
require(RColorBrewer)
myPalette <- colorRampPalette(rev(c(brewer.pal(11, "RdYlBu"), "darkblue")))


### workaround: using Canada look up table for USA
load("./clu2000_clu2040.rda")

cftfrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 2000, 2000, 1700, 32, 2, sizeof_header=43)
pftfrac   <- getLPJ("N:/vmshare/landuse/fpc.bin", 2000, 2000, 1901, 10, 4, double(), byrow=FALSE)
natvegLPJ <- pftfrac[1,,1] + rowSums(cftfrac[1,,])/1000

cluAgg      <- aggregateMosaicsClumondo(out2000, CLUMosaics, lpjGrid)
cropLPJ <- (rowSums(cftfrac[1,,]) - cftfrac[1,,14])/1000
cropCLU <- cluAgg@data[,"cropland"]
cropDelta <- cropCLU - cropLPJ

#par(mfrow=c(3,1))
gridPlot(cropLPJ, main="Cropland without pasture MICRA2000")

png("cropland_canada_for_US.png", width=3000, height=2000, res=600)
gridPlot(cropCLU, zlim=c(0,1), main="Cropland CLUMondo")
dev.off()

png("delta_cropland_canada_for_US.png", width=3000, height=2000, res=600)
gridPlot(cropDelta, main=expression(paste(Delta,"cropland = ",CLUMondo-MICRA2000)), zlim=c(-1,1),col=myPalette(100))
dev.off()


pastLPJ <- cftfrac[1,,14]/1000
pastCLU <- cluAgg@data[,"pasture"]
pastDelta <- pastCLU - pastLPJ

png("pasture_canada_for_US.png", width=3000, height=2000, res=600)
gridPlot(pastCLU, zlim=c(0,1), main="Pasture CLUMondo")
dev.off()

png("delta_pasture_canada_for_US.png", width=3000, height=2000, res=600)
gridPlot(pastDelta, main=expression(paste(Delta,"pasture = ",CLUMondo-MICRA2000)), zlim=c(-1,1),col=myPalette(100))
dev.off()


################# old

## read CLUMondo world region assignment of pixels
dat <- read.csv2("worldregion.csv", stringsAsFactors=FALSE)
dat <- dat[,-c(1:2)]
dat <- dat[order(dat$LPJ_ID),] ## sort for LPJ_ID


## create SpatialPointsDataFrame for the LPJ grid containing country and region information
lpjGrid <- SpatialPointsDataFrame(dat[,2:3], dat[,c(1,4:ncol(dat))], proj4string = CRS("+proj=longlat +ellps=WGS84"))
save(lpjGrid, file="lpjGrid.rda")


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
cluOri <- CLUMosaics[,4:8,"USA"]
cluUse <- array(NA, dim=c(30,3), dimnames=list(dimnames(cluOri)[[1]],c("natveg", "cropland", "pasture")))
cluUse[,"cropland"] <- round(cluOri[,"crop"],8) 
cluUse[,"pasture"]  <- round(cluOri[,"pasture"],8)
cluUse[,"natveg"]  <- (1 - cluUse[,"cropland"] - cluUse[,"pasture"])#round(cluOri[,"builtup"] + cluOri[,"tree"] + cluOri[,"bare"],8)-
cluAgg <- aggregateMosaics(out, cluUse)
gridPlot(cluAgg@data[,"natveg"], zlim=c(0,1), main="natveg")

gridPlot(cluAgg@data[,"pasture"], zlim=c(0,1), main="pasture")
gridPlot(cluAgg@data[,"cropland"], zlim=c(0,1), main="cropland")
gridPlot(cluAgg@data[,"natveg"], zlim=c(0,1), main="natveg")

## metafunction

cluAgg <- aggregateMosaics(out@data, cluUse)


# aggregateMosaicsClumondo <- function(data, mosaics, worldregions){
#   id <- match(paste(coordinates(worldregions)[,1], coordinates(worldregions)[,2]), paste(coordinates(data)[,1], coordinates(data)[,2]))
#   checkcoords <- identical(id, 1:67420)  
#   if(checkcoords == FALSE){
#     stop("Order of coordinates of data and worldregions not the same!")
#   }
#   
#   nrOfRegions <- dim(mosaics)[3]
#   cluAgg <- array(NA, dim=c(nrow(data),3), dimnames=list(1:nrow(data),c("natveg", "cropland", "pasture")))
#   
#   for(i in 1:nrOfRegions){
#     cluOri              <- mosaics[,4:8,i]
#     theRegion           <- dimnames(mosaics)[[3]][i]
#     theRows             <- which(worldregions@data$CLUWORLDREGION == theRegion)
#     message(paste("Processing CLUMondo World Region Nr.", i, "of", nrOfRegions, ":", theRegion))
#     cluUse              <- array(NA, dim=c(dim(mosaics)[1],3), dimnames=list(dimnames(mosaics)[[1]],c("natveg", "cropland", "pasture")))
#     cluUse[,"cropland"] <- (cluOri[,"crop"]) 
#     cluUse[,"pasture"]  <- (cluOri[,"pasture"])
#     cluUse[,"natveg"]   <- (1 - cluUse[,"cropland"] - cluUse[,"pasture"])
#     cluAgg[theRows,]    <- aggregateMosaics(data@data[theRows,], cluUse)
#   }
#   
#   message("Create SpatialPointsDataFrame.")
#   coords <- coordinates(data)
#   row.names(coords) <- row.names(cluAgg)
#   cluAgg <- SpatialPointsDataFrame(coords, as.data.frame(cluAgg), proj4string = CRS("+proj=longlat +ellps=WGS84"))
#   message("Aggregation finished.")
#   return(cluAgg)
# }


cluAgg <- aggregateMosaicsClumondo(out, CLUMosaics, lpjGrid)

gridPlot(cluAgg@data[,"pasture"], zlim=c(0,1), main="pasture")
gridPlot(cluAgg@data[,"cropland"], zlim=c(0,1), main="cropland")
gridPlot(cluAgg@data[,"natveg"], zlim=c(0,1), main="natveg")
gridPlot(rowSums(cluAgg@data), main="cover")

spplot(cluAgg, "pasture")


gridPlot(cluAgg@data[,"cropland"]+cluAgg@data[,"pasture"], zlim=c(0,1), main="cropland+pasture")

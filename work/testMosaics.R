### R code from vignette source 'CLUMondo_LPJmL_Translation.Rnw'
### Encoding: ISO8859-1

###################################################
### code chunk number 1: cluagg
###################################################
library(luess)
#clu2000     <- transform_asciigrid("../../work/clu2000.txt")
#clu2040     <- transform_asciigrid("../../work/clu2040.txt")
#out2000     <- resample_grid(clu2000, generate_grid(), cells=lpj_long_clupos)
#out2040     <- resample_grid(clu2040, generate_grid(), cells=lpj_long_clupos)
#save(clu2000, clu2040, out2000, out2040, file="../../work/clu2000_clu2040.rda")
load("./clu2000_clu2040.rda")
cluAgg      <- aggregateMosaicsClumondo(out2000, CLUMosaicsRaman, lpjGrid, fixUS=TRUE)
cluAgg2040  <- aggregateMosaicsClumondo(out2040, CLUMosaics, lpjGrid)


###################################################
### code chunk number 2: readlpj
###################################################
cftfrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 2000, 2000, 1700, 32, 2, sizeof_header=43)
pftfrac   <- getLPJ("N:/vmshare/landuse/fpc.bin", 2000, 2000, 1901, 10, 4, double(), byrow=FALSE)
natvegLPJ <- pftfrac[1,,1] + rowSums(cftfrac[1,,])/1000


###################################################
### code chunk number 3: cluagg
###################################################
require(RColorBrewer)
myPalette <- colorRampPalette(rev(c(brewer.pal(11, "RdYlBu"), "darkblue")))
cropLPJ <- (rowSums(cftfrac[1,,]) - cftfrac[1,,14])/1000
cropCLU <- cluAgg@data[,"cropland"]
cropCLU2040 <- cluAgg2040@data[,"cropland"]
cropDelta <- cropCLU - cropLPJ
cropDelta2040 <- cropCLU2040 - cropCLU

#absrange <- max(abs(c(min(cropDelta), max(cropDelta))))
par(mfrow=c(3,1))
gridPlot(cropLPJ, main="Cropland without pasture MICRA2000")
gridPlot(cropCLU, zlim=c(0,1), main="Cropland CLUMondo")
gridPlot(cropDelta, main=expression(paste(Delta,"cropland = ",CLUMondo-MICRA2000)), zlim=c(-1,1),col=myPalette(100))


###################################################
### code chunk number 4: clupasture
###################################################
require(RColorBrewer)
myPalette <- colorRampPalette(rev(c(brewer.pal(11, "RdYlBu"), "darkblue")))
pastLPJ <- cftfrac[1,,14]/1000
pastCLU <- cluAgg@data[,"pasture"]
pastCLU2040 <- cluAgg2040@data[,"pasture"]
pastDelta <- pastCLU - pastLPJ
pastDelta2040 <- pastCLU2040 - pastCLU
#absrange <- max(abs(c(min(cropDelta), max(cropDelta))))
par(mfrow=c(3,1))
gridPlot(pastLPJ, main="Pasture MICRA2000")
gridPlot(pastCLU, zlim=c(0,1), main="Pasture CLUMondo")
gridPlot(pastDelta, main=expression(paste(Delta,"pasture = ",CLUMondo-MICRA2000)), zlim=c(-1,1),col=myPalette(100))


###################################################
### code chunk number 5: cludiff2040
###################################################
par(mfrow=c(2,1))
gridPlot(cropDelta2040, main=expression(paste(Delta,"cropland = ",CLUMondo2000-CLUMondo2040)), zlim=c(-1,1),col=myPalette(100))
gridPlot(pastDelta2040, main=expression(paste(Delta,"pasture = ",CLUMondo2000-CLUMondo2040)), zlim=c(-1,1),col=myPalette(100))

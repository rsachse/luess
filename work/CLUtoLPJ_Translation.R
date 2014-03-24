require(luess)
require(qualV)
load("clu2000_clu2040.rda")
cluAgg    <- aggregateMosaicsClumondo(out2000, CLUMosaics, lpjGrid)
cftFrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 2000, 2000, 1700, 32, 2, sizeof_header=43)
cft = c(1:13, 15:16, 17:29, 31:32)

cftFrac <- cftFrac[,,cft]

range <- 2.5

load("out_trans_0_5.rda")
load("out_trans_1.rda")
load("out_trans_2_5.rda")
load("out_trans_3.rda")
load("out_trans_4.rda")
load("out_trans_5.rda")
load("out_trans_7_5.rda")
load("out_trans_10.rda")
load("out_trans_15.rda")
load("out_trans_20.rda")
ranges <- c(0.5, 1,2.5,3,4,5,7.5,10,15,20)

out_trans_0_5 <- out_trans_0_5[,,cft]
out_trans_1 <- out_trans_1[,,cft]
out_trans_2_5 <- out_trans_2_5[,,cft]
out_trans_3 <- out_trans_3[,,cft]
out_trans_4 <- out_trans_4[,,cft]
out_trans_5 <- out_trans_5[,,cft]
out_trans_7_5 <- out_trans_7_5[,,cft]
out_trans_10 <- out_trans_10[,,cft]
out_trans_15 <- out_trans_15[,,cft]
out_trans_20 <- out_trans_20[,,cft]


## all crops
EF <- NULL
EF[1] <- EF(cftFrac, out_trans_0_5)
EF[2] <- EF(cftFrac, out_trans_1)
EF[3] <- EF(cftFrac, out_trans_2_5)
EF[4] <- EF(cftFrac, out_trans_3)
EF[5] <- EF(cftFrac, out_trans_4)
EF[6] <- EF(cftFrac, out_trans_5)
EF[7] <- EF(cftFrac, out_trans_7_5)
EF[8] <- EF(cftFrac, out_trans_10)
EF[9] <- EF(cftFrac, out_trans_15)
EF[10] <- EF(cftFrac, out_trans_20)

png("EF.png", width=4000, height=3000, res=600)
par(cex=1.7, mar=c(4,4,1,1))
plot(ranges, EF, type="b", ylim=c(0.5,1), main="Goodness of Translation",
     las=1, ylab="Nash-Sutcliffe-Efficiency", xlab="window range (°)", pch=16, lwd=2)
mtext("window range (°)", 1, line=3, cex=1.7)
dev.off()


## specific crops
nn <- 1
EF <- NULL
EF[1] <- EF(cftFrac[,nn], out_trans_0_5[,nn])
EF[2] <- EF(cftFrac[,nn], out_trans_1[,nn])
EF[3] <- EF(cftFrac[,nn], out_trans_2_5[,nn])
EF[4] <- EF(cftFrac[,nn], out_trans_3[,nn])
EF[5] <- EF(cftFrac[,nn], out_trans_4[,nn])
EF[6] <- EF(cftFrac[,nn], out_trans_5[,nn])
EF[7] <- EF(cftFrac[,nn], out_trans_7_5[,nn])
EF[8] <- EF(cftFrac[,nn], out_trans_10[,nn])
EF[9] <- EF(cftFrac[,nn], out_trans_15[,nn])
EF[10] <- EF(cftFrac[,nn], out_trans_20[,nn])
plot(ranges, EF, type="b", ylim=c(0.5,1), log="x")





#################### old
# #nn <- 1
# EF <- NULL
# EF[1] <- sum((cftFrac[1,,nn] - out_trans_2_5[1,,nn])^2)
# EF[2] <- sum((cftFrac[1,,nn] - out_trans_3[1,,nn])^2)
# EF[3] <- sum((cftFrac[1,,nn] - out_trans_4[1,,nn])^2)
# EF[4] <- sum((cftFrac[1,,nn] - out_trans_5[1,,nn])^2)
# EF[5] <- sum((cftFrac[1,,nn] - out_trans_7_5[1,,nn])^2)
# EF[6] <- sum((cftFrac[1,,nn] - out_trans_10[1,,nn])^2)
# EF[7] <- sum((cftFrac[1,,nn] - out_trans_20[1,,nn])^2)
# plot(ranges, EF, type="b")
# 
# 
# EF <- NULL
# EF[1] <- sum((cftFrac[1,,] - out_trans_2_5[1,,])^2)
# EF[2] <- sum((cftFrac[1,,] - out_trans_3[1,,])^2)
# EF[3] <- sum((cftFrac[1,,] - out_trans_4[1,,])^2)
# EF[4] <- sum((cftFrac[1,,] - out_trans_5[1,,])^2)
# EF[5] <- sum((cftFrac[1,,] - out_trans_7_5[1,,])^2)
# EF[6] <- sum((cftFrac[1,,] - out_trans_10[1,,])^2)
# EF[7] <- sum((cftFrac[1,,] - out_trans_20[1,,])^2)
# plot(ranges, EF, type="b")
# 
# 
# #pdf(paste("CLUtoLPJ_translation_range",range,".pdf",sep=""))
 gridPlot(out_trans_2_5[,1], coordinates(lpjGrid), main="CLU translated CFT 1", zlim=c(0,1000))
 gridPlot(cftFrac[,1], coordinates(lpjGrid), main="MIRCA2000 CFT 1", zlim=c(0,1000))
# #dev.off()
# 
# 
# 
# out <- out_trans_2_5
# croplandMirca            <- rowSums(cftFrac[1,,c(1:13, 15:16, 17:29, 31:32)])
# croplandAfterTranslation <- rowSums(out[1,,])/1000
# croplandDifference <- cluAgg@data[,"cropland"] - croplandAfterTranslation
# plot(croplandDifference)
# gridPlot(cluAgg@data[,"cropland"])
# gridPlot(croplandDifference)
# 
# gridPlot(cluAgg@data[,"cropland"], zlim=c(0,1), main="cropland CLU 2000")
# gridPlot(croplandAfterTranslation, zlim=c(0,1), main="cropland after translation")
# gridPlot(croplandMirca, zlim=c(0,1000), main= "cropland MIRCA2000")
# 

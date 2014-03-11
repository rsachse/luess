require(luess)
load("clu2000_clu2040.rda")
cluAgg    <- aggregateMosaicsClumondo(out2000, CLUMosaics, lpjGrid)
cftFrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 2000, 2000, 1700, 32, 2, sizeof_header=43)

range <- 2.5

system.time({
  out <- translateCluToLpj(
    lpjGrid, 
    cells=30000:31000,
    range=range, 
    landuse=cftFrac, 
    landuseClu=cluAgg, 
    scaleFactor=1000
  )
})

#save(out_trans_2_5, file="out_trans_2_5.rda")

load("out_trans_2_5.rda")

#pdf(paste("CLUtoLPJ_translation_range",range,".pdf",sep=""))
gridPlot(out_trans_2_5[1,,10], coordinates(lpjGrid), main="CLU translated CFT 1")
gridPlot(cftFrac[1,,1], coordinates(lpjGrid), main="MIRCA2000 CFT 1")
#dev.off()

plot(croplandDifference)


#out <- out_trans_2_5
croplandMirca            <- rowSums(cftFrac[1,,c(1:13, 15:16, 17:29, 31:32)])
croplandAfterTranslation <- rowSums(out[1,,])/1000
croplandDifference <- cluAgg@data[30000:31000,"cropland"] - croplandAfterTranslation
plot(croplandDifference)
gridPlot(cluAgg@data[30000:31000,"cropland"], coordinates(lpjGrid[30000:31000,]))
gridPlot(croplandDifference, coordinates(lpjGrid[30000:31000,]))
gridPlot(croplandAfterTranslation, coordinates(lpjGrid[30000:31000,]))



gridPlot(croplandMirca, zlim=c(0,1000))
gridPlot(cluAgg@data[,"cropland"])

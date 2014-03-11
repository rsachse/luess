require(luess)
load("clu2000_clu2040.rda")
cluAgg    <- aggregateMosaicsClumondo(out2000, CLUMosaics, lpjGrid)
cftFrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 2000, 2000, 1700, 32, 2, sizeof_header=43)

range <- 0.5

system.time({
  out_trans_0_5 <- translateCluToLpj(
    lpjGrid, 
    range=range, 
    landuse=cftFrac, 
    landuseClu=cluAgg, 
    scaleFactor=1000
  )
})

save(out_trans_0_5, file="out_trans_0_5.rda")

pdf(paste("CLUtoLPJ_translation_range",range,".pdf",sep=""))
gridPlot(out_trans_0_5[1,,1], coordinates(lpjGrid), main="CLU translated CFT 1")
gridPlot(cftFrac[1,,1], coordinates(lpjGrid), main="MIRCA2000 CFT 1")
dev.off()
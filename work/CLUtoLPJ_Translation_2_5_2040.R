require(luess)
load("clu2000_clu2040.rda")
cluAgg    <- aggregateMosaicsClumondo(out2040, CLUMosaics, lpjGrid)
#cftFrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 2000, 2000, 1700, 32, 2, sizeof_header=43)

# range <- 2.5
# 
# system.time({
#   out_trans_2_5_2040 <- translateCluToLpj(
#     lpjGrid, 
#     range=range, 
#     landuse=cftFrac, 
#     landuseClu=cluAgg, 
#     scaleFactor=1000
#   )
# })
# 
# save(out_trans_2_5_2040, file="out_trans_2_5_2040.rda")
# 
# pdf(paste("CLUtoLPJ_translation_range",range,".pdf",sep=""))
# gridPlot(out_trans_2_5_2040[1,,1], coordinates(lpjGrid), main="CLU translated CFT 1")
# gridPlot(cftFrac[1,,1], coordinates(lpjGrid), main="MIRCA2000 CFT 1")
# dev.off()

load("out_trans_2_5_2040.rda")
out_trans_2_5_2040[1,,14] <- cluAgg@data[,"pasture"]*1000
save(out_trans_2_5_2040, file="out_trans_2_5_2040.rda")
### aggregate the land covers of the CLUMondo land use systems
cluAgg2040  <- aggregateMosaicsClumondo(out2040, CLUMosaics, lpjGrid, fixUS=TRUE)
png("cropland_canada_for_us.png")
gridPlot(cluAgg2040@data$cropland, main="cropland (Canada for US")
dev.off()
### aggregate the land covers of the CLUMondo land use systems
cluAgg2040  <- aggregateMosaicsClumondo(out2040, CLUMosaics, lpjGrid, fixUS=FALSE)
png("cropland_fixed_us.png")
gridPlot(cluAgg2040@data$cropland, main="cropland (Fixed US-look-up")
dev.off()

readMosaicFiles <- function(path="./mosaics/", rel=TRUE){
  regions <- dir(path)
  id <- NULL
  for(i in 1:length(regions)){
    id[i] <- as.numeric(readLines(paste(path,regions[i],sep=""), n=1))
  }
  cluMosaics <- array(NA, dim=c(30,8,length(regions)), 
    dimnames=list(
      c(
        "cropland_ext_few",
        "cropland_ext_bgs",
        "cropland_ext_pp",
        "cropland_med_few",
        "cropland_med_bgs",
        "cropland_med_pp",
        "cropland_int_few",
        "cropland_int_bgs",
        "cropland_int_pp",
        "mosaic_grass_bgs",
        "mosaic_grass_pp",
        "mosaic_ext_grass_few",
        "mosaic_med_grass_few",
        "mosaic_int_grass_few",
        "mosaic_forest_pp",
        "mosaic_ext_forest_few",
        "mosaic_med_forest_few",
        "mosaic_int_forest_few",
        "forest",
        "forest_few",
        "forest_pp",
        "mosaic_grass_forest",
        "mosaic_grass_bare",
        "grass",
        "grass_few",
        "grass_bgs",
        "bare",
        "bare_few",
        "periurban",
        "urban"
      ), 
      c(
        "crop_production",
        "livestock_bovines_goat_sheep",
        "livestock_pig_poultry", 
        "builtup", 
        "crop", 
        "pasture", 
        "tree", 
        "bare"
      ), 
      regions[order(id)]
    )
  )
  
  j <- 0
  for(i in order(id)){
    j <- j+1 
    cluMosaics[,,j] <- as.matrix(read.table(paste(path, regions[i], sep=""), skip=1, header=FALSE, sep="\t", dec="."))
    if(rel == TRUE){
      cluMosaics[,4:8,j] <- cluMosaics[,4:8,j] / rowSums(cluMosaics[,4:8,j])
      #dum <- rep(1,30)
      #names(dum) <- row.names(cluMosaics[,4:8,j])
      #print(all.equal(dum, (rowSums(cluMosaics[,4:8,j]))))
    }
  }
  return(cluMosaics)
}

CLUMosaics      <- readMosaicFiles()
CLUMosaics_area <- readMosaicFiles(rel=FALSE)

save(CLUMosaics, file="CLUMosaics.rda")
save(CLUMosaics_area, file="CLUMosaics_area.rda")

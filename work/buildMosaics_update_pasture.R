require(luess)

readMosaicFiles <- function(path="./mosaics/", rel=TRUE, ncol=8){
  regions <- dir(path)
  id <- NULL
  for(i in 1:length(regions)){
    id[i] <- as.numeric(readLines(paste(path,regions[i],sep=""), n=1))
  }
  
  if(ncol==8){
    columnNames <- c(
      "crop_production",
      "livestock_bovines_goat_sheep",
      "livestock_pig_poultry", 
      "builtup", 
      "crop", 
      "pasture", 
      "tree", 
      "bare"
    )
  } else {
    if (ncol==7) {
      columnNames <-       c(
        "landsystem",
        "builtup",
        "crop", 
        "pasture", 
        "tree", 
        "bare", 
        "total"
      )
    } else {
      if (ncol == 6){
        columnNames <-       c(
          "builtup",
          "crop", 
          "pasture", 
          "tree", 
          "bare", 
          "total"
        )        
      } else {
          stop("ncol is only valid when ncol=7 or ncol=8")
      }
    }
  }
  
  
  cluMosaic <- array(NA, dim=c(30,ncol,length(regions)), 
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
      columnNames, 
      #regions[order(id)]
      c(
        "Canada",
        "USA",
        "Mexico",
        "RestofCentralAmerica",
        "RestofSouthAmerica",
        "Brazil",
        "WesternEurope",
        "EasternEurope",
        "Ukraine",
        "Turkey",
        "NorthernAfrica",
        "EasternAfrica",
        "WesternAfrica",
        "SouthernAfrica",
        "Stans",
        "Russia",
        "MiddleEast",
        "India",
        "China",
        "Japan",
        "Korea",
        "SouthEastAsia",
        "Indonesia",
        "Oceania"
      )
    )
  )
  
  j <- 0
  for(i in order(id)){
    j <- j+1 
    cluMosaic[,,j] <- as.matrix(read.table(paste(path, regions[i], sep=""), skip=1, header=FALSE, sep="\t", dec="."))
    if(rel == TRUE){
      cluMosaic[,4:8,j] <- cluMosaic[,4:8,j] / rowSums(cluMosaic[,4:8,j])
      #dum <- rep(1,30)
      #names(dum) <- row.names(cluMosaics[,4:8,j])
      #print(all.equal(dum, (rowSums(cluMosaics[,4:8,j]))))
    }
  }
  return(cluMosaic)
}


## read different versions of mosaics

CLUMosaicsOld      <- readMosaicFiles(path="./mosaics/", rel=FALSE)
CLUUpdateUncorr    <- readMosaicFiles(path="./mosaics-update/mosaics-uncorrected/", ncol=7, rel=FALSE)
CLUUpdateCorr      <- readMosaicFiles(path="./mosaics-update/mosaics-corrected/", rel=FALSE, ncol=6)


## update  pasture
checkEqual <- function(CLUMosaicsold, CLUUpdateUncorr, col="builtup"){
  for (i in 1:24){
    print(i)
    res <- any( (CLUMosaicsOld[,col,i] == CLUUpdateUncorr[,col,i]) != TRUE)
    if (res == TRUE){
      print((CLUMosaicsOld[,col,i] == CLUUpdateUncorr[,col,i]))
      print((CLUMosaicsOld[,col,i] - CLUUpdateUncorr[,col,i]))
    }
    print(res)
  }
}


checkEqual(CLUMosaicsOld, CLUUpdateUncorr, "builtup")
checkEqual(CLUMosaicsOld, CLUUpdateUncorr, "crop")
pcheckEqual(CLUMosaicsOld, CLUUpdateUncorr, "pasture")
checkEqual(CLUMosaicsOld, CLUUpdateUncorr, "tree")
checkEqual(CLUMosaicsOld, CLUUpdateUncorr, "bare")




## check that sum of landcover not > 9.25 km^2

CLUMosaicsRaman <- CLUMosaicsOld

for (i in 1:24){
  CLUMosaicsRaman[,"pasture",i] <- CLUUpdateUncorr[,"pasture",i]  
  CLUMosaicsRaman[,"bare",i] <- 9.25^2 - CLUMosaicsRaman[,"crop",i] - CLUMosaicsRaman[,"pasture",i] - CLUMosaicsRaman[,"builtup",i]
  CLUMosaicsRaman[,"pasture",i] <- ifelse(CLUMosaicsRaman[,"bare",i] < 0, CLUMosaicsRaman[,"pasture",i] + CLUMosaicsRaman[,"bare",i], CLUMosaicsRaman[,"pasture",i])
  CLUMosaicsRaman[,"bare",i] <- 9.25^2 - CLUMosaicsRaman[,"crop",i] - CLUMosaicsRaman[,"pasture",i] - CLUMosaicsRaman[,"builtup",i]
}

## absolute areas to % coverage
for(i in 1:24){ 
  CLUMosaicsRaman[,c(4,5,6,8),i] <- CLUMosaicsRaman[,c(4,5,6,8),i] / rowSums(CLUMosaicsRaman[,c(4,5,6,8),i])
  print(rowSums(CLUMosaicsRaman[,c(4,5,6,8),i]))
}

## assamble new Mosaic data set
cluMosaicRaman <- array(NA, dim=c(30,7,24), 
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
                       "natveg"
                     ), 
                     #regions[order(id)]
                     c(
                       "Canada",
                       "USA",
                       "Mexico",
                       "RestofCentralAmerica",
                       "RestofSouthAmerica",
                       "Brazil",
                       "WesternEurope",
                       "EasternEurope",
                       "Ukraine",
                       "Turkey",
                       "NorthernAfrica",
                       "EasternAfrica",
                       "WesternAfrica",
                       "SouthernAfrica",
                       "Stans",
                       "Russia",
                       "MiddleEast",
                       "India",
                       "China",
                       "Japan",
                       "Korea",
                       "SouthEastAsia",
                       "Indonesia",
                       "Oceania"
                     )
     )
)

for(i in 1:24){
  cluMosaicRaman[,"crop_production",i] <- CLUMosaics[,"crop_production",i]
  cluMosaicRaman[,"livestock_bovines_goat_sheep",i] <- CLUMosaics[,"livestock_bovines_goat_sheep",i]
  cluMosaicRaman[,"livestock_pig_poultry",i] <- CLUMosaics[,"livestock_pig_poultry",i]
  cluMosaicRaman[,"builtup",i] <- CLUMosaicsRaman[,"builtup",i]
  cluMosaicRaman[,"crop",i] <- CLUMosaicsRaman[,"crop",i]
  cluMosaicRaman[,"pasture",i] <- CLUMosaicsRaman[,"pasture",i]
  cluMosaicRaman[,"natveg",i] <- CLUMosaicsRaman[,"bare",i]
  print(rowSums(cluMosaicRaman[,c(4:7),i]))
}

CLUMosaicsRaman <- cluMosaicRaman

## write new file
save(CLUMosaicsRaman, file="CLUMosaicsRaman.rda")

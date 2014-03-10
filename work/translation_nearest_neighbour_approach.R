load("clu2000_clu2040.rda")
cluAgg      <- aggregateMosaicsClumondo(out2000, CLUMosaics, lpjGrid)
cftfrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 2000, 2000, 1700, 32, 2, sizeof_header=43)


thegrid <- generate_grid(c(-10,-10),cellsize=c(1,1), cells.dim=c(20,20))
plot(thegrid)


## construct some data for playing:
landgrid <- generate_grid(c(-10,-5),cellsize=c(1,1), cells.dim=c(20,10))
landuseCLU <- SpatialPointsDataFrame(landgrid, data.frame(cropland=abs(rnorm(200, mean=0.3, sd=0.1))))
plot(landgrid, col="green", pch=15, add=TRUE)
spplot(landuseCLU)


landuseLPJ <- array(NA, dim=c(1,nrow(coordinates(landgrid)),3))
landuseLPJ[1,1:50,1] <- 0.1
landuseLPJ[1,51:150,1] <- 0.2
landuseLPJ[1,151:200,1] <- 0.3

landuseLPJ[1,1:50,2] <- 0.3
landuseLPJ[1,51:150,2] <- 0.1
landuseLPJ[1,151:200,2] <- 0.2

landuseLPJ[1,1:50,3] <- 0.05
landuseLPJ[1,51:150,3] <- 0.12
landuseLPJ[1,151:200,3] <- 0.02


calcRangePoint <- function(x, y, range){
  res <- c(
    x - range,
    x + range, 
    y -range, 
    y + range
  )
  names(res) <- c("xl", "xu", "yl", "yu")
  return(res)
}

getNearPoints <- function(coords, coordsGrid, range){
  rangeCoords <- calcRangePoint(coords[1], coords[2], range) 
  idPoints    <- which(coordsGrid[,1] <= rangeCoords[2] & coordsGrid[,1] >= rangeCoords[1] & coordsGrid[,2] <= rangeCoords[4] & coordsGrid[,2] >= rangeCoords[3])
  return(idPoints)
}




translateCluToLpj <- function(grid, range, landuse, cells=1:10, cft=c(1:13,15:16,17:29,31:32), years=1, scaleFactor=1000){
  ## extract coordinates
  coordsGrid <- coordinates(grid)
  
  ## specify all cells if no specific cells mentioned
  if(is.null(cells)){
    cells <- 1:nrow(coordsGrid)
  }
  
  ## determine cells in the near
  idPoints <- apply(
    coordsGrid[cells,], 
    1,
    getNearPoints,
    coordsGrid=coordsGrid,
    range=range
  )  

  ## empty data structure
  res <- array(NA, dim=c(length(years), length(cells), dim(landuse)[3]))
  
  ## average landuse from neighbouring cells
  for(year in 1:length(years)){
    for(i in 1:length(cells)){
      landuseArea <-  landuse[year, idPoints[[i]] ,cft]
      cmeans      <- colMeans(landuseArea)
      cmeans      <- cmeans/sum(cmeans)
      res[year, i, cft] <- cmeans
    }
  }
  
  ## scale fraction with a constant factor (LPJ specific)
  res <- res * scaleFactor
  
  ## return results
  return(res)
}


cftfrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 2000, 2001, 1700, 32, 2, sizeof_header=43)
system.time({bar <- translateCluToLpj(lpjGrid, range=2.5, landuse=cftfrac, years=1:2, cells=13000:13100)})





## testing the functions
system.time({bar <- myapply(lpjGrid, 5)})




grid <- grid <- coordinates(landuseCLU)
range <- 1.01
coords <- coordinates(landuseCLU)[70,]


bar <- apply(coordinates(landuseCLU), 1, getNearPoints, coordGrid=coordinates(landuseCLU), range=2.7)

#X11()
for(i in 1:length(bar)){
  coords <- coordinates(landuseCLU)[bar[[i]],]
  thePoint <- coordinates(landuseCLU)[i,]
  plot(grid, pch=3)
  points(grid[bar[[i]],1], grid[bar[[i]],2], pch=15, col="darkgreen")
  points(thePoint[1], thePoint[2], pch=15, col="red")
}

####

tp <- 13000
plot(lpjGrid, pch=".")
bar <- apply(
  coordinates(lpjGrid)[tp:(tp+10),], 
  1, 
  getNearPoints, 
  coordsGrid=coordinates(lpjGrid), 
  range=2.5
)


grid <- coordinates(lpjGrid)
points(grid[bar[[1]],1], grid[bar[[1]],2], pch=15, col="green", cex=0.3)
points(grid[tp,1], grid[tp,2], pch = 15, col="red")


lgrid <- coordinates(lpjGrid)
grid <- NULL
for(i in 1:nrow(lgrid)){
  grid[i] <- list(lgrid[i,])
}


require(parallel)
cl <- makeCluster(getOption("cl.cores", 4))
system.time({
bar <- clusterApply(
  cl=cl,
  grid, 
  getNearPoints, 
  grid=lgrid, 
  range=5
)
})


system.time({
  bar <- apply(
    lgrid[1:1000,], 
    1,
    getNearPoints, 
    coordsGrid=lgrid, 
    range=5
  )
})


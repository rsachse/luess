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

getNearPoints <- function(coords, grid, range){
  coordsGrid  <- coordinates(grid)
  rangeCoords <- calcRangePoint(coords[1], coords[2], range) 
  idPoints    <- which(coordsGrid[,1] <= rangeCoords["xu"] & coordsGrid[,1] >= rangeCoords["xl"] & coordsGrid[,2] <= rangeCoords["yu"] & coordsGrid[,2] >= rangeCoords["yl"])
  return(idPoints)
}


## testing the functions
grid <- grid <- coordinates(landuseCLU)
range <- 1.01
coords <- coordinates(landuseCLU)[70,]


bar <- apply(coordinates(landuseCLU), 1, getNearPoints, grid=coordinates(landuseCLU), range=2.7)

X11()
for(i in 1:length(bar)){
  coords <- coordinates(landuseCLU)[bar[[i]],]
  thePoint <- coordinates(landuseCLU)[i,]
  plot(grid, pch=3)
  points(grid[bar[[i]],1], grid[bar[[i]],2], pch=15, col="darkgreen")
  points(thePoint[1], thePoint[2], pch=15, col="red")
}



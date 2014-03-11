\name{translateCluToLpj}
\alias{translateCluToLpj}
\title{Translates CLUMondo Cropland Area into specific LPJmL Crop Functional Types}
\usage{
translateCluToLpj(grid, range, landuse, landuseClu, cells = NULL,
  cft = c(1:13, 15:16, 17:29, 31:32), years = 1, scaleFactor = 1000)
}
\arguments{
  \item{grid}{SpatialPointsDataFrame with the grid and at
  least the column \code{CLUWORLDREGION}}

  \item{range}{range in degrees which defines the radius of
  neighbourhood}

  \item{landuse}{\code{array[years, pixels, cfts]} of the
  MIRCA2000 landuse maps}

  \item{landuseClu}{SpatialPointsDataFrame providing the
  column \code{cropland}. Needs to have the same grid as
  \code{grid}}

  \item{cells}{integer, ID of the pixels which shall be
  processed. If \code{NULL} all pixels are processed}

  \item{cft}{integer, ID of the LPJmL CFTs which shall be
  included in cropland. The default values do not consider
  pasture, since the CLUMondo pasture is more grassy land
  and not comparable to the MIRCA2000 data set.}

  \item{years}{integer, number of the years of the landuse
  input which shall be processed}

  \item{scaleFactor}{numeric factor to comply with LPJmL
  input data requirements (1000 for landuse fractions)}
}
\description{
The function translates CLUMondo cropland into specific
LPJmL crop functional types. Therefore, the functions
searches in the nearby area of each pixel for real landuse
on the MIRCA2000 map (Portmann et al. 2010). The relations
between crops of the nearby area are than applied to the
area which CLUMondo calculated as cropland area. The nearby
area is determined as an rectangular area. Using this
method the crops are similar to the crops in the
surrounding area in the year 2000. No climate change or
land suitability is checked. However, CLUMondo did some
kind of suitability check for cropland already (Asselen &
Verburg, 2013), so we assume the area to be suitable for
agriculture.
}
\details{
Note: the function only works for the first year. For more
years, one would need to pass landuseClu as a list, with
one SpatialPointsDataFrame for each year. And the algorithm
needs to be updated to handle lists for landuseClu.
}
\examples{
\dontrun{
  load("clu2000_clu2040.rda")
  cluAgg    <- aggregateMosaicsClumondo(out2000, CLUMosaics, lpjGrid)
  cftfrac   <- getLPJ("N:/vmshare/landuse/landuse.bin", 2000, 2001, 1700, 32, 2, sizeof_header=43)
  system.time({bar <- translateCluToLpj(lpjGrid, range=2.5, landuse=cftfrac, landuseClu=cluAgg, cells=30000:31000, scaleFactor=1000)})

  gridPlot(rowSums(bar[1,,]), coordinates(lpjGrid[30000:31000,]), zlim=c(0,1000), main="CLU translated")
  cft <- c(1:13, 15:16, 17:29, 31:32)
  gridPlot(rowSums(cftfrac[1,30000:31000,cft]), coordinates(lpjGrid[30000:31000,]), zlim=c(0,1000), main="MIRCA2000")
}

## grid with pixels
landgrid <- generate_grid(c(-10,-5),cellsize=c(0.5,0.5), cells.dim=c(20,10))
landgrid <- SpatialPointsDataFrame(landgrid, data.frame(CLUWORLDREGION=rep("Canada",200)))

## same grid with CLUMondo cropland fractions
#landuseCLU <- SpatialPointsDataFrame(landgrid, data.frame(cropland=abs(rnorm(200, mean=0.3, sd=0.1))))
landuseCLU <- SpatialPointsDataFrame(landgrid, data.frame(cropland=rep(1,200)))

## show the grid
plot(landgrid, col="green", pch=15)

## construct artificial landuse data with 3 arbitrary cfts
landuseLPJ <- array(NA, dim=c(1,nrow(coordinates(landgrid)),3))
landuseLPJ[1,1:50,1] <- 0.1
landuseLPJ[1,51:150,1] <- 0.2
landuseLPJ[1,151:200,1] <- 0.3
landuseLPJ[1,1:50,2] <- 0.3
landuseLPJ[1,51:150,2] <- 0.1
landuseLPJ[1,151:200,2] <- 0.2
landuseLPJ[1,1:50,3] <- 1 - landuseLPJ[1,1:50,1] - landuseLPJ[1,1:50,2]
landuseLPJ[1,51:150,3] <- 1 - landuseLPJ[1,51:150,1] - landuseLPJ[1,51:150,2]
landuseLPJ[1,151:200,3] <- 1 - landuseLPJ[1,151:200,1] - landuseLPJ[1,151:200,2]

## translate
res <- translateCluToLpj(landgrid, range=0.7, landuseLPJ, landuseCLU, cft=1:3, scaleFactor=1)

## visualize
par(mfrow=c(2,3))
gridPlot(landuseLPJ[1,,1],coordinates(landgrid), main="Real CFT 1", xlim=c(-11,0), ylim=c(-6,0))
gridPlot(landuseLPJ[1,,2],coordinates(landgrid), main="Real CFT 2", xlim=c(-11,0), ylim=c(-6,0))
gridPlot(landuseLPJ[1,,3],coordinates(landgrid), main="Real CFT 3", xlim=c(-11,0), ylim=c(-6,0))
gridPlot(res[1,,1],coordinates(landgrid), main="CLU translated CFT 1", xlim=c(-11,0), ylim=c(-6,0))
gridPlot(res[1,,2],coordinates(landgrid), main="CLU translated CFT 2", xlim=c(-11,0), ylim=c(-6,0))
gridPlot(res[1,,3],coordinates(landgrid), main="CLU translated CFT 3", xlim=c(-11,0), ylim=c(-6,0))

## example for moving the window of neighbourhood
## modify tp to a value between 1 and 67420 to move
## the window
tp <- 37000
par(mfrow=c(1,1))
plot(lpjGrid, pch=".")
bar <- apply(
  coordinates(lpjGrid)[tp:(tp+10),],
  1,
  getNearPoints,
  coordsGrid=coordinates(lpjGrid),
  range=10
)

grid <- coordinates(lpjGrid)
points(grid[bar[[1]],1], grid[bar[[1]],2], pch=15, col="green", cex=0.3)
points(grid[tp,1], grid[tp,2], pch = 15, col="red")
}
\author{
Rene Sachse \email{rene.sachse@uni-potsdam.de}
}
\references{
Portmann, F. T., Siebert, S., and Doll, P. (2010). 2010
MIRCA2000-global monthly irrigated and rainfed crop areas
around the year 2000: A new high-resolution data set for
agricultural and hydrological modeling. Global
Biogeochemical Cycles, 24.

Asselen, S. v. & Verburg, P. H. v. Land cover change or
land use intensification: simulting land system change with
a global-scale land change model Global Change Biology,
2013, 19, 3648-3667
}
\keyword{CLUMondo,}
\keyword{LPJ,}
\keyword{LPJml,}
\keyword{cropland,}
\keyword{translation}


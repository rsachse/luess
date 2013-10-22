\name{resample_grid}
\alias{resample_grid}
\title{Resampling of a high resolution grid for further use with a grid of coarser resolution}
\usage{
  resample_grid(grid_hr, grid_lr, cells = NULL,
    datacolumn = 1, verbose = FALSE, parallel = FALSE,
    cores = 4)
}
\arguments{
  \item{grid_hr}{SpatialPointsDataFrame containing the
  geometry of cellcenters of the original high resolution
  grid. Other input geometries might be possible but have
  not been tested so far.}

  \item{grid_lr}{SpatialGrid of the new grid}

  \item{cells}{Only calculations for these cells will be
  returned (e.g. if these are cells with landcover). If
  \code{NULL} values for all cells with available data will
  be calculated.}

  \item{datacolumn}{integer specifing which column of the
  SpaitalPointsDataFrame contains the data of interest}

  \item{verbose}{if \code{TRUE} an arbitrary list with 7
  slots is returned providing all intermediate results. if
  \code{FALSE} a SpatialPointsDataFrame is returned.}

  \item{parallel}{logical; when \code{TRUE} the packages
  \pkg{foreach} and \pkg{doParallel} will be used for
  parallelizing the calculation on multiple cores. Please
  note: parallelization on 4 cores is slower by one
  magnitude than the latest implemented single core
  algorithm.}

  \item{cores}{integer; number of cores to use for
  parallelization; only relevant when \code{parallel=TRUE}.
  Please note: parallelization on 4 cores is slower by one
  magnitude than the latest implemented single core
  algorithm.}
}
\value{
  By default an object of class SpatialPointsDataFrame is
  returned with \code{length(luid)} columns and
  \code{length(cells)} rows. Each column represents an
  original pixel type. The data specifies the fraction this
  pixel type covers in the new grid cell.

  If verbose output is specified a list containing 7 slots
  is returned: \item{cells}{Vector of integers; cell or
  point numbers within the original grid} \item{xcoord}{x
  coordinates of cell centers} \item{ycoord}{y coordinates
  of cell centers} \item{hrcells}{List with as many numeric
  vectors as there are cells. Each vector has the cell
  values of the original pixels which are to be aggregated
  in the new bigger grid cells.} \item{hrvalues}{List with
  as many tables as there are cells. Each table summarizes
  the unique original pixel types within the new low
  resolution grid cells.} \item{luid}{Vector of integers
  naming all unique cell types of the original grid.}
  \item{lufrac}{Array of \code{dim=c(length(luid),
  length(cells))}; gives the fraction of each original
  pixel type per new grid cell within the low resolution
  grid.}
}
\description{
  The function reads a high resolution grid from an ascii
  grid file, reprojects it and calculates the fractions of
  how much unique orginal pixel types are covered by the
  coarser grid cells
}
\examples{
\dontrun{
  out <- resample_grid(CLUlonglat, generate_grid(), cells=lpj_long_clupos)
}
spplot(smallarea, col.regions=terrain.colors(100), colorkey=TRUE)
grid_lr <- generate_grid(cellcentre.offset=c(-179.75, -59.75))

##verbose=FALSE
out     <- resample_grid(smallarea, grid_lr)
spplot(out, col.regions=rev(terrain.colors(100)), colorkey=TRUE)
coordinates(out)
attr(out, "data")

##verbose=TRUE
out     <- resample_grid(smallarea, grid_lr, verbose=TRUE)
coor    <- cbind(out$xcoord, out$ycoord)
par(mfrow=c(3,2))
for(i in 1:6){
  img     <- out$lufrac[i,]
  img1    <- gridPlot(values=img, coordinates=coor, main=paste("Fraction Type",i,"Land Use"),
    zlim=c(0,1), mar=c(5,4,4,8), xlim=c(128,150), ylim=c(-60,-50),
    cex=1.5
  )
}
}
\author{
  Rene Sachse \email{rene.sachse@uni-potsdam.de}
}
\seealso{
  \code{\link[sp]{over}} in package \pkg{sp}
}
\keyword{CLUMondo}
\keyword{LPJmL,}
\keyword{aggregation,}
\keyword{regridding,}
\keyword{warping,}


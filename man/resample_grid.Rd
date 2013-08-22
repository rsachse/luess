\name{resample_grid}
\alias{resample_grid}
\title{Resampling of a high resolution grid for further use with a grid of coarser resolution}
\usage{
  resample_grid(grid_hr, grid_lr, cells = NULL,
    datacolumn = 1)
}
\arguments{
  \item{grid_hr}{SpatialPointsDataFrame containing the
  geometry of cellcenters of the original high resolution
  grid. Other input geometries might be possible but have
  not been tested so far.}

  \item{grid_lr}{SpatialGrid of the new grid}

  \item{cells}{Only calculations for these cells will be
  returned (e.g. if these are cells with landcover). If
  \code{NULL} values for all cells will be calculated.}

  \item{datacolumn}{integer specifing which column of the
  SpaitalPointsDataFrame contains the data of interest}
}
\value{
  list containing ...
}
\description{
  The function reads a high resolution grid from an ascii
  grid file, reprojects it and calculates the fractions of
  how much unique orginal pixel types are covered by the
  coarser grid cells
}
\author{
  Rene Sachse \email{rene.sachse@uni-potsdam.de}
}
\seealso{
  \code{\link[sp]{over} in package \pkg{sp}}
}
\keyword{aggregation,}
\keyword{CLUMondo}
\keyword{LPJmL,}
\keyword{regridding,}
\keyword{warping,}


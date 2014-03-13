\name{aggregateMosaics}
\alias{aggregateMosaics}
\title{Disentangling multiple mosaics in a grid cell into their basic landuse classes}
\usage{
  aggregateMosaics(data, mosaicFractions)
}
\arguments{
  \item{data}{data.frame or SpatialPointsDataFrame
  providing fractions of the mosaic classes for each grid
  cell. Directly compatible to output of
  \code{\link[luess]{resample_grid}}. Each row needs to sum
  up to exactly 1.}

  \item{mosaicFractions}{data.frame providing fractions of
  basic land use classes which form the mosaics. Needs to
  have as many rows as \code{data} has columns; each row
  needs to sum up to exactly 1.}
}
\value{
  if \code{data} is an object of class
  SpatialPointsDataFrame also an object of
  SpatialPointsDataFrame is returned. Otherwise a simple
  matrix with basic landuse classes is returned.
}
\description{
  The function disentangles multiple mosaics into its basic
  land use classes of which the mosaics in one grid cell
  consist.
}
\examples{
mosaicFractions <- data.frame(
  PFT=c(0,.50,1,0,.10,.30),
  c1=c(.80,.30,0,0,.10,.70),
  c2=c(.20,0,0,.80,.10,0),
  g1=c(0,0,0,.10,.10,0),
  g2=c(0,.20,0,.10,.60,0)
)

grid_lr <- generate_grid(cellcentre.offset=c(-179.75, -59.75))
outMosaic <- resample_grid(smallarea, grid_lr)

outDisentangle <- aggregateMosaics(outMosaic, mosaicFractions)

outDisentangle
}
\author{
  Rene Sachse \email{rene.sachse@uni-potsdam.de}
}
\seealso{
  \code{\link[luess]{resample_grid}} and
  \code{\link[sp]{SpatialPointsDataFrame}} in package
  \pkg{sp}
}
\keyword{CLUMondo}
\keyword{LPJmL}
\keyword{landuse}
\keyword{mosaics}


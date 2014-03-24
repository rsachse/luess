\name{areaCell}
\alias{areaCell}
\title{Calculates Grid Cell Areas for Grids with Geographical Coordinates}
\usage{
areaCell(grid, res = 0.5, dist.lat = 111)
}
\arguments{
  \item{grid}{array, matrix or data.frame with two columns
  for longitude and lattitude of each grid cell}

  \item{res}{numeric, resolution of the grid}

  \item{dist.lat}{numeric, distance between two circles of
  lattitude in km}
}
\value{
returns a vector with areas in km^2 for each grid cell
}
\description{
The function estimates grid cell areas in km^2 for grids in
geographical coordinates (long, lat).
}
\examples{
areaCell(coordinates(lpjGrid))
}
\author{
Rene Sachse \email{rene.sachse@uni-potsdam.de}
}


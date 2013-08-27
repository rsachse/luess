\name{generate_grid}
\alias{generate_grid}
\title{Generates a Spatial Grid}
\usage{
  generate_grid(cellcentre.offset = c(-179.75, -55.75),
    cellsize = c(0.5, 0.5), cells.dim = c(720, 280),
    proj4 = "+proj=longlat")
}
\arguments{
  \item{cellcentre.offset}{numeric; vector with the
  smallest coordinates for each dimension}

  \item{cellsize}{numeric; vector with the cell size in
  each dimension}

  \item{cells.dim}{integer; vector with number of cells in
  each dimension}

  \item{proj4}{A character string of projection arguments;
  the arguments must be entered exactly as in the PROJ.4
  documentation}
}
\value{
  Returns a SpatialGrid.
}
\description{
  The function generates a Spatial Grid. Default values
  provide a grid fitting to the LPJ model requirements.
}
\examples{
lpjgrid <- generate_grid()
lpj_coord <- coordinates(lpjgrid)
plot(lpjgrid)
}
\author{
  Rene Sachse \email{rene.sachse@uni-potsdam.de}
}
\seealso{
  \code{\link[sp]{GridTopology}, \link[sp]{SpatialGrid},
  \link[sp]{CRS}} in package \pkg{sp}
}
\keyword{grid}
\keyword{LPJmL,}


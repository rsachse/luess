\name{matchInputGrid}
\alias{matchInputGrid}
\title{Identify positions of output grid cells in the input grid}
\usage{
  matchInputGrid(grid.in, grid.out)
}
\arguments{
  \item{grid.in}{array with 2 dimensions or object of class
  SpatialGrid providing longitude and lattitude of cell
  centers of the input grid}

  \item{grid.out}{array with 2 dimensions or object of
  class SpatialGrid providing longitude and lattitude of
  cell centers of the output grid}
}
\value{
  vector of integers giving the positions of the output
  grid cells in the input grid
}
\description{
  The function identifies positions of cells of the output
  grid within the input grid. This is helpful in cases the
  output grid has a smaller number of cells than the input
  grid.
}
\examples{
mygrid       <- generate_grid()
pos_in_input <- matchInputGrid(coordinates(mygrid), lpj_short_outgrid)
plot(coordinates(mygrid)[pos_in_input,], col="green", pch=".")
}
\author{
  Rene Sachse \email{rene.sachse@uni-potsdam.de}
}
\keyword{cells,}
\keyword{CLUMondo}
\keyword{grid}
\keyword{grid,}
\keyword{LPJ,}
\keyword{LPJml,}
\keyword{positions,}


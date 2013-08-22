\name{transform_asciigrid}
\alias{transform_asciigrid}
\title{Reads an ASCII gridfile and performs spatial transformation}
\usage{
  transform_asciigrid(file = "land_systems.asc",
    proj4_input = "+proj=eck4 +lon_0=0 +x_0=0 +y_0=0",
    proj4_output = "+proj=longlat", plotresult = FALSE)
}
\arguments{
  \item{file}{character string; file name}

  \item{proj4_input}{character string; procjection
  arguments for the input Spatial Grid}

  \item{proj4_output}{character string; projection
  arguments for the Spatial Data returned}
}
\value{
  returns a SpatialPointsDataFrame in most cases
}
\description{
  The function reads a map from ASCII grid files and
  performs spatial transformation to other projections. In
  most cases no regular grid results after reprojction,
  therefore the output in is a SpatialPointsDataFrame.
}
\author{
  Rene Sachse \email{rene.sachse@uni-potsdam.de}
}
\seealso{
  \code{\link[sp]{read.asciigrid}, \link[sp]{spTransform}}
  in package \pkg{sp}
}
\keyword{asc,}
\keyword{asciigrid,}
\keyword{map}
\keyword{projection}


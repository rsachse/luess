\name{writeLpjLanduse}
\alias{writeLpjLanduse}
\title{Writes a new binary LPJmL landuse input file}
\usage{
writeLpjLanduse(data, fileOut, header = NULL)
}
\arguments{
  \item{data}{Array with three dimensions: \code{[years,
  pixels, cfts]}.}

  \item{fileOut}{A character string naming the file to
  write to.}

  \item{header}{When \code{NULL} no header is written and
  data is appended to an existing file. Otherwise a list
  providing the 10 elements of a valid header need to be
  given: \enumerate{ \item header name \item header version
  \item order \item firstyear \item nyear \item firstcell
  \item ncell \item nbands \item resolution \item scaling
  }}
}
\description{
The function writes a new or appends a binary LPJmL landuse
input file.
}
\author{
Rene Sachse (rene.sachse@uni-potsdam.de)
}
\keyword{LPJ,}
\keyword{LPJmL}


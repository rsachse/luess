\name{writeLpjLanduse}
\alias{writeLpjLanduse}
\title{Writes a new binary LPJmL landuse input file}
\usage{
writeLpjLanduse(data, fileOut, header = NULL, append = FALSE)
}
\arguments{
  \item{data}{Array with three dimensions: \code{[years,
  pixels, cfts]}.}

  \item{fileOut}{A character string naming the file to
  write to.}

  \item{header}{A list providing the 10 elements of a valid
  header: \enumerate{ \item header name \item header
  version \item order \item firstyear \item nyear \item
  firstcell \item ncell \item nbands \item resolution \item
  scaling } The header is only needed when \code{where} is
  \code{NULL} otherwise no new file needs to be created and
  the existing file already has a header.}

  \item{append}{logical, specifying whether the data should
  be appended to an existing file or not. If \code{FALSE} a
  new file will be created.}
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


\name{writeLpjHeader}
\alias{writeLpjHeader}
\title{Writes the header to a new binary LPJmL input file}
\usage{
  writeLpjHeader(fileOut, header)
}
\arguments{
  \item{fileOut}{A \code{\link{connections}} object
  pointing to the file to write the header to.}

  \item{header}{a list providing the 10 elements of a valid
  header: \enumerate{ \item header name \item header
  version \item order \item firstyear \item nyear \item
  firstcell \item ncell \item nbands \item resolution \item
  scaling }}
}
\description{
  The function writes the header of a new binary LPJmL
  input file.
}
\author{
  PIK, modified by Rene Sachse (rene.sachse@uni-potsdam.de)
}
\keyword{LPJ,}
\keyword{LPJmL}


\name{readLpjHeader}
\alias{readLpjHeader}
\title{Reads the header of binary LPJmL input files}
\usage{
readLpjHeader(fileIn, nChar = 7)
}
\arguments{
  \item{fileIn}{character string naming the path and file
  to read the header from.}

  \item{nChar}{integer, number of chars of the header name}
}
\value{
Returns a list with 10 elements: \enumerate{ \item header
name \item header version \item order \item firstyear \item
nyear \item firstcell \item ncell \item nbands \item
resolution \item scaling }
}
\description{
The function reads the header of binary LPJmL input files.
}
\author{
PIK, modified by Rene Sachse (rene.sachse@uni-potsdam.de)
}
\keyword{LPJ,}
\keyword{LPJmL}


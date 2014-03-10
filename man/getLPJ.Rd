\name{getLPJ}
\alias{getLPJ}
\title{Reads binary LPJmL input and output files}
\usage{
getLPJ(filename, first_year_ts, last_year_ts, first_year, nband, sizeof_data,
  typeof_data = integer(), sizeof_header = 0, ncell = 67420,
  byrow = TRUE)
}
\arguments{
  \item{filename}{character string; file name}

  \item{first_year_ts}{integer; first year of the time
  series which should be read in}

  \item{last_year_ts}{integer; last year of the time series
  which should be read in}

  \item{first_year}{integer; first year which the data file
  contains}

  \item{nband}{integer; number of data bands (e.g. number
  of CFTs or PFTs)}

  \item{sizeof_data}{integer; size of each data entry in
  bytes}

  \item{typeof_data}{\code{integer()} or \code{double()};
  depends on \code{sizeof_data}.  If \code{sizeof_data=2}
  than only \code{integer()} is possible.}

  \item{sizeof_header}{integer; size of the header in
  bytes}

  \item{ncell}{integer, number of pixels}

  \item{byrow}{logical; determines if bands are sorted by
  cells (\code{TRUE}) like the landuse input or by bands
  (\code{FALSE}) which is standard for the output files.}
}
\value{
returns an array of dimensions \code{[years, pixels,
nbands]}
}
\description{
The function reads binary LPJmL input and output files into
an array structure.
}
\examples{
\dontrun{
  cftfrac <- getLPJ("landuse.bin", 2000, 2000, 1700, 32, 2, sizeof_header=43)
  pftfrac <- getLPJ("fpc.bin", 2000, 2000, 1901, 10, 4, double(), byrow=FALSE)
}
}
\author{
Rene Sachse \email{rene.sachse@uni-potsdam.de}
}
\seealso{
\code{\link{seek}, \link{readBin}}
}
\keyword{LPJml,}
\keyword{binary}
\keyword{data}


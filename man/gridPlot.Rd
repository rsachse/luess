\name{gridPlot}
\alias{gridPlot}
\title{Plotting of grids, maps and contours.}
\usage{
  gridPlot(values, coordinates, res = 0.5, main = "",
    clab = "", col = terrain.colors(1000)[1000:1],
    plot = TRUE, addcountries = FALSE, axes = TRUE,
    cex = 2.5, mar = c(5, 4, 4, 6), xlim = c(-180, 180),
    ylim = c(-60, 90), ...)
}
\arguments{
  \item{values}{numeric vector; values to be plotted at
  each set of coordinates}

  \item{coordinates}{matrix, array or data.frame with 2
  dimensions providing longitudes and lattitudes}

  \item{res}{numeric; resolution of the grid}

  \item{main}{character string; plot title}

  \item{clab}{character string; key title}

  \item{col}{Sequence of colors used for the colorkey}

  \item{plot}{logical, wheater or not a plot should be
  drawn}

  \item{addcountries}{logical, weather or not simple
  country borders should be added to the plot}

  \item{axes}{logical, weather or not axes are to be drawn}

  \item{cex}{numeric, scaling of fonts}

  \item{mar}{numeric vector of 4, margins for the plot
  \code{c(bottom, left, top, right)}}

  \item{xlim}{numeric vector of 2; range of x-axis}

  \item{ylim}{numeric vector of 2; range of y-axis}

  \item{...}{further arguments passed to
  \code{\link[plot3D]{image2D}}}
}
\value{
  Returns a list with \code{x} x-coordinates, \code{y}
  y-coordinates and and matrix \code{z} containing the data
  values. If \code{plot==TRUE} also a map will be plotted
}
\description{
  The function arranges data for plots of color maps of
  georeferenced data points. The plot can also be produced
  by this function.
}
\examples{
nrc  <- sapply(CLUtoLPJ2040$hrcells, length)
coor <- cbind(CLUtoLPJ2040$xcoord, CLUtoLPJ2040$ycoord)
mySpectral <- colorRampPalette(c(brewer.pal(11, "Spectral"), "navy"))
myPalette  <- colorRampPalette(c(brewer.pal(11, "RdYlBu"), "darkblue"))
img <- gridPlot(
 values=nrc,
 coordinates=coor,
 main="CLUMondo Grid Cells per LPJ cell",
 clab="",
 res=0.5,
 plot=TRUE,
 axes=TRUE,
 col=rev(mySpectral(50)),#rev(myPalette(50)),
 mar=c(5,4,4,10)
)
}
\author{
  Rene Sachse \email{rene.sachse@uni-potsdam.de}
}
\seealso{
  \code{\link[plot3D]{image2D} in package \pkg{plot3D}}
}
\keyword{maps}
\keyword{plot}

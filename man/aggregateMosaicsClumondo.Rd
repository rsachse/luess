\name{aggregateMosaicsClumondo}
\alias{aggregateMosaicsClumondo}
\title{Aggregating CLUMondo mosaics to basic landuse classes (natveg, pasture, cropland) for the whole globe}
\usage{
aggregateMosaicsClumondo(data, mosaics, worldregions)
}
\arguments{
  \item{data}{SpatialPointsDataFrame providing fractions of
  the mosaic classes for each grid cell. Directly
  compatible to output of
  \code{\link[luess]{resample_grid}}. Each row needs to sum
  up to exactly 1.}

  \item{mosaics}{data.frame providing fractions of basic
  land use classes which form the mosaics. Needs to have as
  many rows as \code{data} has columns; each row needs to
  sum up to exactly 1.}

  \item{worldregions}{SpatialPointsDataFrame providing the
  column CLUWORDREGION. Needs to have same order as
  \code{data}. Region names in this column need to
  correspond to dimnames in \code{mosaics}.}
}
\value{
Returns an object of class SpatialPointsDataFrame.
}
\description{
The function aggregates CLUMondo mosaics into its basic
land use classes: natveg, pasture and cropland. Since
CLUMondo is split in 24 world regions, the function applies
the specific mosaic tables for each region.
}
\examples{
out <- resample_grid(CLUlonglat, generate_grid(), cells=lpj_long_clupos)
cluAgg <- aggregateMosaicsClumondo(out, CLUMosaics, lpjGrid)
gridPlot(cluAgg@data[,"pasture"], zlim=c(0,1), main="pasture")
gridPlot(cluAgg@data[,"cropland"], zlim=c(0,1), main="cropland")
gridPlot(cluAgg@data[,"natveg"], zlim=c(0,1), main="natveg")
gridPlot(rowSums(cluAgg@data), main="cover")
}
\author{
Rene Sachse \email{rene.sachse@uni-potsdam.de}
}
\seealso{
\code{\link[luess]{aggregateMosaics}},
\code{\link[luess]{resample_grid}} and
\code{\link[sp]{SpatialPointsDataFrame}} in package
\pkg{sp}
}
\keyword{CLUMondo}
\keyword{LPJmL}
\keyword{landuse}
\keyword{mosaics}


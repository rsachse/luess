#' Plotting of grids, maps and contours.
#'
#' The function arranges data for plots of color maps of georeferenced data points.
#' The plot can also be produced by this function.
#' 
#' @param values numeric vector; values to be plotted at each set of coordinates
#'  
#' @param coordinates matrix, array or data.frame with 2 dimensions providing longitudes and lattitudes
#' 
#' @param res numeric; resolution of the grid
#'  
#' @param main character string; plot title
#' 
#' @param clab character string; key title
#' 
#' @param col Sequence of colors used for the colorkey
#' 
#' @param plot logical, wheater or not a plot should be drawn
#' 
#' @param addcountries logical, weather or not simple country borders should be added to the plot
#' 
#' @param axes logical, weather or not axes are to be drawn
#' 
#' @param cex numeric, scaling of fonts
#' 
#' @param mar numeric vector of 4, margins for the plot \code{c(bottom, left, top, right)}
#' 
#' @param xlim numeric vector of 2; range of x-axis
#' 
#' @param ylim numeric vector of 2; range of y-axis
#' 
#' @param ... further arguments passed to \code{\link[plot3D]{image2D}}
#' 
#' @return Returns a list with \code{x} x-coordinates, \code{y} y-coordinates 
#' and and matrix \code{z} containing the data values. If \code{plot==TRUE} also
#' a map will be plotted
#'
#' @author Rene Sachse \email{rene.sachse@@uni-potsdam.de}
#'
#' @keywords plot maps
#'
#' @seealso \code{\link[plot3D]{image2D} in package \pkg{plot3D}}
#' 
#' @examples
#' nrc  <- sapply(CLUtoLPJ2040$hrcells, length)
#' coor <- cbind(CLUtoLPJ2040$xcoord, CLUtoLPJ2040$ycoord)
#' mySpectral <- colorRampPalette(c(brewer.pal(11, "Spectral"), "navy"))
#' myPalette  <- colorRampPalette(c(brewer.pal(11, "RdYlBu"), "darkblue"))
#' img <- gridPlot(
#'   values=nrc,
#'   coordinates=coor,
#'   main="CLUMondo Grid Cells per LPJ cell", 
#'   clab="", 
#'   res=0.5,
#'   plot=TRUE,
#'   axes=TRUE,
#'   col=rev(mySpectral(50)),#rev(myPalette(50)), 
#'   mar=c(5,4,4,10) 
#' )
gridPlot <- function(
  values, 
  coordinates, 
  res=0.5, 
  main="", 
  clab="", 
  col=terrain.colors(1000)[1000:1], 
  plot=TRUE, 
  addcountries=FALSE, 
  axes=TRUE,
  cex=2.5,
  mar=c(5,4,4,6),
  xlim = c(-180,180),
  ylim = c(-60,90),
  ...
){
  ncell     <- length(coordinates[,1])
  grid_x    <- coordinates[,1]
  grid_y    <- coordinates[,2]
  ext_lon   <- c(min(grid_x),max(grid_x))
  ext_lat   <- c(min(grid_y),max(grid_y))
  grid_ilon <- as.integer((grid_x-ext_lon[1])/res + 1.01)
  grid_ilat <- as.integer((grid_y-ext_lat[1])/res + 1.01)
  grid_nrow <- (ext_lat[2]-ext_lat[1])/res+1
  grid_ncol <- (ext_lon[2]-ext_lon[1])/res+1  
  img <- array(data=NA, dim=c(grid_nrow,grid_ncol))
  for(c in 1:ncell){
    img[grid_ilat[c], grid_ilon[c]] <- values[c]
  }
  if(plot==TRUE){
    par(mar=mar)
    image2D(x=seq(ext_lon[1],ext_lon[2],by=res),
            y=seq(ext_lat[1],ext_lat[2],by=res),
            z=t(img[,]),
            asp=NA,tcl=-0.2,
            yaxp=c(ylim,4),xaxp=c(xlim,4),
            xlab="",ylab="",
            axes=axes,cex.main=cex,colkey=FALSE,
            col=col,
            main=main,clab="",
            #cex.axis=cex,
            ...
    )
    if(addcountries==TRUE){
      data(wrld_simpl)
      plot(wrld_simpl,add = T, lwd = 1.2)
    }
    colkey(
      col,
      c(min(img,na.rm=TRUE),max(img,na.rm=TRUE)), 
      clab, 
      add=TRUE, 
      cex.clab=cex, 
      cex.axis=cex
    )
  }
  return(
    list(
      x=seq(ext_lon[1],ext_lon[2],by=res), 
      y=seq(ext_lat[1],ext_lat[2],by=res), 
      z=t(img[,]) 
    )
  )
}

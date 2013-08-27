#' Plotting of grids, maps and contours.
#'
#' The function arranges data for plots of color maps of georeferenced data points.
#' The plot can also be produced by this function.
#' 
#' @param values numeric vector; values to be plotted at each set of coordinates
#'  
#' @param coordinates matrix, array or data.frame with 2 dimensions providing longitudes and lattitudes. 
#' Need to have regular distances according to \code{res}. 
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
#' @param zlim numeric vector of 2; range of values. If \code{NULL} zlim is calculated
#' automatically by \code{range(values)}.
#' 
#' @param colkey logical, whether or not a colorkey should be added to the plot
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
#' @seealso \code{\link[plot3D]{image2D}} in package \pkg{plot3D}
#' 
#' @examples
#' ## count CLUMondo cells in aggregated 0.5° cells of LPJ
#' nrc  <- sapply(CLUtoLPJ2040long$hrcells, length)
#' coor <- cbind(CLUtoLPJ2040long$xcoord, CLUtoLPJ2040long$ycoord)
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
#' 
#' ## show some aggregated CLUMondo data
#' coor    <- cbind(CLUtoLPJ2040long$xcoord, CLUtoLPJ2040long$ycoord)
#' forest  <- CLUtoLPJ2040long$lufrac[19,] 
#' periurb <- CLUtoLPJ2040long$lufrac[29,] 
#' urban   <- CLUtoLPJ2040long$lufrac[30,] 
#' natgrass<- CLUtoLPJ2040long$lufrac[24,] 
#' cropint <- CLUtoLPJ2040long$lufrac[9,] 
#' 
#' purb     <- colorRampPalette(brewer.pal(9, "PuRd"))
#' reds     <- colorRampPalette(c("gray", brewer.pal(9, "Reds")))
#' oranges  <- colorRampPalette(c("gray", brewer.pal(9, "Oranges")))
#' 
#' img_forest  <- gridPlot(values=forest, main="Fraction of Dense Forest", mar=c(5,4,4,8))
#' img_periurb <- gridPlot(values=periurb, main="Fraction of Peri Urban", col=purb(1000), mar=c(5,4,4,8))
#' img_urban   <- gridPlot(values=urban, main="Fraction of Urban", col=reds(1000), mar=c(5,4,4,8))
#' img_natgrass<- gridPlot(values=natgrass, main="fraction of natural grassland", mar=c(5,4,4,8))
#' img_cropint <- gridPlot(values=cropint,  main="fraction of intensive cropland", col=oranges(1000), mar=c(5,4,4,8))
gridPlot <- function(
  values, 
  coordinates  = lpj_ingrid, 
  res          = 0.5, 
  main         = "", 
  clab         = "", 
  col          = terrain.colors(1000)[1000:1], 
  plot         = TRUE, 
  addcountries = FALSE, 
  axes         = TRUE,
  cex          = 2.5,
  mar          = c(5,4,4,6),
  xlim         = c(-180,180),
  ylim         = c(-60,90),
  zlim         = NULL,
  colkey       = TRUE,
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
  if(is.null(zlim)==TRUE){
    zlim <- range(values, na.rm=TRUE)
  }
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
            main=main,clab="",xlim=xlim, ylim=ylim,
            zlim=zlim,
            #cex.axis=cex,
            ...
    )
    if(addcountries==TRUE){
      data(wrld_simpl)
      plot(wrld_simpl,add = T, lwd = 1.2)
    }
    if(colkey==TRUE){
      colkey(
        col,
        zlim,#c(min(img,na.rm=TRUE),max(img,na.rm=TRUE)), 
        clab, 
        add=TRUE, 
        cex.clab=cex, 
        cex.axis=cex
      )
    }
  }
  return(
    list(
      x=seq(ext_lon[1],ext_lon[2],by=res), 
      y=seq(ext_lat[1],ext_lat[2],by=res), 
      z=t(img[,]) 
    )
  )
}

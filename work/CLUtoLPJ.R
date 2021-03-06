#### mini example
library(luess)
grid_hr <- transform_asciigrid("smallarea.asc") 
smallarea <- grid_hr
#save(smallarea, file="../data/smallarea.rda")
spplot(grid_hr)
grid_lr <- generate_grid(cellcentre.offset=c(-179.75, -59.75))
system.time(
  out     <- resample_grid(grid_hr, grid_lr, verbose=TRUE)
)
coor    <- cbind(out$xcoord, out$ycoord)

par(mfrow=c(3,2))
for(i in 1:6){
  img     <- out$lufrac[i,] 
  img1    <- gridPlot(values=img,coordinates=coor, main=paste("Fraction Type",i,"Land Use"), zlim=c(0,1), mar=c(5,4,4,8), xlim=c(128,150), ylim=c(-60,-50))
}
## aggregate CLUMondo map
library(luess)
CLUlonglat <- transform_asciigrid("land_systems.asc")
#save(CLUlonglat, file="../data/CLUlonglat.rda")
lpjgrid    <- generate_grid()
system.time(
  out      <- resample_grid(CLUlonglat, lpjgrid, cells=lpj_long_clupos)
)
CLUtoLPJ2040long <- out
#save(CLUtoLPJ2040long, file="../data/CLUtoLPJ2040long.rda")


tt <- system.time(
  out1      <- resample_grid(CLUlonglat, lpjgrid, cells=40000:41000)
)
print(tt)

tt <- system.time(
  out2      <- resample_grid(CLUlonglat, lpjgrid, cells=40000:41000, parallel=TRUE, cores=2)
)
print(tt)

identical(out1, out2)
###### plot CLU dense forest

## global
spplot(CLUlonglat, pch=".")

## africa zoom
spplot(CLUlonglat, pch=".",xlim=c(-10,30), ylim=c(-20,20))

######



###### identify lpj-cells in aggregated CLUMondo grid
cluagg_grid <- generate_grid()
lpj_long_clupos <- matchInputGrid(coordinates(cluagg_grid), lpj_ingrid)
#save(lpj_long_clupos, file="../data/lpj_long_clupos.rda")

lpj_short_clupos <- matchInputGrid(coordinates(cluagg_grid), lpj_short_outgrid)
#save(lpj_short_clupos, file="../data/lpj_short_clupos.rda")



######

#40000:40100)#

hrc <- out$hrcells
hh <- sapply(hrc, length)

hist(hh)


###### zoom into overlapping grids of LPJ and CLUMondo
mygrid <- lpjgrid

hrc <- CLUtoLPJ2040$hrcells
hh <- sapply(hrc, length)
hist(hh)

id <- which(hh > 47)
plot(coordinates(mygrid), pch=".")
points(CLUlonglat, col="green", pch=".")
points(lpj_short_outgrid[id,], col="red", pch=16)

plot(coordinates(mygrid), pch=15, xlim=c(-53.5,-55), ylim=c(-1.5,-0))
points(CLUlonglat, col="green", pch=15)
points(lpj_short_outgrid[id,], col="red", pch=16)
abline(v=c(-53.5,-54,-54.5, -55))
abline(h=c(0,-0.5,-1,-1.5))

id <- which(hh < 5)
plot(coordinates(mygrid), pch=".")
points(CLUlonglat, col="green", pch=".")
points(lpj_short_outgrid[id,], col="red", pch=16)

plot(coordinates(mygrid), pch=15, xlim=c(4,6), ylim=c(59,63))
abline(h=seq(59,63,0.5))
abline(v=seq(4,6,0.5))
points(CLUlonglat, col="green", pch=15)
points(lpj_short_outgrid[id,], col="red", pch=16)

id <- which(hh < 1)
plot(coordinates(mygrid), pch=".")
points(CLUlonglat, col="green", pch=".")
points(lpj_short_outgrid[id,], col="red", pch=16)
######

nrc  <- sapply(CLUtoLPJ2040$hrcells, length)
coor <- cbind(CLUtoLPJ2040$xcoord, CLUtoLPJ2040$ycoord)
gridPlot(values=nrc,coordinates=coor,res=0.5,plot=TRUE)


###### validation plots for aggregated CLUMondo output to 0.5° cells
coor    <- cbind(CLUtoLPJ2040long$xcoord, CLUtoLPJ2040long$ycoord)
forest  <- CLUtoLPJ2040long$lufrac[18,] 
periurb <- CLUtoLPJ2040long$lufrac[29,] 
urban   <- CLUtoLPJ2040long$lufrac[30,] 
natgrass<- CLUtoLPJ2040long$lufrac[24,] 
cropint <- CLUtoLPJ2040long$lufrac[9,] 

purb     <- colorRampPalette(brewer.pal(9, "PuRd"))
reds     <- colorRampPalette(c("gray", brewer.pal(9, "Reds")))
oranges  <- colorRampPalette(c("gray", brewer.pal(9, "Oranges")))

img_forest  <- gridPlot(values=forest, coordinates=coor, res=0.5, plot=TRUE, main="Fraction of Dense Forest", mar=c(5,4,4,8))
img_periurb <- gridPlot(values=periurb, coordinates=coor, res=0.5, plot=TRUE, main="Fraction of Peri Urban", col=purb(1000), mar=c(5,4,4,8))
img_urban   <- gridPlot(values=urban, coordinates=coor, res=0.5, plot=TRUE, main="Fraction of Urban", col=reds(1000), mar=c(5,4,4,8))
img_natgrass<- gridPlot(values=natgrass, coordinates=coor, res=0.5, plot=TRUE, main="fraction of natural grassland", mar=c(5,4,4,8))


img_cropint <- gridPlot(values=cropint, coordinates=coor, res=0.5, plot=TRUE, main="fraction of intensive cropland", col=oranges(1000), mar=c(5,4,4,8), xlim=c(-15,15), ylim=c(45,65))
img_forest  <- gridPlot(values=forest, main="Fraction of Dense Forest b", mar=c(5,4,4,8))


forest  <- CLUtoLPJ2040long$lufrac[19,] 
img_forest  <- gridPlot(values=forest, main="Fraction of Dense Forest b", mar=c(5,4,4,8))


###### new output format of resample_grid()
#forest      <- CLUtoLPJ2040long@data[,19]
forest      <- attr(CLUtoLPJ2040long, "data")[,19]
img_forest  <- gridPlot(values=forest, main="Fraction of Dense Forest b", mar=c(5,4,4,8))




###### testing

lc <- coordinates(lpjgrid)
ll <- getCoordinates(degree=TRUE, order="lpj")

pos_in_input <- array(data=NA,dim=length(ll)/2)
for (c in 1:(length(ll)/2)){
  print(c)
  x_temp <- which(lc[,1]==ll[c,1] ,arr.ind=TRUE)
  y_temp <- which(lc[,2]==ll[c,2],arr.ind=TRUE)
  pos_in_input[c] <- intersect(x_temp,y_temp)
}
  
plot(coordinates(lpjgrid)[pos_in_input,], col="green", pch=".")

save(pos_in_input, file="pos_in_input.RData")

system.time(
  out      <- resample_grid(CLUlonglat, lpjgrid)
)



### overlay lpjgrid with CLUMondo map
res  <- over(geometry(CLUlonglat), lpjgrid)
reso <- resample_grid(CLUlonglat, lpjgrid)


X11()
plot(lpjgrid)
points(CLUlonglat)
points(CLUlonglat, col="green", pch=".")

### some checks if coordinates match
library(landuse)
aa         <- getCoordinates(degree=TRUE, order="lpj")
plot(aa, xlim=c(60,65), ylim=c(60,65),pch=16)
points(coordinates(lpjgrid), col="red", pch=16)
cc         <- coordinates(CLUlonglat)
points(cc, pch=15, col="green")

X11()
plot(aa, pch=".")#, xlim=c(-100,0), ylim=c(75,83))
points(cc, pch=".", col="green")
library(maptools)
data(wrld_simpl)
plot(wrld_simpl, add=TRUE)

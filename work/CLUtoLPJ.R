library(luess)
CLUlonglat <- transform_asciigrid("land_systems.asc")
lpjgrid    <- generate_grid()
system.time(
  out      <- resample_grid(CLUlonglat, lpjgrid, cells=40000:40100)#lpj_short_clupos)
)

hrc <- out$hrcells
hh <- sapply(hrc, length)

hist(hh)
######

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


######

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

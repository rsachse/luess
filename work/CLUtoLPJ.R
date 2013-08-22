library(luess)
CLUlonglat <- transform_asciigrid("land_systems.asc")
lpjgrid    <- generate_grid()
system.time(
  out      <- resample_grid(CLUlonglat, lpjgrid, cells=40000:40100)
)


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

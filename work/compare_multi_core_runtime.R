library(luess)

lpjgrid <- generate_grid()

tt <- system.time(
  out1      <- resample_grid(CLUlonglat, lpjgrid, cells=lpj_long_clupos)
)
print(tt)

forest <- gridPlot(out1@data[,19], coordinates(out1))
natgr  <- gridPlot(out1@data[,24], coordinates(out1))



tt <- system.time(
  out2      <- resample_grid(CLUlonglat, lpjgrid, cells=lpj_long_clupos, parallel=TRUE, cores=2)
)
print(tt)

identical(out1, out2)


#### idea for more time saving
oo <- over(geometry(CLUlonglat), generate_grid())
odat <- data.frame(LU=CLUlonglat@data[,1], ID=oo)
oag <- aggregate(list(odat$LU), list(odat$ID), c)
id <- match(lpj_long_clupos, oag[,1])
out <- oag[id,]
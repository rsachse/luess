library(luess)

lpjgrid <- generate_grid()

tt <- system.time(
  out1      <- resample_grid(CLUlonglat, lpjgrid, cells=lpj_long_clupos)
)
print(tt)

tt <- system.time(
  out2      <- resample_grid(CLUlonglat, lpjgrid, cells=lpj_long_clupos, parallel=TRUE, cores=2)
)
print(tt)

identical(out1, out2)

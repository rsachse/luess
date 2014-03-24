tp <- 37000
par(mfrow=c(1,1))

png("window.png", width=4000, height=3000, res=600)
plot(lpjGrid, pch=".")
bar <- apply(
  coordinates(lpjGrid)[tp:(tp+10),],
  1,
  getNearPoints,
  coordsGrid=coordinates(lpjGrid),
  range=10
)

grid <- coordinates(lpjGrid)
points(grid[bar[[1]],1], grid[bar[[1]],2], pch=15, col="green", cex=0.3)
points(grid[tp,1], grid[tp,2], pch = 15, col="red")
dev.off()
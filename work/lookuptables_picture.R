png("lookup_tables.png", width=15000, height=10000, res=800)
par(mfrow=c(4,6), mar=c(5,10,4,1))
for(i in 1:24){
  image(t(CLUMosaics[,4:8,i]), ylim=c(1,0), main=dimnames(CLUMosaics)[[3]][i], axes=FALSE, frame.plot=TRUE)
  axis(1, seq(0,1, length=5), dimnames(CLUMosaics)[[2]][4:8], las=2)
  axis(2, seq(0,1, length=30), dimnames(CLUMosaics)[[1]], las=1)
}
dev.off()

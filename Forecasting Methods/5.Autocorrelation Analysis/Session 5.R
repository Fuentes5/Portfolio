#autocorrelation

library("fpp2")

df = read.csv("SurtidoCookies.csv")

x = unlist(df[,2:5])

Acf(x, lag.max=24, plot=FALSE)
#show acf values for the first 24 lags

ggAcf(x, lag =24 )
#show correlogram






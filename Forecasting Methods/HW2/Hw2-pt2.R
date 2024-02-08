library("fpp2")

str(dj)
anyNA(dj)


#Window
mydj <- window(dj, start=(50))
View(mydj)


#correlogram
ggAcf(mydj, lag=60)

#create time series with the window starting from 50th day showing daily frequency
ts = ts(mydj, start = c(50,1), frequency = 1)

autoplot(ts) + ggtitle("trading days of the Dow Jones Index") + xlab("days") + ylab("volume")


#daily change
ddj <- diff(mydj)

ggAcf(ddj, lag = 30)

#setwd("C:/Users/Student/Documents/myrstudio (Forecast)/HW2")

library("fpp2")

df = read.csv("SeaLevel-2.csv")

str(df)
anyNA(df)

#corellogram
ggAcf(df[,3], lag=1200) + ggtitle("Monthly.MRSL.In.Meters")
ggAcf(df[,2], lag=1200) + ggtitle("month")
ggAcf(df[,1], lag=1200) + ggtitle("Year")

#Time Series
ts = ts(df[,3],start = c(1921,1), frequency = 12)
autoplot(ts) + ggtitle("Monthly MRSL In Meters") + xlab("year") + ylab("MRSL In Meters")

library("fpp2")

df = marathon
anyNA(df)
ggAcf(df, lag=24)
plot(df)


ts = ts(df, start = c(1930,1), end = c(2016,1))
autoplot(ts)


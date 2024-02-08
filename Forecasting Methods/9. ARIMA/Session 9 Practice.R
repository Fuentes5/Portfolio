#setwd("C:/Users/jfuentes1/Documents/myrstudio (Forecast)/9. ARIMA")

library("fpp2")

df1 = read.csv("31Nos.csv")
df2 = read.csv("QuarterlyLoans.csv")

#Case 1
ts1 = ts(df1, start=c(2001,1), end = c(2006,4), frequency = 4)
autoplot(ts1)

dif_ts1 = diff(ts1)
autoplot(dif_ts1)


#Case 2





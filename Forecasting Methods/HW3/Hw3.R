#> setwd("C:/Users/jfuentes1/Documents/myrstudio (Forecast)/HW3")


library("fpp2")

df1=read.csv("annual_csv.csv")
View(df1)

df1=df1[order(df1$Year), ]
View(df1)

str(df1)
anyNA(df1)


ggAcf(df1$Mean, lag=100)

ts= ts(df1$Mean, start = c(1880,1),frequency = 1)

autoplot(ts) +xlab("Year")+ylab("Average Temperature") + ggtitle("annual global-scale temperatures ")

#partitionin
test = tail(ts,max(length(ts)*0.2,4))

training = head(ts,length(ts)-length(test))






#simple Naive
SN = naive(training,length(test))
checkresiduals(SN)

#drift method
drift = rwf(training,length(test),drift=TRUE)
checkresiduals(drift)


#seasonal naive
SeasonalNaive = snaive(training,length(test))
checkresiduals(SeasonalNaive)

#simple average
SA = meanf(training,length(test))
checkresiduals(SA)

#exponential smoothing
ES = ses(training,length(test))
checkresiduals(ES)


accuracy(SN,test)[2,]
  accuracy(SeasonalNaive,test)[2,]

accuracy(drift,test)[2,]
accuracy(ES,test)[2,]
accuracy(SA,test)[2,]


prediction = ses(ts,10)
autoplot(prediction)
prediction

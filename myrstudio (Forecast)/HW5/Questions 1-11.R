#setwd("C:/Users/jfuentes1/Documents/myrstudio (Forecast)/HW5")

library("fpp2")

#call the data
df=read.csv("KSales-1.csv")

#create a time series object
ts =ts(df,start = c(1997,1), frequency =12)

#create correlogram with lag of 60
ggAcf(ts, lag=60)

#visualize time series
autoplot(ts)

#create differencing by 1
#dif_ts = diff(ts,differencing = 1)
#autoplot(dif_ts)

#partitioning using no differencing
test = tail(ts,max(length(ts)*0.2,12))
training = head(ts, length(ts)-length(test))

#___________Holt Winter's Method
hw_A = hw(training,seasonal="additive", length(test))
checkresiduals(hw_A)

hw_M = hw(training,seasonal="multiplicative", length(test))
checkresiduals(hw_M)

#__________ARIMA
model1 = auto.arima(training, 
                    stepwise = FALSE,
                    approximation = FALSE)
model1


model2 = auto.arima(training)
model2

model1pred = forecast(model1, length(test))
model2pred = forecast(model2, length(test))


accuracy(hw_A,test)[2,]
accuracy(hw_M,test)[2,]
accuracy(model1pred,test)[2,]
accuracy(model2pred,test)[2,]



predictions = hw(ts,seasonal = "multiplicative", 7)

autoplot(predictions)+ autolayer(fitted(predictions), series = "fitted")







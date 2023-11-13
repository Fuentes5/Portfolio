library("fpp2")

usmelec
anyNA(usmelec)

ggAcf(usmelec, lag=24)
#downward trend, seasonality
#seasonal ARIMA can be propperly applied

#partitioning
test = tail(usmelec,max(length(usmelec)*0.2,12))
train = head(usmelec,length(usmelec)-length(test))

#building model
model1 = auto.arima(train,stepwise = FALSE,
                    approximation = FALSE)
model1
model2 = auto.arima(train)
model2

#apply both models on test
model1pred = forecast(model1,length(test))
model2pred = forecast(model2,length(test))


#performance of model on test by errors
accuracy(model1pred)[2,]
accuracy(model2pred)[2,]

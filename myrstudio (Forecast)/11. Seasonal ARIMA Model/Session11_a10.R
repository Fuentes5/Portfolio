setwd("C:/Users/jfuentes1/Documents/myrstudio (Forecast)/11. Seasonal ARIMA Model")

library("fpp2")

a10
anyNA(a10)

ggAcf(a10, lag=24)
#trend seasonality

#partitioning
test = tail(a10,max(length(a10)*0.2,12))
training = head(a10, length(a10)-length(test))



#model building

model1 = auto.arima(training, 
                   stepwise = FALSE,
                   approximation = FALSE)
model1


model2 = auto.arima(training)
model2

#apply both model on test
model1pred = forecast(model1, length(test))
model2pred = forecast(model2, length(test))



#performance of model on test by error
accuracy(model1pred,test)[2,]
accuracy(model2pred,test)[2,]

#by MAPE which model is best
#Model 1


#Apply best model for future predictions
model = arima(a10, order = c(2,1,0), seasonal = c(2,1,0))

predictions = forecast(model, 12)

autoplot(predictions) + autolayer(fitted(predictions), series = "fitted")








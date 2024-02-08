#setwd("C:/Users/jfuentes1/Documents/myrstudio (Forecast)/10. Box-Jenkins ARIMA")

df = read.csv("31Nos.csv")

library("fpp2")

ggAcf(df, lag=24)#trend
ts = ts(df,start =c(1,1))

#Step 1: partitioning
test = tail(ts, max(length(ts)*0.2,5))
training = head(ts, length(ts)-length(test))


#Step 2: Arima Molde

model1 = auto.arima(training, seasonal = FALSE,
                    stepwise = FALSE,
                    approximation = FALSE)

model1


model2 = auto.arima(training, seasonal = FALSE)
model2


#Step 3: apply both models on test
model1pred = forecast(model1, length(test))
model1pred

model2pred = forecast(model2, length(test))
model2pred  

#Step 4: provide accuracy of both models
accuracy(model1pred,test)[2,]
accuracy(model2pred,test)[2,]

#Step 5: apply best model for future prediction
Model = Arima(ts, order = c(4,2,0))

predictions = forecast(Model, 5)

autoplot(predictions) + autolayer(fitted(predictions), series = "fitted")





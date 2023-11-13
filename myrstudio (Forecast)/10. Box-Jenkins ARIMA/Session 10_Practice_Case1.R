library("fpp2")

#predict for 1 Period

df = uschange[,"Consumption"]
ggAcf(df, lag =24)
ts = ts(df,frequency = 4)

#Partitioning

test = tail(ts,max(length(ts)*.2,4))
training = head(ts,length(ts)-length(test))

#Fit 2 ARIMA model on training
  #1 is best fit model


  Model1 = auto.arima(training,seasonal = FALSE,
                   stepwise = FALSE,
                   approximation = FALSE)
  Model1



  #2 is good fit model
  
  Model2 = auto.arima(training,seasonal = FALSE)
  Model2


#Apply Model on test
  
  Model1pred = forecast(Model1, length(test))
  Model1pred

  Model2pred = forecast(Model2, length(test))
  Model2pred  

  
#Performance Measures on Test by Errors
  
  accuracy(Model1pred,test)[2,]
  accuracy(Model2pred,test)[2,]

#apply the best Model, in this case it would be #2
  
  Model = Arima(ts,order=c(3,0,0))
  Model
  
  
  predictions = forecast(Model,1)
  
  
  autoplot(predictions) + autolayer(fitted(predictions),
                                    series = "Fitted")
  
  
  
  
  
  
  
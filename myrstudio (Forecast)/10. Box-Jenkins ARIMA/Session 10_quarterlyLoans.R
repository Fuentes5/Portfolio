#10. ARIMA modeling
#setwd("C:/Users/jfuentes1/Documents/myrstudio (Forecast)/10. Box-Jenkins ARIMA")

library("fpp2")

df = read.csv("QuarterlyLoans.csv")
anyNA(df)

ggAcf(df,lag=24)

ts = ts(df, start = c(2002,1), frequency = 4)


#____________machine learning paradigm

#partitioning
test = tail(ts,max(length(ts)*.2,4))
training = head(ts,length(ts)-length(test))


#Fit 2 ARIMA model on training
  #1 is best fit model

    Model1 = auto.arima(training,seasonal = FALSE, 
                    stepwise = FALSE,
                    approximation = FALSE)
    Model1

  #2 is good fit model

    model2 = auto.arima(training,seasonal = FALSE)
    model2


    
#Apply Model on test
    
  model1pred =forecast(Model1, length(test))
  model1pred    

  model2pred = forecast(model2, length(test))
  model2pred

  
#Performance Measures on Test by Errors
  
  accuracy(model1pred,test)[2,]
  accuracy(model2pred,test)[2,]
  
  
#Apply most accurate model for future predictions
  
  Model = Arima(ts,order=c(0,2,1))
  #rebuild model on training
  
  Model

  
predictions = forecast(Model,4)


autoplot(predictions) + autolayer(fitted(predictions),
                                   series = "Fitted")




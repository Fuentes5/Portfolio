#package.install("fpp2")

library("fpp2")

#____________________________________________________________________________
#CASE 1

#predict next 8 Quarter using ausbeer
  #a) Evaluate the adequacy of the 3 naïve models, on the training set.
  #b) Which method are you going to apply for prediction? Use RMSE.
  #c) Provide the values of point forecasts. Graph the original time series, fitted values, as well as the point predictions
  #and confidence intervals.

ts = ts(ausbeer,start=c(1990,1), frequency = 4)

#Partitioning
  Test = tail(ts,max(length(ts)*0.20,8)) 
  Training = head(ts, length(ts)-length(Test)) 


#Fit on training and check adequacy & Predict on test based on training
  #naive
  Naive = naive(Training, length(Test)) 
  checkresiduals(Naive)
  
  #drift
  Drift = rwf(Training, length(Test), drift = TRUE) 
  checkresiduals(Drift)
  
  #seasonal
  SN = snaive(Training,length(Test))
  checkresiduals(SN)

#Performance Measure
  accuracy(Naive, Test)[2,]
  accuracy(Drift, Test)[2,]
  accuracy(SN, Test)[2,]

  
#Predict
 Pred = snaive(ts,8)
  autoplot(Pred) 

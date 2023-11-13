#Load Library

library("fpp2")


#Question 1
#_______________________________________________________________________________
#Load Data

autoplot(ausbeer)

#start 1990

  tsPortion = window (ausbeer, start = c(1990,1))
  
  autoplot(tsPortion)

#1) Shows that the volume drops in the second quarter of 2000

  ts2000 = window (ausbeer, start = c(2000,1))
  
  autoplot(ts2000)

#2)Produce a correlogram and identify time series element
  
  ggAcf(tsPortion, lag = 24)

#3)Which naive models can be apploed to generate initial forecast
  
  #The Seasonality one for sure
  
#4)
  
  SN= snaive(ts2000,12)

#5)
  autoplot(SN)
  
#_______________________________________________________________________________

  
  
  
  
#Question 2 
#_______________________________________________________________________________
#1)

library("fpp2")
#install.packages("fpp2")

  df = read.csv("multiTimeline.csv")
  anyNA(df)
  
  df = df[-c(1:2,239),]
  str(df)
 df$X = as.numeric(df$cate)
  
#2)

ts = ts(df, start = c(2004,1))
  
  ts = ts(df, start = c(2004,1), frequency = 12)
autoplot(ts)
#3)
  
#_______________________________________________________________________________
  pigs

  ts = window(pigs, start=c(1994,1))

  ggAcf(ts,lag=24)
  naive = naive(ts,16)

  naive   
 autoplot(naive)  

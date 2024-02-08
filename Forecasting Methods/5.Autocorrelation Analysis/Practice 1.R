
library("fpp2")

################################################################################

#Objective: TS for 40number and Correlogram for Timeseries

  #call on the data
  df = read.csv("40numbers.csv")

  #Time Series no frequency
  ts = ts(df$Numbers, start=c(1,1))
  
  #Correlogram
  ggAcf(ts, lag =24 )
  
  
  #Plot
  autoplot(ts) +
    ggtitle("40 Nubers") + 
    xlab("") +
    ylab("")

################################################################################
  
#Objective: Get data from 2001-2006
  
  #call on the data
  df2 = read.csv("QuarterlyLoans.csv")
  
  #Show trend
  ggAcf(df2$Loans, lag=24)
  
  #corelagram
  Acf(df2$Loans, lag=24, plot=FALSE)
  
  #TimeSearies
  ts2 = ts(df2, start=c(2001,1))
  
  #plot TS
  autoplot(ts2)

################################################################################

#Objective:  
  
  df3 = read.csv("Elec_demand.csv")
  df3 = c(200.30,df3 [,1]) #correct the data
  View(df3)
  ggAcf(df3, lag=48)

  ts3 = ts(df3, start=c(1980,1), frequency=12)  

  autoplot(ts3)  

  ggsubseriesplot(ts3)  
  
  #seasonality and trend
  
#setwd("C:/Users/jfuentes1/Documents/myrstudio (Forecast)/12. Regression")

library("fpp2")
df = read.csv("myTS.csv")
View(df)
str(df)

ggAcf(df$Sales, lag=24)
#seasonality, freq = 4
ggAcf(df$AdBudget, lag=24)
ggAcf(df$GDP, lag =24)

ts = ts(df[,2:4], start = c(1981,1), frequency = 4)
ts

autoplot(ts)

#install.packages("GGally")
#library("GGally")

ggpairs(as.data.frame(ts))

#__________partitioning

test = tail(ts,max(length(ts)*0.2,4))
#training = head(ts,length(ts)-length(test))
#errors in results of training because its 100 observation

test = tail(ts,max(nrow(ts)*0.2,4))
training = head(ts, nrow(ts)-nrow(test))
#the reason why we change it is because when we're doing regression it has to use nrow


#__________Fit model on training

model = tslm(Sales ~ AdBudget + GDP, training)

#in this case we will not need artificial trend or seasonality
#because the data is flat


#tslm = time series linear model
  #if you need trend +trend
  #if you need seasonality +season
  #if you need both +trend + season

summary(model)

#estimate is B value
#Sales = -589.4370 +1.9985(AdBudget) +1.2559(GDP)


#Check residual
checkresiduals(model)
#adequates

#__________Apply model on test

#pred = forecast(model,length(test))
#error for time series with multiple variables don't work ^

Pred = forecast(model, data.frame(test))

#__________Evaluation of performance by errors
accuracy(pred,test)[2,]
#same error because we have multiple ts variables and a Y

accuracy(Pred,test[,"Sales"])[2,]


#__________Predict Future records
New = data.frame(AdBudget = c(650,700,550,500), 
           GDP = c(250,200,350,400))

forecast(model,New)

#change time indices in linear model because it get's messed up during training
#you check using the following code
time(ts)
#time indices need to be changed to 2006Q1-Q4














#setwd("C:/Users/jfuentes1/Documents/myrstudio (Forecast)/13.Regression II")

library("fpp2")
df = read.csv("Sales_Expen.csv")

#correlogram
ggAcf(df$Sales, lag = 24) #white noise
ggAcf(df$Expend, lag = 24) #white noise


plot(df$Sales, df$Expend.)

#Create Time series Object
ts = ts(df[,c("Sales","Expend.")])


autoplot(ts)

#paritioning

test = tail(ts,max(nrow(ts)*0.2,2))
training = head(ts, nrow(ts)-nrow(test))


#linear Model
linear = tslm(Sales~Expend.,training)
summary(linear)
checkresiduals(linear)
#not adequate







#nonlinear models

#_______________________ Y~1/X
which(ts[,"Expend."]==0)
#check if any 0 in x
#returns which element in x is 0

  X_1 = tslm(Sales~I(1/Expend.),training)
  summary(X_1)
  checkresiduals(X_1)
  #adequate, not spurious, well explained


#_______________________ Y~log(x)
min(ts[,"Expend."])

logx = tslm(Sales~I(log(Expend.)),training)
summary(logx)
checkresiduals(logx)
#adequate, not spurious, well explained


#_______________________ Y~sqrt(x)
min(ts[,"Expend."])

sqrt_x = tslm(Sales~I(sqrt(Expend.)),training)
summary(sqrt_x)
checkresiduals(sqrt_x)
#adequate, not spurious, well explained


#_______________________ Y~(x)^2
x_sq = tslm(Sales~I(Expend.^2),training)
summary(x_sq)
checkresiduals(x_sq)
#not adequate, not spurious, well explained








#forecast on test
pred_x_1 = forecast(X_1,data.frame(test))
logx = forecast(logx,data.frame(test))
sqrt_x = forecast(sqrt_x,data.frame(test))


#Produce Accuracy
accuracy(pred_x_1,test[,"Sales"])[2,]
accuracy(logx,test[,"Sales"])[2,]
accuracy(sqrt_x,test[,"Sales"])[2,]



#Forecasting
New = data.frame(Expend. =c(14.5,13))
forecast(X_1,New)

#Update Time indices to 15 and 16
ts



# ts = cbind(ts,t=seq(from =1,to=length(ts)))




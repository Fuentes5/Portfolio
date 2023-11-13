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
library("GGally")

ggpairs(as.data.frame(ts))

#predicting sales from 4 quarters ago, because of delayed impact


#new ts
ts = cbind(Sales=ts[,"Sales"],
           AdBudget =ts[,"AdBudget"],
           AdBudgetlag4 = stats::lag(ts[,"AdBudget"],-4),
           AdBudgetlag8 = stats::lag(ts[,"AdBudget"],-8))

#stats is just saying at what point in time, so we would want a lag (or a previous value)
#by 4 quarters (represented by thr -4)

ts

ts =na.omit(ts)

#train and test (partitionin)
test = tail(ts,max(nrow(ts)*0.2,4))
training = head(ts, nrow(ts)-nrow(test))

#create Model
model_lag0 =tslm(Sales ~ AdBudget, training)
summary(model_lag0)
checkresiduals(model_lag0)


model_lag4 =tslm(Sales ~ AdBudgetlag4, training)
summary(model_lag4)
checkresiduals(model_lag4)

model_lag8 =tslm(Sales ~ AdBudgetlag8, training)
summary(model_lag8)
checkresiduals(model_lag8)

#Apply models on test
pred_lag0 = forecast(model_lag0, data.frame(test))
pred_lag4 = forecast(model_lag4, data.frame(test))
pred_lag8 = forecast(model_lag8, data.frame(test))

#Accuracy
accuracy(pred_lag0,test[,"Sales"])[2,]
accuracy(pred_lag4,test[,"Sales"])[2,]
accuracy(pred_lag8,test[,"Sales"])[2,]


#predict future records
New = data.frame(AdBudget =c(650,700,550,500))
forecast(model_lag0, New)
time(ts)

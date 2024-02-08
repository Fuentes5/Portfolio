setwd("C:/Users/jfuentes1/Documents/myrstudio (Forecast)/HW6")

library("fpp2")

df=read.csv("bids.csv")

#correlogram
ggAcf(df$ABC, lag = 24) #white noise
ggAcf(df$Comp., lag = 24) #white noise


#time Series object
ts = ts(df[,c("ABC","Comp.")], frequency =1)
autoplot(ts) + xlab("Time") + ylab("Bids") + ggtitle("Competitor and ABC's Bids")


#scatterplot Matrix
library("GGally")
ggpairs(as.data.frame(ts))


#build linear regression models to predict it's 
#competitor's bids values for the next 2 issue



ts = cbind(Comp.=ts[,"Comp."],
           ABC =ts[,"ABC"],
           ABClag1 = stats::lag(ts[,"ABC"],-1),
           ABClag2 = stats::lag(ts[,"ABC"],-2))


ts
ts = na.omit(ts)

#train and test (partitionin)
test = tail(ts,max(nrow(ts)*0.2,4))
training = head(ts, nrow(ts)-nrow(test))


#Create Models
model_lag0 =tslm(Comp. ~ ABC, training)
summary(model_lag0)
checkresiduals(model_lag0)


model_lag1 =tslm(Comp. ~ ABClag1, training)
summary(model_lag1)
checkresiduals(model_lag1)


model_lag2 =tslm(Comp. ~ ABClag2, training)
summary(model_lag2)
checkresiduals(model_lag2)

#Apply models on test
pred_lag0 = forecast(model_lag0, data.frame(test))
pred_lag1 = forecast(model_lag1, data.frame(test))
pred_lag2 = forecast(model_lag2, data.frame(test))


#Accuracy
accuracy(pred_lag0,test[,"Comp."])[2,]
accuracy(pred_lag1,test[,"Comp."])[2,]
accuracy(pred_lag2,test[,"Comp."])[2,]


#predict future records
New = data.frame(ABC =c(100,101.34))
prediction = forecast(model_lag0, New)
time(ts)

prediction





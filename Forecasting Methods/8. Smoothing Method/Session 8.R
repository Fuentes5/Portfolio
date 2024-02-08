setwd("C:/Users/Student/Documents/myrstudio (Forecast)/8. Smoothing Method")


library(fpp2)
df = read.csv("SawsSales.csv")
#quarterly Sales
View(df)
str(df)

ggAcf(df,lag = 24)

ts = ts(df,start=c(2002,1), frequency=4)
ts

#________________________________________
#partitioning

test = tail(ts,max(length(ts)*0.2,4))

training = head(ts,length(ts)-length(test))

#________________________________________
#Fitted Value & Adequacy Check (check residual)
#predict on test based on training

average = meanf(training,length(test))
#simple average forecast
checkresiduals(average)
#adequate


ses = ses(training,length(test))
#exponential smoothing
ses
checkresiduals(ses)
#not adequate


ses0.1 = ses(training,alpha = .01, length(test))
#exponential smoothing with alpha 0.1
ses0.1
checkresiduals(ses0.1)
#adequate


ses0.3 = ses(training, alpha = 0.3, length(test))
checkresiduals(ses0.3)
#not adequate

#________________________________________
#Evaluate perfomance of model by forecast error

accuracy(average,test)[2,]
accuracy(ses0.1,test)[2,]
#exponential smoothing with alpha =0.1 is better



#________________________________________
#predict for future, 4 quarters

prediction = ses(ts, alpha = 0.1, 4)
prediction

autoplot(prediction) + autolayer(fitted(prediction), series="fitted")

#________________________________________

Holt = holt(training,length(test))
checkresiduals(Holt)
#not adequate


hw_A = hw(training,seasonal="additive", length(test))
checkresiduals(hw_A)
#addequate


hw_M = hw(training,seasonal="multiplicative", length(test))
checkresiduals(hw_M)


#________________________________________
#performance of models by forecast errors

accuracy(Avg,test)[2,]
accuracy(ses0.1,test)[2,]
accuracy(hw_A,test)[2,]
accuracy(hw_M,test)[2,]

predictions = hw(ts,seasonal = "multiplicative", 4)

autoplot(predictions)



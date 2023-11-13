#setwd("C:/Users/jfuentes1/Documents/myrstudio (Forecast)/8. Smoothing Method")

#Case 1

library("fpp2")


#Time series
ggAcf(ausbeer,lag = 24)
ts = ts(ausbeer,start=c(1990,1), frequency=8)


#Partition
test = tail(ts,max(length(ts)*0.2,4))
training = head(ts,length(ts)-length(test))

#_________________________________________
#Simple Average
average = meanf(training,length(test))

#Check Residuals
checkresiduals(average)



#_________________________________________
#Exponential Smoothing
ses = ses(training,length(test))
ses_0.3 = ses(training, alpha = 0.3, length(test))
ses_0.5 = ses(training, alpha =0.5, length(test))

#Check Residual
checkresiduals(ses) #NOT
checkresiduals(ses_0.3) #Not
checkresiduals(ses_0.5) #NOT       



#_________________________________________
#HOLT METHOD
Holt = holt(training, length(test))
Holt_A = hw(training,seasonal = "additive", length(test))
Holt_M = hw(training, seasonal ="multiplicative", length(test))

#Residual
checkresiduals(Holt) #NOT
checkresiduals(Holt_A)#BETTER
checkresiduals(Holt_M)#better


#_________________________________________
#Accuracy

#Average
accuracy(average,test)[2,]

#SES
accuracy(ses,test)[2,]
accuracy(ses_0.3,test)[2,]
accuracy(ses_0.5,test)[2,]

#HOLT
accuracy(Holt,test)[2,]
accuracy(Holt_A,test)[2,]
accuracy(Holt_M,test)[2,]


autoplot(Holt_M)

#In conclusion out of the accuracies from Nive model and smoothing models, the Smoothing method
#of Holt's multiplicative worked the best


predictions = hw(ts,seasonal = "multiplicative", 8)
a = autoplot(predictions)



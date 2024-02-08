#setwd("C:/Users/Student/Documents/myrstudio (Forecast)/7.Measuring Forecasting Accuracy")


library("fpp2")

df = read.csv("SawsSales.csv")



ggAcf(df, lag=24) #correlogram

#seasonality quarterly, and strong level

#weak level is white noise, strong level is outlier


ts = ts(df,start=c(2002,1), frequency = 4) # Start in year 2002, with first quarter

ts


#________________________________________

# Step 1: partition the ts to a training set and a test set
 
#create Test set
Test = tail(ts,max(length(ts)*0.20,4)) 
       #4 is the number of predictions into the future, because it's 4 quarters we put 4



#create training set
Training = head(ts, length(ts)-length(Test)) 


#________________________________________
# Step 2: Fit on training and check adequacy
# Step 3: Predict on test based on training

#Simple Naive Method
Naive = naive(Training, length(Test)) 
#Check Residuals
checkresiduals(Naive) 
  #Not adequate
  #Why? becuse there is no white noise and the distribution of bell curve is bad



#drift method
Drift = rwf(Training, length(Test), drift = TRUE) 
checkresiduals(Drift)
  #Not adequate



#Seasonal Naive method
SN = snaive(Training,length(Test))
checkresiduals(SN)
  #Better, but it's biased 
  #mean =100, model is underestimating by 100


#________________________________________
#Step 4: Performance measure
accuracy(Naive, Test)[2,]
accuracy(Drift, Test)[2,]
accuracy(SN, Test)[2,]
#Pick one error that's suitable for the case, and focus on that error



#________________________________________
#step 5: Predict future records 

Pred = snaive(ts,4)
#predict for the planning horizon based on ts

Pred

autoplot(Pred) + 
  autolayer(fitted(Pred),series = "fitted") +
  ggtitle("quarterly Sales") + 
  xlab("Year") +
  ylab("Sales")










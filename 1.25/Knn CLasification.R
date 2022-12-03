#KNN part 2  
setwd("C:/Users/Student/Desktop/Data/DataFrame")
library(ggplot2)
library(caret)#this is the run the knn model
dev.off()
#knn regression is numerical and knn clasification is catagories
#knn is non numerical




df = read.csv("BostonHousing.csv") 
source("C:/Users/Student/Desktop/Data/DataFrame/BabsonAnalytics.R")

dev.off() 

#manage data 
# remove all non-numerical variables 

df$CHAS = NULL 
df$RAD = NULL 
df$MEDV = NULL # this is null caz of the intersecting with ishighval 
df$ISHIGHVAL = as.factor(df$ISHIGHVAL) 

#partition  

N = nrow(df) 
trainingSize = round(N*.6)   
trainingCases = sample(N, trainingSize)  
training = df[trainingCases,] 
test = df[-trainingCases,]  


#Predict 
predictions = kNN(ISHIGHVAL ~ ., training, test, k=3) 
observations = test$ISHIGHVAL 


table(predictions,observations) 
#do by hand first  

error_rate = sum(predictions != observations)/nrow(test) 
error_rate = 1- sum(predictions == observations)/nrow(test) 



#looking for the mode and they applying it(this is the best way to guess) 
error_bench = benchmarkErrorRate(training$ISHIGHVAL, test$ISHIGHVAL) 
predictions_no_standardization = kNN(ISHIGHVAL ~ ., training, test, k=3, standardize = FALSE) 
error_rate_no_standardization = sum(predictions_no_standardization != observations)/nrow(test) 





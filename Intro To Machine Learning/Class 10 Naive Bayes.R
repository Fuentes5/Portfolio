library(e1071) 

#load data  
setwd("C:/Users/Student/Desktop/Data/DataFrame")
source("C:/Users/Student/Desktop/Data/DataFrame/BabsonAnalyticsC.R") 
df = read.csv("MovieReviews.csv") 

#manage data  
every_column = colnames(df) 

df[every_column] = lapply(df[every_column],as.factor) 

#partition data  

n = nrow(df) 
trainingSize = round(n*.6) 
trainingCases = sample(n, trainingSize) 
training = df[trainingCases,] 
test = df[-trainingCases,] 

#build modle  

model = naiveBayes(PositiveTweet ~ ., data = training) 

#predict 
predictions = predict(model, test) 
observations = test$PositiveTweet 

#evaluate KPI  
error_bench = benchmarkErrorRate(training$PositiveTweet, test$PositiveTweet) 
error = sum(predictions != observations)/nrow(test) 

table(predictions, observations) 

#new code  
model$tables$awesome 

#this table sayes: given the tweet is positive, the prob. it contains "awesome" is 27.68% 

limited = df[df$awesome == "1" ,] #all the tweets that contain "awesome" 
odds = sum(limited$PositiveTweet == "1") / sum(limited$PositiveTweet == "0") 

limited = df[df$the == "1" ,] #all the tweets that contain "the" 
odds = sum(limited$PositiveTweet == "1") / sum(limited$PositiveTweet == "0") 

limited = df[df$terrible == "1" ,] #all the tweets that contain "terrible" 
odds = sum(limited$PositiveTweet == "1") / sum(limited$PositiveTweet == "0") 


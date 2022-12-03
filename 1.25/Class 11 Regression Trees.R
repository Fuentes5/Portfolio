#How do we determine if our auction is competitive or not?
#

library(rpart)
library(rpart.plot)
setwd("C:/Users/Student/Desktop/Data/DataFrame")

df= read.csv("eBayAuctions.csv")


df$Competitive = as.factor(df$Competitive)
df$Category = as.factor(df$Category)
df$Currency = as.factor(df$Currency)
df$ EndDay = as.factor(df$EndDay)

df$EndDay = NULL
df$ClosePrice = NULL

n = nrow(df)
trainingsize = round(n*.6)
trainingcase = sample(n,trainingsize)
training = df[trainingcase,]
test = df[-trainingcase,]

#model

model = rpart(Competitive ~ . ,data=training)
rpart.plot(model)

#prediction
predictions= predict(model,test, type = "class")
#that will allow the predictions to be more visually represetative of what we want
observations = test$Competitive

error_rate= sum(predictions != observations)/nrow(test)

error_bench = benchmarkErrorRate(training$Competitive, test$Competitive)




#minSplit = is the node big enough to split, typically something like 2% of the total number of records
#how many datapoints we want in that node


#minBucket = when you split, the split should be big enough (on both side) of the split.
#Split repressentation of the overall model
#Something like 1% of the total number of records



#complexity parameter = CP = does the split improve the model (many factors go into this)
#how many times do i want the model to go down?




stopping_rule = rpart.control(minsplit = 20, minbucket = 10, cp = 0)

#number are created by trial and error

model = rpart(Competitive ~ . ,data=training, control = stopping_rule)
#overfitting is when there's a 50% value at the bottom level






#prune

predictions_overfit =predict(model,test, type = "class")
error_overfit= sum(predictions != observations)/nrow(test)


model=easyPrune(model)

rpart.plot(model)

predictions_prune =predict(model,test, type = "class")
error_prune= sum(predictions != observations)/nrow(test)

#Opening Price is greater than 1.2. The seller's rating is not greater than 530. 
#Is in one of the categories to the left with a seller, a rating greater than 393, Not paying with euros. 
#With a seller rating less than 144, not selling a car would be an 8% of being competitive compared to other things.


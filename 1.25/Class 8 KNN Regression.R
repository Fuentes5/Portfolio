setwd("C:/Users/Student/Desktop/Data/DataFrame")
df = read.csv("BostonHousing.csv")

library(ggplot2)
library(caret)

#manage data

#remove all non-numerical values
#KNN can only be run with scaler data

df$CHAS = NULL
df$RAD = NULL
df$ISHIGHVAL = NULL

#changing everything in the data into a standardized unit

Processor = preProcess(df[,1:10],c("center", "scale"))
#c("center", "scale")) #puts everything into z-scores (standardized)

#Processor = preProcess(df[,1:10],c("range", "scale"))
#c("range", "scale")) Normalize the data

df =predict(Processor,df)




#partition

n = nrow(df)
TrainingSize = round(n*.6)
TrainingCase = sample(n,TrainingSize)
Training = df[TrainingCase,]
Test = df[-TrainingCase,]

#build model
source("C:/Users/Student/Desktop/Data/DataFrame/BabsonAnalytics.R")

knnCrossVal(MEDV~.,data = Training)
#lowest value of this graph is K



model = knnreg(MEDV~.,data = Training, k = 3)

#k=3 means that we need to pick the three points to calculate the distance

#still a model of regression (that's why we choose knnreg)
#trying to predict value of medium value of 
#we measure distance and we can't do that with dummy variables

summary(model)

# we need to make all varaiables the same 

#predict

predictions = predict(model, Test)
observations = Test$MEDV
#observations come from the test data of the dependent vaiable
errors= observations - predictions

a_mape= mean(abs(errors)/observations)
a_rmse= sqrt(mean(errors^2))

#we turn everything into z-scores or normalize to make the variables the same because then we have a way to measure them
#standard deviation

#More variables you have the closer the t test will equal the z test



errors_bench = observations - mean(Training$MEDV)

a_mape_bench= mean(abs(errors_bench)/observations)
a_rmse_bench= sqrt(mean(errors_bench^2))







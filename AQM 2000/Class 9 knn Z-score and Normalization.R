#KNN


setwd("C:/Users/Student/Desktop/Data/DataFrame")
library(ggplot2)
library(caret)#this is the run the knn model
dev.off()
df = read.csv("BostonHousing.csv")
#manage data
# remove all non-numerical variables
      df$CHAS = NULL
      df$RAD = NULL
      df$ISHIGHVAL = NULL

df_Z = read.csv("BostonHousing.csv")
#manage data
# remove all non-numerical variables
      df_Z$CHAS = NULL
      df_Z$RAD = NULL
      df_Z$ISHIGHVAL = NULL
      
df_N = read.csv("BostonHousing.csv")
#manage data
# remove all non-numerical variables
      df_N$CHAS = NULL
      df_N$RAD = NULL
      df_N$ISHIGHVAL = NULL




#####################################################################################
#Proccess the data
Processor_Z = preProcess(df_Z[,1:10],c("center","scale"))#puts all variables into z-score
df_Z = predict(Processor, df_Z)

Processor_N = preProcess(df_N[,1:10],c("range"))# put into normalization
df_N = predict(Processor, df_N)
#####################################################################################
#

#partition
set.seed(1234)
N = nrow(df)
trainingSize = round(N*.6)
trainingCases = sample(N, trainingSize)
training = df[trainingCases,]
test = df[-trainingCases,]


N = nrow(df_Z)
trainingSize_Z = round(N*.6)
trainingCases_Z = sample(N, trainingSize_Z)
training_Z = df_Z[trainingCases_Z,]
test_Z = df_Z[-trainingCases_Z,]



N = nrow(df_N)
trainingSize_N = round(N*.6)
trainingCases_N = sample(N, trainingSize_N)
training_N = df_N[trainingCases_N,]
test_N = df_N[-trainingCases_N,]







#Build modle
source("C:/Users/Student/Desktop/Data/DataFrame/BabsonAnalytics.R")
knnCrossVal(MEDV ~ ., data = training)
knnCrossVal(MEDV ~ ., data = training_Z)
knnCrossVal(MEDV ~ ., data = training_N)

#Model
model = knnreg(MEDV ~ ., data = training, k=3)
model_Z = knnreg(MEDV ~ ., data = training_Z, k=3)
model_N = knnreg(MEDV ~ ., data = training_N, k=3)

#Predict
predictions = predict(model, test)
predictions_Z = predict(model_Z, test_Z)
predictions_N = predict(model_N, test_N)


#evaluate or KPI
#Observation
observations = test$MEDV
observations_Z = test_Z$MEDV
observations_N = test_N$MEDV

#Errors
errors = observations - predictions
errors_Z = observations_Z - predictions_Z
errors_N = observations_N - predictions_N


#MAPE
mape = mean(abs(errors/observations))
mape_Z = mean(abs(errors_Z/observations_Z))
mape_N = mean(abs(errors_N/observations_N))

#RMSE
rmse = sqrt(mean(errors^2))
rmse_Z = sqrt(mean(errors_Z^2))
rmse_N = sqrt(mean(errors_N^2))

#ERRORS
errors_bench = observations - mean(training$MEDV)


#MAPE_BENCH
mape_bench = mean(abs(errors_bench/observations))



#RMSE_BECH
rmse_bench = sqrt(mean(errors_bench^2))

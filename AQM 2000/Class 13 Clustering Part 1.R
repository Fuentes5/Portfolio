setwd("C:/Users/Student/Desktop/Data/DataFrame")
df = read.csv("DairyPurchase.csv")

summary(df) #summarizes the data(gives you box and wiskers plot for every column)

model = kmeans(df,4) #preform clustering with the df using 4 cluster

model$centers #the center of each cluster
model$size #size of the clusters with normalization 

#################################################################
library(caret)
standardizer = preProcess(df, method = c("center", "scale")) #normalizing the data into z-score
df = predict(standardizer, df)

model = kmeans(df,4)#performs clustering with Z-score

model$centers #the center of each cluster
model$size #size of the clusters with the data

##################################################################


source("C:/Users/Student/Desktop/Data/DataFrame/BabsonAnalyticsC.R")
elbowChart(df) #to find K 

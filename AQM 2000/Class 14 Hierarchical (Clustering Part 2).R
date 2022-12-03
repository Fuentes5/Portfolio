
###########part 2#######################
setwd("C:/Users/Student/Desktop/Data/DataFrame")
source("C:/Users/Student/Desktop/Data/DataFrame/BabsonAnalyticsC.R")

df1 = read.csv("Utilities.csv")



df1$Company = as.factor(df1$Company)

library(caret)
standardizer = preProcess(df1[,2:8], method = c("center", "scale"))
df1 = predict(standardizer, df1)

summary(df1)

d = dist(df1)
d

model = hclust(d, method = "average")
plot(model, labels = df1$Company)


model = hclust(d, method = "single")
plot(model, labels = df1$Company)

model = hclust(d, method = "complete")
plot(model, labels = df1$Company)

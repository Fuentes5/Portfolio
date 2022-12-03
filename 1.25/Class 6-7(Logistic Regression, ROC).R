rm(list=ls())
gc()


library(ggplot2)

setwd("C:/Users/Student/Desktop/Data/DataFrame")
df=read.csv("BostonHousing.csv")

#_______________________________________________________________________________
                         #Logistic Regressions

ggplot(df,aes(x=RM, y=ISHIGHVAL))+geom_point()

#visual representation of yes it's high and no it's not
# why is yes or no, x is room or no
# Higher levels of room mean the higer level of value
#linear regression line, average equal distance to every point



#using ligistic regression makes a different graph (looks like an S)
#log odds of the porbobility events occuring 

#when are logistic regression used: When the variable is binary (it  has to have 2 outcome)
#_______________________________________________________________________________


ggplot(df,aes(x=RM, y=ISHIGHVAL))+geom_point()

#manage the data

df$ISHIGHVALN = df$ISHIGHVAL
#not changiing this one because we're going to use it for the end

df$ISHIGHVAL = as.logical(df$ISHIGHVAL)
df$MEDV = NULL
df$CHAS = as.logical(df$CHAS)
df$RAD = as.factor(df$RAD)

                                #we partition the data

set.seed(12)
n= nrow(df)
trainingsize = round(n*.6)
trainingcase=sample(n,trainingsize)
training = df[trainingcase,]
test = df[-trainingcase,]


                            
                                    #Build the Model 

#this model will not be linear it's going to be s

model = glm(ISHIGHVAL ~ RM, data= training)

#1) We want to know if its high value
#2) then we add what we want to check if it's high value
#3) at the end we choose where we're getting the data from
#4) we look at the summary

summary(model)

#5) we don't know if it's right so we add into our code family (the family is 
# binomial because our code is two) It's informing the graph what type of data there is

model = glm(ISHIGHVAL ~ RM, data= training, family = binomial())
summary(model)


                                  #predict

#is the room going to be high value or not
#we don't know how to read the graph



#ods are p/p-1
#we can go to infinity but that's not useful to us because we need a hard number
#we take the odd probobability and we turn it into p we transform it


predictions = predict(model, test)
predictions[1:10]
#some of these are negative the one or above 1 which doeesn't do a good job at prediction

predictions = predict(model, test, type = "response")
predictions[1:10]

#now we have the prediction for the graphical display

ggplot(test,aes(x=RM, y=predictions, color = ISHIGHVALN )) + geom_point() +
  geom_point(aes(y=ISHIGHVALN))
#ggplot uses the test data to test wether or not rooms affects the value of the house
#it does this by predicting the probability of each value.

summary(model)

exp(2.0671)#RM
#Summary of the variable being affected





#______________________________________class 7

#define the graph
#Sensitivity
#specificity (1- specificity)
#ROC-chart

#prediction -> ROC (how accurate it is) -> Goal is to get to 0,1


predictionsTF = predictions > .5
#prediction already has probability of the variables
# here we are looking for all predictions that are greater than .5

observations = test$ISHIGHVAL
#observation of the data if the house is high value

a = table(predictionsTF, observations)
a
#we want a table
#this will tell us how accurate we are
#fale false is 56 and true true is 83 meaining that the model is accurate because they're bigger than 39 and 24
# any opposites are bad values
# true true is we observed it as high value and it was high value
# false false is we observed it as false and we got false
# false true is we observed it as false but we got true


#Key Performance indicator (KPI)
#what meeasurements am i using to make this prediction
#we are going to use a fixed cut-off at .5 or 50%
#from the s-curve


#sensitivity = is the percentage of observe 
#true we predict correctly
# (you have to look at the cell 
# true true then divide that by TRUE TRUE + FALSE TRUE)
#     (TRUE TRUE/ TRUE TRUE +FALSE FALSE)
#               how accurate the true predictions are


#Specificity = is the percentage of FALSE we predict correctly
# loking at the cell FALSE FALSE then divide that by false false +  true false)
#                     how accurae the false prediction are

#              observations
#predictionsTF FALSE TRUE
#FALSE           56   39
#TRUE            24   83

Sensitivity= sum(predictionsTF == TRUE & observations == TRUE)/ sum(observations == TRUE)
#how good out model in detecting wehter its true or not
#
sum(observations == TRUE)


Specificity= sum(predictionsTF == FALSE & observations == FALSE)/ sum(observations == FALSE)
#how good are we in predicting false with our model
a

error_rate = sum(predictionsTF != observations)/nrow(test)
#31% chance of error

#Specificty is correct prections for FALSE
#Sensitivity is correct prediction for true

#the amount of error is what is left over
#31 is between  .7 and .68
error_rate



ROCChart(observations,predictions)
liftChart(observations, predictions)




#linear regression: it's used to make a prediction, strong relationhip with variables
#Which ones work well and which ones don't work as well. We also have boundaries, with
#the low value and high value. Residuals has a scope of how far an error from the prediction
#error can be really large and really small, its arbritarty to the unit of the model.

#undertand where the unit of error, the statistician is the one who determines,
#the error.

#p-value large it's statistically significant
#large data cause type 1 error
#_______________________________________________________________________________

#Load data

setwd("C:/Users/Student/Desktop/Data/DataFrame")
cars = read.csv ("ToyotaCorolla.csv")

View(cars)


#_______________________________________________________________________________

#mangae the data

#the "NULL" command will set the colum to empiness. Another way to think about it
# is that you hide the data.

cars$Model = NULL


cars$Fuel_Type = as.factor(cars$Fuel_Type)
cars$Met_Color = as.logical(cars$Met_Color)
cars$Automatic = as.logical(cars$Automatic)

#Metalic: (yes = 1, no = 0)
#Automatic: (yes = 1, no = 0)
#Fuel_Type: (Diesel,CNG,Petrol)
#_______________________________________________________________________________

#partition the data

#for big data we analyse the data in two ways/we split the data 
#the two ways we will deal with it is the training set an the test

#training is the large part of the data: where you're going to build your model from
#that's where you're going to do your linear regressoin from

#the test part is where the model is going to be implemented to see how acurate the
#model is
#_______________________________________________________________________________

                                     #training
n = nrow(cars)
#values for every row we have
#n is the function "nrow(cars)" is the command to get every value in the rows



TrainingSize = round(n*.6) 
#Training size is the amount of data we will use in order to train, for instance
#in this case we will use 60% of the data



TrainingCase = sample(nrow(cars),round(nrow(cars)*.6))

TrainingCase = sample(n,TrainingSize)
#picking the random numbers
#sample size of data, 1:862 data case, it's just picking the 862 observation

#We get our initial rows and also our trinig size wich



Training = cars[TrainingCase,]
#This pulls the data from cars and creates a new data set from using the code
# Sample

#It basically makes a new data set with the data cars using 60% of our observation size. 

#View(Training)

#_______________________________________________________________________________

#Test

Test = cars[-TrainingCase,]
#the new dataset that is leftover from the 60% we took out

#_______________________________________________________________________________
#partition the data --> so we all get the same thing :)


set.seed(1234) #this makes it not random
n = nrow(cars) #all the row information (observation)
TrainingSize = round(n*.6) #round out the
TrainingCase = sample(n,TrainingSize) #this picks a random set
Training = cars[TrainingCase,]
Test = cars[-TrainingCase,]

#_______________________________________________________________________________

#build the Model

#for big data, set we use, are training data first then test data to test model

model = lm(Price ~ Age, data = Training)#linear model
#             y  ~  x
#code for linear model in R-studio is lm
#you need to independent, then your dependent seperated from a tilda. and you have to choose
# which data you want to get from.

summary(model)
#1: Code
#2:residual/ error (look at the q1 and q3)
#3:coefficient

#_______________________________________________________________________________

                               #Day 5
#multiple regression

model2 = lm(Price ~ Age + HP, data=Training)
summary(model2)

#_______________________________________________________________________________

#add all of the x-values 

model3 = lm(Price ~ ., data=Training) 
#period means all of them

summary(model3)

#_______________________________________________________________________________

#best subset 


#in big data we don't care about residuals standard error and degrees of freedom

#we care about the p-value and reproduce ability 

Predictions = predict(model3, Test)
#made a new function where we get the model and put it with test and the predictions
#will be our y outputs

#take model 3 and run

observations = Test$Price

error = observations - Predictions

hist(error)

#_______________________________________________________________________________

#evaluate performance 


rmse = sqrt(mean(error^2))
#RMSE (Root Mean Squared Error) Always the dependent value, erro in a price of a car
#we can be off by 1340 euros.

#abs is absolute value

mape = mean(abs(error/observations))
#MAPE (mean average percent error)

#9% error in in the model

#we are using model 3


#_______________________________________________________________________________

#best subset
#FIND THE BEST PREDICTORS

model = lm(Price ~ Age, data = Training)

step(model)

model = step(model)
#Replace


#_______________________________________________________________________________


model3 = lm(Price ~ ., data = Training)

step(model3)
model3 = step(model3)

#none means that this is the optimum model and i'm going to use the information
#to predict


#_______________________________________________________________________________

#apply it to the real world

Predictions_bench = mean(Training$Price)
error_bench = observations - Predictions_bench
mape_bench = mean(abs(error_bench/observations))
rmse_bench = sqrt(mean(error_bench)^2)

#_______________________________________________________________________________

#graph
library(ggplot2)

ggplot(Test, aes(x = observations , y = Errors)) + geom_point()

Test$Observations = observations
Test$Errors = error













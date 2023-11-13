# ts with R

# Pre-work: clear Environment and Console

# install.packages("fpp2")  # install package fpp2
library("fpp2")  # load package fpp2

df <- read.csv("MurphyBrothers.csv")  # load data
View(df) # show data frame
anyNA(df)  # any missing values
str(df) # see datatypes
# need to combine multiple columns to one

t(names(df))  # show column number of each variable
X <- unlist(df[,2:5]) 
# convert 2nd to 5th columns to one column 
# or, 
X <- unlist(df[,c(2,3,4,5)]) 

########################################
######## Define the ts object ##########
########################################

ts <- ts(X, start = c(1992,1), frequency = 12) 
# Define the ts object; start from January of 1992
# There's seasonality and frequency = 12
ts # show the ts object

tsPortion <- window(ts, start=c(1993,1), end=c(1994,3))
# extract a portion (1993-Jan to 1994-Mar) of the ts data
tsPortion # return the time series portion with time stamps

########################################
######## Visuals #######################
########################################

############### basic plot
autoplot(ts) # default plot
autoplot(ts) + 
  ggtitle("Murphy Brothers Sales") + 
  ylab("Sales") +
  xlab("Year") # ts plot with title, y label, and x label

############# seasonal plot
ggseasonplot(ts, year.labels=TRUE, year.labels.left=TRUE) + 
  ylab("Sales") + 
  ggtitle("Seasonal plot: Murphy Brothers Sales") 
# with year labels on both sides

############## polar seasonal plot
ggseasonplot(ts, polar=TRUE) + 
  ylab("Sales") +
  ggtitle("Polar seasonal plot: Murphy Brothers Sales")

############# seasonal subseries plot
ggsubseriesplot(ts) + ylab("Sales") + 
  ggtitle("Seasonal subseries plot: Murphy Brothers Sales")
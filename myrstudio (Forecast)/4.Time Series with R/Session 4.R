#session 4 ts with r

#setwd("C:/Users/Student/Documents/myrstudio (Forecast)/4.Time Series with R")

##########################################
#_________________pre-work________________
#install.packages("fpp2") #install package

library("fpp2")


##########################################
#_________________Load Data_______________

df = read.csv("MurphyBrothers.csv")

View(df)
anyNA(df)
str(df) 


##########################################
#_________________Sclicing________________

#after str(df) or View(df)
  #if data of a time series variable is not in one column, combine to one column
      #X <- unlist (df[ ,a:b])

  #if columns are not adjacent
      #X <- unlist (df[ ,c(a,b,c)]), or df<- unlistdf([ ,c("X1", "X2", "X3")])

#Data Sclicing
  #t(names(df)): show the column number of each varaible in the df
  #df[,a:b]: slices df down to the a-th till the b-th column
  #df[,c(a,b,c)]: slice df down to the a-th, b-th, and the c-th columns
  #df [ , c("X1", "X2", "X3")]: slice df down to variables, X1, X2, and X3


t(names(df)) #shows column of each variable
X = unlist(df[ , 2:5]) #combine columns 2 to 5 in df to one column and name the column as X

X = unlist(df[ , c(2,3,4,5)])


##########################################
#_____________DEFINE A TS OBJECT__________#

#ts = ts(X, start=c(TimePeriod,TimePoint),frequency = frequency)


# X: time series variable(s)
# start = c (TimePeriod, TimePoint) : Gives the time index of the first observation, in terms of 
                                      #the starting TimePoint of the starting TimePeriod.
# frequency: Number of TimePoint in the TimePeriod. If no seasonality, omit the frequency component.
# TimePeriod, TimePoint, and frequency have to be numbers


ts = ts(X,start = c(1992,1), frequency = 12)
# ts object starts from 1st month of 1992 
# Assumed: Frequency = 12 (seasonal pattern repeats every 12 months)
ts


##########################################
#__VIEW A TS OBJECT; EXTRACT A PORTION____

#View the ts object
  #Type the name of the ts and run

# Extract a portion of a ts object:
  #tsPortion <- window (ts, start = c (STimePeriod, STimePoint), end = c(ETimePeriod, ETimePoint))

#There can be multiple ts variables in X, and hence also in a ts object

tsPortion = window (ts, start = c(1993,1), end = c(1994,3))
tsPortion

##########################################
#_________________Visual__________________

autoplot(ts)

AutoPlot = autoplot(ts) +
  ggtitle("Murphy Brothers Sales") +
  ylab("Sales") + xlab("Year")
#plot with title, xlab, ylab

#______________Seasonal Plot______________
SeasonalPlot = ggseasonplot(ts, year.labels = TRUE, year.labels.left = TRUE) + 
                                 ylab("Sales") + xlab("Year") + 
                             ggtitle("Seasonal Plot: Murphy Brothers Sales")

SeasonalPlot

#___________Polar Seasonal Plot___________
Polar = ggseasonplot (ts, polar=TRUE) + 
              ylab ("YLabel") + 
            ggtitle ("Title")
Polar

#_______Seasonal Subseries Plot____________

Subseries = ggsubseriesplot(ts) + ylab("YLabel") + ggtitle("Seasonal Subseries Plot")
Subseries

#because the data was categorized as seasonal, the ggseasonplot automatically plots the data
#These plots only work with seasonal data.

#____________Histogram Plot________________
#Show the distribution of a numeric variable by connected bars.
#The difference between models and reality is called residual (residual to be close to 0 as much as possible and random)



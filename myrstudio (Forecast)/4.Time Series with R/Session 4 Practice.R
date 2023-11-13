#Session 4 practice

#pre-work

rm(list = ls())
#Ctrl + L
library("fpp2")
#load dataset

df = read.csv("Annual Observations from 2012.csv")

anyNA(df)
str(df)


#_____Define the TS object_____

ts = ts(df)


#__VIEW A TS OBJECT; EXTRACT A PORTION____

tsPortion = window (ts, start = c(2,1), end = c(3,1))


#_____visual_____

plot = autoplot(ts)+ ggtitle("Year 2013 and 2014") +
  xlab("Year") + ylab("Observations ")


                                         # ggseasonplot(tsPortion,year.labels = TRUE,
                                         #              year.labels.left = TRUE) + 
                                         #               ylab("") +
                                         #             ggtitle("") + 
                                         #              xlab(" ")
  
                                          
                                        #  ggseasonplot(tsPortion, 
                                        #               polar = TRUE, 
                                        #               year.labels = TRUE,
                                        #               year.labels.left = TRUE) + 
                                        #               ylab(" ") +
                                        #               ggtitle("Polar Seasonal plot for years") + 
                                        #               xlab(" ")
                                          
                                          

                                       #   ggsubseriesplot(tsPortion)+ 
                                       #     ylab(" ") +
                                       #     ggtitle("") + 
                                       #     xlab(" ")
                                          

library("GGally")

ggpairs(as.data.frame(tsPortion))

#_______________________________________________________________________________

df2 = read.csv("SurtidoCookies.csv")

anyNA(df2)
str(df2)


df2 = unlist(df2[ , 2:5])

ts2 = ts(df2)

#tsPortion2 = window (ts2, start = c(2,1), end = c(3,1))


plot2 = autoplot(ts2)+ ggtitle("") +
  xlab("") + ylab(" ")

plot2









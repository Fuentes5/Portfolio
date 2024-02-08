#Session 4 on Adbudget

#pre-work
  
  rm(list = ls())
  #Ctrl + L

#load dataset
  
df = read.csv("Adbudget.csv")

anyNA(df)
str(df)


######_____Define the TS object_____######


ts = ts(df[,2:4], start=c(1981,1), frequency = 4)
  #it's okay to have multiple ts variables in df

ts


tsPortion = window(ts,start = c(1990,1), end = c(2000,4))
tsPortion




############_____visual_____############

autoplot(ts)

autoplot(ts) + ggtitle("ts plot") +
  xlab("Year") + ylab(" ")



#_________narrow down to Sales_________

autoplot(ts[ ,1]) + ggtitle("ts plot") +
  xlab("Year") + ylab(" ")
      
        #time indices are not part of the column

autoplot(ts[ ,"Sales"]) + ggtitle("ts plot") +
  xlab("Year") + ylab("Sales") 
        
        #proper way to slice in a ts object is to use [ ,"name"]

#_________Narrow to Sales and GDP________

autoplot(ts[ ,c("Sales", "GDP")]) + ggtitle("ts plot") +
  xlab("Year") + ylab(" ")


#_____________Seasonal Plot______________

ggseasonplot(ts,year.labels = TRUE,
             year.labels.left = TRUE) + 
             ylab("") +
             ggtitle("") + 
             xlab("")
 
   #seasonal plot doesn't allow multiple ts

ggseasonplot(ts[,"Sales"],year.labels = TRUE,
             year.labels.left = TRUE) + 
             ylab("Sales") +
             ggtitle("Seasonal plot for sales") + 
             xlab("Quarters")

#_____________Polar Plot_________________


#Polar seasonal plot doesn't allow multiple ts

ggseasonplot(ts[,"Sales"], 
             polar = TRUE, 
             year.labels = TRUE,
             year.labels.left = TRUE) + 
             ylab(" ") +
             ggtitle("Polar Seasonal plot for sales") + 
             xlab(" ")

#_____________Subseries Plot_____________

#Subseries plot doesn't allow multiple ts

ggsubseriesplot(ts[,"Sales"])+ 
              ylab(" ") +
              ggtitle("") + 
              xlab(" ")

#________Scatter Plot Matrix_____________

#install.packages("GGally")
library("GGally")

ggpairs(as.data.frame(ts))










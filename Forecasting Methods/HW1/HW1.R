setwd("C:/Users/Student/Documents/myrstudio (Forecast)/HW1")

library("fpp2")

df = read.csv("Restaurant Sales.csv")

  #View(df)
  #anyNA(df)

df$Day = NULL
df$Week = NULL

pairs(df)


ts = ts(df, start=c(1,1),frequency = 6)

#regular Plot
autoplot(ts)+
  ggtitle("Sales per Category") +
  ylab("Sales") + xlab("week")



tsLunch = ts(df$Lunch.Sales.., start=c(1,1),frequency = 6)
tsDinner = ts(df$Dinner.Sales.., start=c(1,1),frequency = 6)
tsDelivery =ts(df$Delivery.Sales.., start=c(1,1),frequency = 6)

#seasonal Plot
ggseasonplot(tsLunch, year.labels = TRUE, year.labels.left = TRUE)
ggseasonplot(tsDinner, year.labels = TRUE, year.labels.left = TRUE)
ggseasonplot(tsDelivery, year.labels = TRUE, year.labels.left = TRUE)


#Polar
ggseasonplot(tsLunch, polar=TRUE) + ylab ("Sales") + ggtitle ("Sales per Lunch")
ggseasonplot(tsDinner, polar=TRUE) + ylab ("Sales") + ggtitle ("Sales per Dinner")
ggseasonplot(tsDelivery, polar=TRUE) + ylab ("Sales") + ggtitle ("Sales per Delivery")


#subseries
ggsubseriesplot(tsLunch) + ylab("YLabel") + ggtitle("Seasonal Subseries Plot for Lunch")
ggsubseriesplot(tsDinner) + ylab("YLabel") + ggtitle("Seasonal Subseries Plot for Dinner")
ggsubseriesplot(tsDelivery) + ylab("YLabel") + ggtitle("Seasonal Subseries Plot for Delivery")






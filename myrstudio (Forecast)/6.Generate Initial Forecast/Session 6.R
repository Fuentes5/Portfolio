#install.packages("fpp2")
library(fpp2)

df = read.csv("SawsSales.csv")
str(df)
anyNA(df)

ggAcf(df, lag=24) #if  there is multiple variable make sure to define which one you want a TS


ts = ts(df,start = c(2002,1), frequency = 4)
ts

autoplot(ts) + ggtitle("quarterly sales") + xlab("year") + ylab("sales")


#___________________________________________________________________________
########################SIMPLE NAIVE METHOD####################################
###############################################################################
Naive = naive(ts, 8)
    #perform simple naive method for 8 periods into the future
    #used for white noise or level

autoplot(Naive)


###############################################################################
###############################DRIFT METHOD####################################
###############################################################################

Drift= rwf(ts,8,drift=TRUE)
  #8 periods in the future
  #used for trends elements

autoplot(Drift)



###############################################################################
######################SEASONAL NAIVE METHOD####################################
###############################################################################
SN= snaive(ts,8)
  #8 periods in the future
  #used for trends elements

autoplot(SN)











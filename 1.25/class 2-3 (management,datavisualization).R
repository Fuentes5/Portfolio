setwd("C:/Users/Student/Desktop/Data (1)/Data")
df2= read.csv("updated_bike_share.csv")

View(df2)
str(df2)

#Numerical:  num  (foating point,  or number  with  decimals),  int(integer  or number  without decimal  ) 
#Categorical: factors (arbitrary  categories) (rating system/Ordinal)  and logical (true  and false, yes and no, etc) 

#view change

#as.logical()

#as.factor()

#save change

#teacher's example
df2$season = as.factor(df2$season)

# my example
df2$holiday = as.logical(df2$holiday)
#holiday seems like logical, but i got an error

# WEATHER seems like a factor and it was right
df2$weather = as.factor(df2$weather)

# second try ( I misspelled the s instead of f)

df2$holiday = as.logical(df2$holiday) #could be factore
df2$workingday = as.factor(df2$workingday) #Could be logical


df2$month = as.factor(df2$month)
df2$weekday = as.factor (df2$weekday)

#why did we change these, because in our data we have months labeled as number, months isn't a number it's a catagory

#weekday got change because it's classified by number





library(ggplot2)

#line graph


#where to pull the data from
#abriviation for axis
#x,y
#hoursSinceStart : Variables 
#Total: variables
#geom_line: putting a line on the graph
#ggplot2 is the packet
#ggplot is the language command

#attempt 1
ggplot(df2,aes(x = hoursSinceStart, y = total)) + geom_line()

#attempt 2
ggplot(df2,aes(x = hoursSinceStart, y = total)) + geom_line() + xlim(0,500) + ylim(0,250)




#bar graph

#counting graph
ggplot(df2,aes(x = season)) + geom_bar() 

#for total
ggplot(df2,aes(x = season, y = total)) + geom_bar(stat = "identity") 

#Will not work
ggplot(df2,aes(x = season, y = total)) + geom_bar() 




#boxplot
ggplot(df2,aes(x = total)) + geom_boxplot()
ggplot(df2,aes(y = total)) + geom_boxplot()
#scientist like vertical box plot



#histogram
ggplot(df2,aes(x=total))+geom_histogram(binwidth =104)

#no plus size in the code the code ends
#general rule of thumb for the bindwidth is the sqr root of the observation

ggplot(df2,aes(x=total))+geom_histogram()
sqrt(10886)

#10886 is the number of observation of df2

#first is ggplot then the data frame, then the axis, then whatever type of graph goes to GEOM

#heatmaping

ggplot(df2, aes(x=weekday, y=month, fill = registered)) +geom_tile(stat="sum")


#stacked bar chart
ggplot(df2,aes(x= month, y=registered, fill= workingday)) +geom_bar(stat="identity")

df2$workingday = as.factor(df2$workingday)

#pound symbol means a note taking

#how to get data in R
df = read.csv(file.choose())
#dataframe = df is a fancy way of saying data set
#a file window should pop up and you insert your data

#we want to look at the data
#capital V
View(df)

#look at the data structure
str(df)

#slicing the data
df[1,3]
#this is row 1, and colum 3

#what if i only want info from the first colum
df[,1]
#this means only look at colum one, so it only shows all the information from colum 1
#the number on the side is the number associated right next to it

df[1,]
#name of the row and the first initial value


#sclicing through rows ":"

df[1:10,]
#hold the data 1-10 but do not give me any colum

df[1:3,]

df[,1:3]#too big to do

#data frame splicing
df[,7]
df$AGE
#this is the prefored method

#$ = slicing just like the [,7]
#7 is the same as AGE which is the 7th colum



#vector are referred to as "c(")" in R


df[,c("CRIME", "NOX", "TAX")]
df[,c("CRIME", "NOX", "TAX")]
df = read.csv(file.choose())

df[,c("CRIME", "NOX", "TAX")]


#Numerical: num (foating point, or number with decimals), int(integer or number without)
#catahorical: factors

#to see change
as.logical(df$CHAS)

#to save
df$CHAS = as.logical(df$CHAS)

#the colum we want to change
#as. command changes the data typing into a logic type to true and false

#rad and TAX both are catagorical that need to be changed

df$RAD = as.factor(df$RAD)

#RAD is being looked as a factor now
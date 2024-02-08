#session 3 (R Basics)

######################################################################
#_________________________PREWORK_____________________________________

# 1.Clear previous results by broom key under environment
# 2. Clear console by CTRL +L in the console window

######################################################################
#___________________Load Data to R-Studio_____________________________

#1. Data in .csv
#2. data in R scrip in same folder
#3. Session > Set working diretory > To source file location to connect Rstudio to working folder
#4. Run the Following code
        #MurphyBro.df = read.csv("MurphyBrothers.csv")

df = read.csv("MurphyBrothers.csv")

        
######################################################################
#____________________VIEW DATA & CHECK MISSING VALUES_________________

#View(df)
    #Show all data in df(df:the data frame) in a new tab
        #R is case sensitive 
        #each row represents a record/observation
        #each column represents a variable
        
#anyNA(df)
        #if there's any missing vale in df: TRUE-Yes, FALSE-No
        
View(df)        


#####################################################################
#__________________DATATYPES & BASIC STATS___________________________      

#str(df)
  #return the structure (name and datatypes of all variables) of the df

#Typecasting:
  
    #df$X <- as.numeric (df$X)
      #convert X to numeric

    #df$X <- as.integer (df$X)
      #convert X to integer

    #df$X <- as.factor (df$X)
      #convert X to categorical variable

    #df$X <- as.chr (df$X)
      #convert X to text/character

#summary(df)
    #for each variable, show basic statistics and number of missing values if there's any
        
        
  
        
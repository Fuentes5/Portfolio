setwd("C:/Users/jfuentes1/Documents/myrstudio(Structural Injustice)/!FINAL")



Start = read.csv("Motor_vehicle_Collisions_Crashes.csv")

columns_to_nullify = c('CRASH.DATE', 
                       'CRASH.TIME',
                       'BOROUGH',
                       'ZIP.CODE',
                       'LATITUDE',
                       'LONGITUDE',
                       'LOCATION',
                       'ON.STREET.NAME',
                       'OFF.STREET.NAME', 
                       'CROSS.STREET.NAME',
                       'NUMBER.OF.PEDESTRIANS.INJURED',
                       'NUMBER.OF.PEDESTRIANS.KILLED',
                       'NUMBER.OF.CYCLIST.INJURED',
                       'NUMBER.OF.CYCLIST.KILLED',
                       'NUMBER.OF.MOTORIST.INJURED',
                       'NUMBER.OF.MOTORIST.KILLED',
                       'CONTRIBUTING.FACTOR.VEHICLE.1',
                       'CONTRIBUTING.FACTOR.VEHICLE.2',
                       'CONTRIBUTING.FACTOR.VEHICLE.3',
                       'CONTRIBUTING.FACTOR.VEHICLE.4',
                       'CONTRIBUTING.FACTOR.VEHICLE.5',
                       'COLLISION_ID',
                       'VEHICLE.TYPE.CODE.2',
                       'VEHICLE.TYPE.CODE.3',
                       'VEHICLE.TYPE.CODE.4',
                       'VEHICLE.TYPE.CODE.5')


Start[columns_to_nullify] = NULL

library(wordcloud)
word_freqs1 = table(Start$VEHICLE.TYPE.CODE.1)
wordcloud(words = names(word_freqs1), freq = word_freqs1)


#remove any variable that has a frequency of 30 or less, why? because CLT applies well when the sample size is around 30 or greater.
frequency = table(Start$VEHICLE.TYPE.CODE.1)
df_filtered = Start[Start$VEHICLE.TYPE.CODE.1 %in% names(frequency[frequency > 30]), ] 


View(table(df_filtered$VEHICLE.TYPE.CODE.1))

#combine similar words

df_filtered$VEHICLE.TYPE.CODE.1 = tolower(df_filtered$VEHICLE.TYPE.CODE.1)#lower casing it

#Two Wheeled Vehicles___________________________________________________________
df_filtered$VEHICLE.TYPE.CODE.1[df_filtered$VEHICLE.TYPE.CODE.1 %in% 
                                  c(
                                    "bike", "e-bike","minibike","motorbike","e-bik","bicycle",
                                    "scooter","scoot","motorscooter","e-scooter","e-sco",
                                    "moped","motorcycle","pedicab"
                                  )] = "two_wheeler"

#2-Door Sedans__________________________________________________________________
df_filtered$VEHICLE.TYPE.CODE.1[df_filtered$VEHICLE.TYPE.CODE.1 %in% 
                                  c(
                                    "2 dr sedan","3-door","open body"
                                  )] = "2_door_sedan"

#4-Door Sedans__________________________________________________________________
df_filtered$VEHICLE.TYPE.CODE.1[df_filtered$VEHICLE.TYPE.CODE.1 %in% 
                                  c(
                                    "4 dr sedan", "subn","taxi","small com veh(4 tires)"
                                  )] = "4_door_sedan"

#Trucks_________________________________________________________________________
df_filtered$VEHICLE.TYPE.CODE.1[df_filtered$VEHICLE.TYPE.CODE.1 %in% 
                                  c(
                                    "pick-up truck", "truck","pick","pick up","pickup with mounted camper",
                                    "tow t","tow truck","van","van camper", "station wagon/sport utility vehicle",
                                    "sport utility / station wagon"
                                  )] = "trucks"

#Commercial Vehicles_____________________________________________________________
df_filtered$VEHICLE.TYPE.CODE.1[df_filtered$VEHICLE.TYPE.CODE.1 %in% 
                                  c(
                                    "tow truck / wrecker", "tractor truck diesel","tractor truck gasoline",
                                    "trail", "trailer","usps","refrigerated van","school bus","posta",
                                    "multi-wheeled vehicle","lunch wagon","livery vehicle","limo",
                                    "large com veh(6 or more tires)","garbage or refuse","garba",
                                    "flat rack","fire","fire truck","firet","firetruck","flat bed",
                                    "fdny","fdny ambul","fdny truck","amb","ambu","ambul","ambulance",
                                    "beverage truck","box t","box truck","box" ,"bulk agriculture",
                                    "bus","com","comme","commercial","concrete mixer","dump","delv",
                                    "deliv"
                                  )] = "commercial_vehicles"

#Remove everything except on the ones I made____________________________________

df_filtered$VEHICLE.TYPE.CODE.1[
  df_filtered$VEHICLE.TYPE.CODE.1 != c(
    "2_door_sedan","commercial_vehicles","trucks","4_door_sedan","two_wheeler")
] = NA

#New DataFrame__________________________________________________________________
values_to_keep <- c("2_door_sedan", "commercial_vehicles", "trucks", "4_door_sedan", "two_wheeler")

df <- df_filtered[df_filtered$VEHICLE.TYPE.CODE.1 %in% values_to_keep, ]


#Checking work__________________________________________________________________
#View(table(df$VEHICLE.TYPE.CODE.1))

#Word Cloud
library(wordcloud)
word_freqs = table(df$VEHICLE.TYPE.CODE.1)
wordcloud(words = names(word_freqs), freq = word_freqs)

#Beautifier_____________________________________________________________________
colnames(df)[c(1:3)] <- c("injured", "killed","vehicle") 



#Formatting_____________________________________________________________________
df$injured = ifelse(df$injured >= 1, 1, 0)
df$killed = ifelse(df$killed >= 1, 1, 0)

#small Cars
df$fourDoor = ifelse(df$vehicle == '4_door_sedan', 1, 0)
df$twoWheel = ifelse(df$vehicle == 'two_wheeler', 1, 0)
df$twoDoor = ifelse(df$vehicle == '2_door_sedan', 1, 0)

#big cars
df$comVeh = ifelse(df$vehicle == 'commercial_vehicles', 1, 0)
df$trucks = ifelse(df$vehicle == 'trucks', 1, 0)

#Treatment Variable

df$treatment <- ifelse(df$vehicle %in% c("commercial_vehicles", "trucks"), 1, 0) #1 if the car falls under big, 0 if it doesn't

#View(df)



df<- na.omit(df)

logistic_model = glm(formula = treatment ~ fourDoor+twoDoor+twoWheel+comVeh+trucks, family = binomial(), data = df)
predictions = predict(logistic_model, df)
#characteristics that predict my treatment
#vaccine correlated with flu
#TRETMENT WHO HAVE AND HAVEN'T
#Whether you get the vacine on if you have the flu in the past

#result is a log odds of getting the treatment

#model is spitting a number to compaer if we get treatment
#propensity score matches with actual people who get the vaccine
#matches with prediction to actual
#comparable because characteristics

#two people who are alike except in one characteristic
#find someone who is alike and compare them

df = cbind(df, predictions)


#characteristic of car and small and truck is biger and small
#isolate the factor of whether it's small or big

library(ggplot2)
ggplot(df,aes(x = predictions)) +
  geom_histogram(color = "black") +
  facet_wrap(~killed) +
  xlab("Probability of being killed") +
  theme_bw()


#_______________________________________________________________________________

library(MatchIt)
match_model <- matchit(treatment ~ fourDoor+twoDoor+twoWheel+comVeh+trucks , method = "nearest", data = df)

matched <- match.data(match_model)


#common Support
ggplot(matched,aes(x=predictions)) + 
  geom_histogram(data=subset(matched,treatment == 1),fill = "black", alpha = 0.8) +
  geom_histogram(data=subset(matched,treatment == 0),fill = "blue", alpha = 0.5) +
  xlab("Probability of Kill") +
  ggtitle("Common Support") +
  theme_bw()

#cars that are similar to trucks, no cars very similar to trucks, even if i match them it is a very terrible match



library(modelsummary)
models_effects <- list()
models_effects[['Effects on Killed']] <- lm(killed ~ treatment, matched)
models_effects[['Effects on Injured']] <- lm(injured ~ treatment, matched)
modelsummary(models_effects, stars=TRUE, title="Effects w/PSM")

#a big car decreases the probability that you will die in a collision

# a bigger car decrease the probability that you will get injured in a collision by 6.7% pp in 




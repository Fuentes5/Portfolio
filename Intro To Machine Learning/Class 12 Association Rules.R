
library(arules)
library(arulesViz)
data("Groceries")#data installed in R

View(Groceries)

itemFrequencyPlot(Groceries, topN=20) #creates an item frequency bar plot using the Grocerie data, using top20




#############################################33
rules = apriori(Groceries) #use a rule to mine groceries using the Apriori algorithm
summary(rules)#note, no rules shown 
##############################################

rules = apriori(Groceries, parameter = list(support=0.001,confidence=0.5)) 
                #same as the last code exept it chages it's defult to default behavior is to mine rules with minimum support of 0.1, 
                   #minimum confidence of 0.8, maximum of 10 items (maxlen)
summary(rules)# now we have 5668 rules 

###################################################

rules = apriori(Groceries, parameter = list(support=0.001,confidence=0.5))
sorted = sort(rules, by="lift")
inspect(sorted[1:50])
summary(rules)

##################################################
###########part 2 ###############################

?apriori # look at the bottom for the rules threshold
rules = apriori(Groceries, parameter = list(support=0.1))
summary(rules)

rules = apriori(Groceries, parameter = list(support=0.01))
summary(rules)

rules = apriori(Groceries, parameter = list(support=0.001))
summary(rules)

rules = apriori(Groceries, parameter = list(support=0.001,confidence=0.5))
summary(rules)

sorted = sort(rules, by="lift")
inspect(sorted[1:20])

plot(rules)

plot(rules, method="grouped")

plot(sorted[1:10], method = "graph")

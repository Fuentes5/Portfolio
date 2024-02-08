use activity4;


#Using subquery
select * 
from baseballteams
where runs = ( select max(Runs)
from baseballteams);

#Calculate a proportion
select Runs/AB as runatbats  
from baseballteams;

#Give you a number and you can use it as a subqueries
select max(AB) from baseballteams;


select Runs/(select max(AB) from baseballteams) as runatbats
from baseballteams;
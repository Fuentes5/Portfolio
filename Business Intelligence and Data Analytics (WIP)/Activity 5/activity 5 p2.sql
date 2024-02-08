use sakila;


#Which customers have the last name Smith

select*from customer;

select
	count(last_name) as Smith
from 
	customer
where
	last_name = 'smith';
    
    
    
#How mant customers last name start with the letter B?

select*from customer;

Select count(*) 
from customer
where last_name like 'B%';

# What is the average length of films in the film table?

Select * From film;

select AVG(length) as 'Average Length'
From film;

#What are the possible rental rates of films in the film table? 
#List each rate only once

select * from film;

select distinct rental_rate
from film;

#add a new actor to the actor table whose name is the same
# as yours

select * from actor;

INSERT INTO actor (actor_id, first_name, last_name,last_update)
values ('201','Jose','Fuentes','2024-02-06');


#Change the last name to Jones for all actors whose 
#first name begins with the letter O.

select *from actor;

Select count(*) 
from actor
where last_name like 'O%';

update actor
set last_name = 'Jones'
where last_name like 'O%';

Select count(*) 
from actor
where last_name like 'Jones%';

#Actor 3 (Ed Chase) had a role in film 43 (Atlantis Cause) 
#that somehow never made it into the actor-film table. 

select * from actor
where first_name like 'Ed%' 
and last_name like 'Chase%'; 

select * from film
where title like 'Atlantis Cause%';


INSERT INTO film_actor (actor_id, film_id)
VALUES (3, 43);

#For each film in the film table, show its title, rental_rate, and a column called "Appropriate for." 
#The "Appropriate for" column should say "Children" if the rating is P or PG, 
#"Teens" if its says PG-13, and "Adults" otherwise.

select
	title,
    rental_rate,
    Case
		when rating in('G','PG') Then 'children'
        when rating = 'pg-13' then 'teens'
        else 'adults'
	End as "Appropriate for"
From
	film;

#It turns out that Customer #1 
#never paid for Rental #76. So, delete the payment whose id is #1.

select*from payment;

delete from payment
where payment_id = 1;

select*from payment;





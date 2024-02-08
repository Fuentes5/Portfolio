#Baseball Queries

#1.	Which league has the higher batting average (BA = Hits / AtBats)?
use activity4;

select 
	league,
    AVG(AB) as "AverageBatting"
From
	baseballteams
group by
	league
order by
	AverageBatting DESC
Limit 1;


#2.	Which league has the most strikeouts? walks?

select * from baseballteams;
#_____________________________________________
select 
	league,
    max(Strikeouts) as "Max Strikeout"
From
	baseballteams
group by
	league
order by
	"Max Strikeout" DESC
Limit 1;

#____________________________________
select 
	league,
    max(walks) as "Max Walks"
From
	baseballteams
group by
	league
order by
	"Max W" DESC
Limit 1;



#Sakila Queries
use sakila;


select * from city;
select * from country;

select city.city, country.country
from city
inner Join country on city.country_id = country.country_id;


SELECT country.country, COUNT(city.city_id) AS num_cities
FROM country
LEFT JOIN city ON country.country_id = city.country_id
GROUP BY country.country
ORDER BY num_cities DESC, country.country;


SELECT country.country, COUNT(city.city_id) AS num_cities
FROM country
LEFT JOIN city ON country.country_id = city.country_id
GROUP BY country.country
HAVING num_cities > 2
ORDER BY num_cities DESC, country.country;


#Which stores have copies (in inventory) of the film 
#ACADEMY DINOSAUR?

select * from inventory;
select * from film;

SELECT COUNT(*) AS num_copies
FROM inventory
INNER JOIN film ON inventory.film_id = film.film_id
WHERE film.title = 'ACADEMY DINOSAUR';


SELECT city.city, COUNT(customer.customer_id) AS num_customers
FROM city
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON address.address_id = customer.address_id
GROUP BY city.city
ORDER BY num_customers DESC
LIMIT 1;

SELECT country.country, COUNT(customer.customer_id) AS num_customers
FROM country
INNER JOIN city ON country.country_id = city.country_id
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON address.address_id = customer.address_id
GROUP BY country.country
ORDER BY num_customers DESC
LIMIT 1;






select * from customer;

SELECT COUNT(*) AS num_customers_not_rented
FROM customer
WHERE active = 0;



select * from  payment;
select * from rental;
select * from category;


SELECT c.name AS category_name, SUM(p.amount) AS revenue
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY revenue DESC;



-- Step 1: Find the film with the largest cast
SELECT film_id, COUNT(actor_id) AS num_actors
FROM film_actor
GROUP BY film_id
ORDER BY num_actors DESC
LIMIT 1;

SELECT COUNT(actor_id) AS num_actors
FROM film_actor
WHERE film_id = 508;

select * from film;



SELECT 
    f.title AS film_title,
    SUM(p.amount) AS revenue
FROM 
    film f
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
JOIN 
    payment p ON r.rental_id = p.rental_id
GROUP BY 
    f.film_id, f.title
ORDER BY 
    revenue DESC
LIMIT 10;



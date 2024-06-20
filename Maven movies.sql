use mavenmovies;



-- Distinct Assignment

Select 
distinct rental_rate
from film;


-- Assignment where clause



select 
customer_id,
payment_id,
amount,
payment_date

from payment
where customer_id <= 100;

select 
customer_id,
amount,
payment_date

from payment
where customer_id <=100
order by customer_id asc, amount desc;

-- Assignment where & AND

select 
customer_id,
amount,
payment_date

from payment
where customer_id <= 100 AND amount > 5 AND payment_date >= '2006-01-01';


-- Assignment where & OR

select 
customer_id,
amount,
payment_date

from payment
where customer_id <= 100 AND amount > 5 AND payment_date >= '2006-01-01' OR amount > 5;


-- Assignment group by

-- count/arithematic functions will be used always when using group by function , it does not need to be used for order by functions, 

SELECT 
rental_duration,
count(film_id) as film
from film
group by rental_duration;



SELECT 
rental_duration as duration,
count(film_id) as film
from film
group by rental_duration
ORDER BY rental_duration asc;



-- AGGREGATE FUNCTIONS ASSIGNMENT
-- whenever we're using group by we need to use aggrgate functions if we're using more than 1 columns

select
replacement_cost,
count(film_id),
avg(rental_rate),
min(rental_rate),
max(rental_rate)
from film
group by replacement_cost;



-- Having clause assignment, having is used when group by is used.

select 
customer_id as customer,
count(rental_id)
from rental
group by customer_id having count(rental_id) < 15;


-- Order by assignment, order by comes at the end to sort result

select
title,
length,
rental_rate
from film
order by length desc;



-- single table analysis part 2 starts from here THIS IS PART 2 


select 
count(title),
length
from film
group by length
order by count(title) asc;

-- cASE STATEMENT EXAMPLE 
select 
title,
length,
CASE 
when length <90 then "Movie is too short"
when length between 90 and 120 then "Movie is good to watch"
when length > 120 then "Movie is too long"
else "Add more coding"
End "Bucket"
from film;


-- Assignment CASE STATEMENT

select
distinct active
from customer;


select
first_name,
last_name,
active,
store_id,
case
when store_id = 1 AND active = 1 then "store 1 active"
when store_id = 1 AND active = 0 then "store 1 inactive"
when store_id = 2 AND active = 1 then "Store 2 active"
when store_id = 2 AND active = 0 then "store 2 inactive"
else "Add coding"

end Result

from customer
order by Result asc;

select 
count(customer_id),
case
when store_id = 1 AND active = 1 then "Store 1 active"
when store_id = 2 AND active = 1  then "Store 2 active"
else "more coding required"
end "Comments"
from customer
group by Comments;


-- Mid course Examination:

-- 1 List of staff memebers names, email addresses and store idenficiation number

Select 
first_name,
last_name,
email,
store_id
from staff;


-- 2 count for items held at individual store

select 
count(inventory_id),
store_id
from inventory
group by store_id;


select 
count(film_id),
film_id,
store_id
from inventory
group by film_id , store_id
order by store_id desc, film_id asc;


-- 3 count of active customers in each of your stores

select
count(customer_id),
store_id,
active
from customer
group by store_id, active;

select
count(customer_id) as "Count",
store_id as "STORE",
active as "ACTIVE CUSTOMERS"
from customer
where active = 1
group by store_id, active;

-- don't need to include active column, can still use where to get the same result for the above
select
count(customer_id) as "Count",
store_id as "STORE"
from customer
where active = 1
group by store_id;


-- 4 COUNT OF ALL CUSTOMER EMAIL ADDRESSES STORED

select
count(email)
from customer;

-- 5 count of unique film titles each store, count of unique cateorgies of films you provide

select 
count(distinct film_id),
store_id
from inventory 
group by store_id;



select 
count(category_id)
category_id
from film_category
group by category_id;

select
distinct count(category_id)
from film_category;

-- 6 replacement cost for least expensive the most expensive and average of all films


select
min(replacement_cost),
max(replacement_cost),
avg(replacement_Cost)
from film;


-- 7 Avg payment and maximum payment

select
avg(amount),
max(amount)
from 
payment;


-- 8 customer identification values, count of rentals, highest volume at top

select
count(rental_id),
customer_id
from rental
group by customer_id
order by count(rental_id) desc;





-- JOIN 
-- inner join is used when we want to retrieve common items only think of it as the middle part of the vendiagram, common items only
-- 
-- Inner Join Assignment


select
title,
description,
store_id,
inventory_id

from film
inner join inventory
	on film.film_id = inventory.film_id;
    
    
-- self test

select 
title,
description, 
store_id,
inventory_id

from film
inner join inventory 
on film.film_id = inventory.film_id;
 
 
 
 -- test
 
select distinct
inventory.inventory_id,
rental.inventory_id
from inventory
inner join rental
on inventory.inventory_id = rental.inventory_id

limit 5000;



-- LEFT JOIN, ALL OF LEFT VALUES AND MATCHING VALUES FROM RIGHT TABLE 

select
title,
count(actor_id) as "Count"

from film
left join film_actor
on film.film_id = film_actor.film_id
group by title;

-- Bridge is when you use another table to join 2 tables since that table has keys to both other tables but the other tables don't have anything in common
-- need to find film_id, category, 
-- join first table with inner join to common table then join second intended table to common table

select
film.film_id,
film.title,
category.name

from film
inner join film_category 
on film.film_id = film_category.film_id

inner join category 
on category.category_id = film_category.category_id;





-- Bridging assignment ( additional count of those actors with movies )

select 
actor.first_name,
actor.last_name,
film.title 
from actor
inner join film_actor
on actor.actor_id = film_actor.actor_id

inner join film
on film.film_id = film_actor.film_id;



-- Multi condition joins
-- can use where or AND in the join statement to only get the required conditional result

-- MULTI CONDITION ASSIGNMENT

select
distinct film.title,
film.description

from film

inner join inventory
on film.film_id = inventory.film_id
and store_id = 2; 



-- =========================================================== FINAL PROJECT =========================================================

-- Q1 (Manager's name for each store, full address of each property)

select *
from store;

select 
staff.first_name,
staff.last_name,
address.address,
address.district,
city.city,
country.country

from staff
inner join address
on staff.address_id = address.address_id

inner join city
on address.city_id = city.city_id

inner join country
on city.country_id = country.country_id;



-- 2 (Pulling report together for each inventory item including store_id number, inventory_id, name of film, rating, rental rate and replacement cost)

select 
inventory.inventory_id,
inventory.film_id,
inventory.store_id,
film.title,
film.rating,
film.rental_rate,
film.replacement_cost

from inventory 
 inner join film 
 on inventory.film_id = film.film_id
 
 order by store_id;
 
 
 -- 3 building up on Q2m give overview, with how many items we have at each store with each rating
 
 
select 
count(inventory.film_id),
inventory.store_id,
film.rating

from inventory 
 inner join film 
 on inventory.film_id = film.film_id;
 
 
 
 -- 5 (Customer names, the store they go to, active?, full addresses with city and country)
 
select 
customer.first_name,
customer.last_name,
customer.address_id,
customer.active,
customer.store_id,
address.address,
city.city,
country.country


from customer 
inner join address
on customer.address_id = address.address_id

inner join city
on address.city_id = city.city_id

inner join country
on city.country_id
Limit 5000;

-- 6 (customer names, lifetime rentals,sum of all payments, most valuable customer on top.

select
customer.first_name,
customer.last_name,
sum(amount) as "Total Amount",
count(payment.rental_id) as "No of Rentals"
from customer
inner join payment
on customer.customer_id=payment.customer_id

group by customer.first_name,customer.last_name
order by sum(amount) desc;


-- 7 (list of advisor and investors, company for investors)

select
"advisor" as Type,
advisor.first_name,
advisor.last_name,
null
from advisor

UNION

select
"investor" as type,
investor.first_name,
investor.last_name,
investor.company_name


from investor;


-- 8 
select *
from actor_award;

Select
actor_award_id,

case
when actor_award.awards = "Emmy, Oscar, Tony " then "3 Awards"
when actor_award.awards IN ('Emmy, Oscar','Emmy, Tony','Oscar, Tony') then '2 Awards'
else "1 Award"
end as "Number of awards"

from actor_award;


Select
count(actor_award_id),

case
when actor_award.awards = "Emmy, Oscar, Tony " then "3 Awards"
when actor_award.awards IN ('Emmy, Oscar','Emmy, Tony','Oscar, Tony') then '2 Awards'
else "1 Award"
end as "Number of awards"

from actor_award
group by 
case
when actor_award.awards = "Emmy, Oscar, Tony " then "3 Awards"
when actor_award.awards IN ('Emmy, Oscar','Emmy, Tony','Oscar, Tony') then '2 Awards'
else "1 Award"
end;




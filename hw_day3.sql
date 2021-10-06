--Q1
SELECT first_name, last_name, district
FROM customer
JOIN address 
ON customer.address_id = address.address_id
WHERE address.district = 'Texas';
-- Answers:
-- "Jennifer"	"Davis"	"Texas"
-- "Kim"	"Cruz"	"Texas"
-- "Richard"	"Mccrary"	"Texas"
-- "Bryan"	"Hardison"	"Texas"
-- "Ian"	"Still"	"Texas"

-- Q2
SELECT first_name, last_name, amount
FROM customer
JOIN payment 
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;
-- Answer: Many

--Q3
SELECT first_name, last_name, sum(amount)
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
Where payment.customer_id IN(
		Select customer_id
		FROM payment
		GROUP BY customer_id
		HAVING SUM(amount) > 175
)
GROUP BY first_name, last_name;
-- Answer:
-- "Tommy"	"Collazo"	183.63
-- "Clara"	"Shaw"	189.60
-- "Karl"	"Seal"	208.58
-- "Eleanor"	"Hunt"	211.55
-- "Marion"	"Snyder"	194.61
-- "Rhonda"	"Kennedy"	191.62
	

-- Q4
SELECT first_name, last_name, city
FROM customer
JOIN address 
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
WHERE city = 'Nepal';
-- Answer: No Customers

-- Q5
SELECT first_name, last_name, transactions
FROM staff x
JOIN
	(SELECT staff_id, count(*) as transactions 
	FROM rental c
	GROUP BY c.staff_id) b
	ON x.staff_id = b.staff_id
	GROUP BY first_name, last_name, transactions
	HAVING transactions = max(transactions);
-- Answer: "Mike"	"Hillyer"	8040

-- Q6:
SELECT title, count(actor_id)
FROM film_actor
JOIN film
ON film_actor.film_id = film.film_id
GROUP BY title
ORDER BY count(actor_id) DESC
LIMIT 1;
-- Answer: "Lambs Cincinatti"	15

-- Q7:
SELECT first_name, last_name, count(film_actor.actor_id)
FROM film_actor
JOIN actor
ON film_actor.actor_id = actor.actor_id
Group by first_name, last_name
ORDER BY count(film_actor.actor_id)
LIMIT 1;
-- Answer: "Emily"	"Dee"	14

-- Q8:
SELECT count(x.district)
FROM
(SELECT district, count(customer_id)
FROM address
JOIN customer
ON customer.address_id = address.address_id
GROUP BY district
HAVING count(customer_id) > 5) x; 
-- Answer: 9


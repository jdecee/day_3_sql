-- Question 1
SELECT customer_id, first_name, last_name, email, district
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'Texas';
-- Answer: 5 people live in Texas. See returned table for info.
​
​
-- Question 2
SELECT payment_id, amount, CONCAT(first_name, ' ', last_name) AS full_name
FROM payment
JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;
-- Answer: 1406 rows
​
​
-- Question 3
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
);
​
​
​
-- Question 4
SELECT country.country_id, country.country, customer.first_name, customer.last_name
FROM country
JOIN city
ON country.country_id = city.country_id
JOIN address
ON city.city_id = address.city_id
JOIN customer
ON address.address_id = customer.address_id
WHERE country = 'Nepal';
​
​
SELECT *
FROM customer
WHERE address_id = (
	SELECT address_id
	FROM address
	WHERE city_id = (
		SELECT city_id
		FROM city
		WHERE country_id = (
			SELECT country_id
			FROM country
			WHERE country = 'Nepal'
		)
	)
);
​
​
-- Question 5
SELECT staff.staff_id, first_name, last_name, COUNT(*)
FROM payment
JOIN staff
ON staff.staff_id = payment.staff_id
GROUP BY staff.staff_id
ORDER BY COUNT(*) DESC;
-- Answer: John Stephens
​
-- Question 6
SELECT f.film_id, f.title, f.description, COUNT(*) as number_of_actors
FROM film_actor as f_a
JOIN film as f
ON f_a.film_id = f.film_id
GROUP BY f.film_id
ORDER BY number_of_actors DESC
LIMIT 1;
-- Answer: Lambs Cincinatti with 15 actors
​
-- Question 7
SELECT a_.actor_id, a_.first_name, a_.last_name, COUNT(*) as number_of_films
FROM film_actor AS f_a
JOIN actor AS a_
ON f_a.actor_id = a_.actor_id
GROUP BY a_.actor_id
ORDER BY number_of_films
LIMIT 1;
-- Answer: Emily Dee with 14 films
​
​
-- Question 8
SELECT district, COUNT(*)
FROM address
GROUP BY district
HAVING COUNT(*) > 5;
​
​
SELECT COUNT(*)
FROM (
	SELECT district, COUNT(*)
	FROM address
	GROUP BY district
	HAVING COUNT(*) > 5
) AS districts_over_five_customers;
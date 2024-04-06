-- Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
SELECT title, length, RANK() OVER(ORDER BY length DESC)
FROM sakila.film
WHERE length > 0;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.
SELECT title, length, rating, RANK() OVER(PARTITION BY rating ORDER BY length DESC)
FROM sakila.film
WHERE length>0;

-- How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
SELECT COUNT(C1.film_id), C1.category_id
FROM sakila.film_category C1
LEFT JOIN sakila.category C2
	ON C1.category_id= C2.category_id
GROUP BY category_id;

-- Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
SELECT COUNT(AC.actor_id), AC.first_name, AC.last_name
FROM sakila.film_actor FA
LEFT JOIN sakila.actor AC
	ON FA.actor_id=AC.actor_id
GROUP BY first_name, last_name
ORDER BY COUNT(AC.actor_id) DESC
LIMIT 1;

-- Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT COUNT(CU.customer_id), CU.first_name, CU.last_name 
FROM sakila.rental RE
LEFT JOIN sakila.customer CU
	ON RE.customer_id=CU.customer_id
GROUP BY first_name, last_name
ORDER BY COUNT(CU.customer_id) DESC
LIMIT 1;


-- Which is the most rented film? (The answer is Bucket Brotherhood).
SELECT COUNT(rental_id), title
FROM sakila.film FI 
LEFT JOIN sakila.inventory INV 
	ON FI.film_id=INV.film_id
LEFT JOIN sakila.rental RE
	ON INV.inventory_id=RE.inventory_id
GROUP BY FI.title
ORDER BY COUNT(rental_id) DESC
LIMIT 1
    ;
# Lab | SQL Queries 3
# 1. How many distinct (different) actors' last names are there?
# 2. In how many different languages where the films originally produced? (Use the column language_id from the film table)
# 3. How many movies were released with "PG-13" rating?
# 4. Get 10 the longest movies from 2006.
# 5. How many days has been the company operating (check DATEDIFF() function)?
# 6. Show rental info with additional columns month and weekday. Get 20.
# 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
# 8. How many rentals were in the last month of activity?

USE sakila;

# 1. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name)
FROM actor;

# 2. In how many different languages where the films originally produced? (Use the column language_id from the film table)
SELECT COUNT(DISTINCT language_id)
FROM film;

# 3. How many movies were released with "PG-13" rating?
SELECT COUNT(rating)
FROM film
WHERE rating = "PG-13";

# 4. Get 10 the longest movies from 2006.
SELECT *
FROM film
ORDER BY length DESC
LIMIT 10;

# 5. How many days has been the company operating (check DATEDIFF() function)?
SELECT rental_date
FROM rental
ORDER BY rental_date DESC
LIMIT 1;

SELECT rental_date
FROM rental
ORDER BY rental_date ASC
LIMIT 1;

SELECT rental_id, DATE_FORMAT(rental_date, "%Y-%m-%d") as first_rental_date, DATEDIFF("2005-05-24",DATE_FORMAT(rental_date, "%Y-%m-%d")) AS DateDiff
FROM rental
ORDER BY rental_date DESC
LIMIT 1;

# 6. Show rental info with additional columns month and weekday. Get 20.
SELECT rental_id, rental_date, (DATE_FORMAT (rental_date, "%M")) AS month , DAYNAME(rental_date) AS weekday
FROM rental
LIMIT 20;

# 7. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT *,
CASE
	WHEN (DAYNAME(rental_date) = "Saturday" or "Sunday") THEN "Weekend"
	ELSE "Workday"
    END as day_type
from rental;

# 8. How many rentals were in the last month of activity? (do you want february 2006 or date diff between 14/02/2006 and 14/01/2006??)
# OPTION 1 - 182 returned --> 182 rentals in February
SELECT rental_id, rental_date , MONTHNAME(rental_date)
FROM rental
WHERE (MONTHNAME(rental_date) = "February");

#THIS WAS JUST TO CHECK --> in 2006 , only rented films on the VALENTINE's DAY  ahahahaah
SELECT rental_id, rental_date , MONTHNAME(rental_date)
FROM rental
WHERE (MONTHNAME(rental_date) = "January");

SELECT rental_id, rental_date , MONTHNAME(rental_date), YEAR(rental_date), DAYNAME(rental_date)
FROM rental
WHERE (YEAR(rental_date) = "2006");


# OPTION 2 - DATEDIFF 14/02/2006 and 14/01/2006 --> same 182 rows as above
SELECT * 
FROM rental
ORDER BY rental_date DESC;

SELECT rental_id, DATE_FORMAT(rental_date,"%Y-%m-%d") AS date_2, datediff("2006-02-14",DATE_FORMAT(rental_date,"%Y-%m-%d")) AS date_3
FROM rental
WHERE datediff("2006-02-14", DATE_FORMAT(rental_date,"%Y-%m-%d")) < 30;
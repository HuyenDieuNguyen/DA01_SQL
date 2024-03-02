--Ex1:
SELECT Name
FROM STUDENTS
WHERE Marks > 75
ORDER BY RIGHT(Name,3),ID
--Ex2:
SELECT user_id, CONCAT(UPPER(SUBSTRING(name,1,1)), LOWER(SUBSTRING(name,2))) AS name
FROM Users
ORDER BY user_id
--Ex3:
SELECT manufacturer, CONCAT('$', ROUND(SUM(total_sales) / 1000000)) AS sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer
--Ex4:
SELECT EXTRACT(MONTH FROM submit_date) AS mth, 
product_id AS product, 
ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY mth, product, EXTRACT(MONTH FROM submit_date)
ORDER BY mth, product
--Ex5:
SELECT sender_id, COUNT(*) AS message_count
FROM messages
WHERE EXTRACT(YEAR FROM sent_date) = 2022 AND EXTRACT(MONTH FROM sent_date) = 8
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2
--Ex6:
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15
--Ex7:
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY activity_date
--Ex8:
SELECT COUNT(*) AS number_of_hires
FROM employees
WHERE EXTRACT(YEAR FROM joining_date) = 2022
AND EXTRACT(MONTH FROM joining_date) BETWEEN 1 AND 7
--Ex9:
SELECT POSITION('a' IN LOWER(first_name)) AS position_of_a
FROM worker
WHERE LOWER(first_name) = 'amitah'
--Ex10:
SELECT title, 
CAST(SUBSTRING(title FROM '(\d{4})') AS int) AS vintage_year
FROM winemag_p2
WHERE country = 'Macedonia'


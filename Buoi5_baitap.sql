--Ex1:
SELECT DISTINCT CITY
FROM STATION
WHERE (ID % 2) = 0
ORDER BY CITY
--Ex2:
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) FROM STATION
Ex4:
SELECT ROUND(SUM(CAST(item_count AS DECIMAL(10,2)) * order_occurrences) / SUM(order_occurrences), 1) AS mean
FROM items_per_order
--Ex5:
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
--Ex6:
SELECT 
user_id, 
DATE(MAX(post_date)) - DATE(MIN(post_date)) AS days_between
FROM posts
WHERE post_date >= '2021-01-01' AND post_date < '2022-01-01'
GROUP BY user_id
HAVING COUNT(post_id) >= 2
--Ex7:
SELECT card_name,
MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC
--Ex8:
SELECT manufacturer,
COUNT(*) AS drug_count,
SUM(ABS(total_sales - cogs)) AS total_loss
FROM pharmacy_sales
WHERE total_sales < cogs
GROUP BY anufacturer
ORDER BY total_loss DESC
--Ex9:
SELECT *
FROM Cinema
WHERE id % 2 <> 0 AND description <> 'boring'
ORDER BY rating DESC
--Ex10:
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id
--Ex11:
SELECT user_id, COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id
--Ex12:
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5

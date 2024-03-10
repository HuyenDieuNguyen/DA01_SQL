--EX1:
SELECT COUNTRY.Continent, FLOOR(AVG(CITY.Population)) AS Average_City_Population
FROM CITY
JOIN COUNTRY ON CITY.CountryCode = COUNTRY.Code
GROUP BY COUNTRY.Continent

--EX2:
  SELECT 
ROUND((COUNT(DISTINCT CASE WHEN t.signup_action = 'Confirmed' THEN e.user_id END) / 
NULLIF(COUNT(DISTINCT e.user_id), 0)), 2) AS activation_rate
FROM emails e
LEFT JOIN texts t ON e.email_id = t.email_id

--EX3:
SELECT age_breakdown.age_bucket,
ROUND((SUM(CASE WHEN activities.activity_type = 'send' THEN activities.time_spent ELSE 0 END) / 
NULLIF(SUM(activities.time_spent), 0)) * 100.0,2) AS send_perc,
ROUND((SUM(CASE WHEN activities.activity_type = 'open' THEN activities.time_spent ELSE 0 END) / 
NULLIF(SUM(activities.time_spent), 0)) * 100.0,2) AS open_perc
FROM age_breakdown
LEFT JOIN activities ON age_breakdown.user_id = activities.user_id
GROUP BY age_breakdown.age_bucket

--EX4:
  SELECT customer_id
FROM customer_contracts cc
JOIN products p ON cc.product_id = p.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT p.product_category) = (SELECT COUNT(DISTINCT product_category) FROM products)

  --Ex5:
SELECT 
    e.employee_id AS employee_id,
    e.name AS name,
    COUNT(r.employee_id) AS reports_count,
    ROUND(AVG(r.age)) AS average_age
FROM Employees e
LEFT JOIN Employees r ON e.employee_id = r.reports_to
WHERE e.employee_id IN (SELECT DISTINCT reports_to FROM Employees WHERE reports_to IS NOT NULL)
GROUP BY e.employee_id, e.name
ORDER BY e.employee_id

  --Ex6:
SELECT p.product_name,SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE MONTH(o.order_date) = 2 
AND YEAR(o.order_date) = 2020
GROUP BY p.product_id
HAVING SUM(o.unit) >= 100

--Ex7:
SELECT pages.page_id
FROM pages
LEFT JOIN page_likes ON pages.page_id = page_likes.page_id
WHERE page_likes.page_id IS NULL
ORDER BY pages.page_id

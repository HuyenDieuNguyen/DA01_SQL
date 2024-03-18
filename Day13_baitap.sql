-- EX1:
SELECT COUNT(*) AS duplicate_companies
FROM (SELECT company_id
    FROM job_listings
    GROUP BY company_id, title, description
    HAVING COUNT(*) > 1) AS duplicate_job_listings

--EX2:
SELECT 
ps.category,
ps.product,
ps.total_spend
FROM (SELECT 
        category,
        product,
        SUM(spend) AS total_spend,
        RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS product_rank
        FROM product_spend
        WHERE EXTRACT(YEAR FROM transaction_date) = 2022
        GROUP BY category, product) AS ps
        WHERE ps.product_rank <= 2

--EX3:
SELECT COUNT(DISTINCT policy_holder_id) AS num_members_with_3_or_more_calls
FROM (SELECT policy_holder_id
    FROM callers
    GROUP BY policy_holder_id
    HAVING COUNT(DISTINCT case_id) >= 3) AS subquery

--EX4:
SELECT pages.page_id
FROM pages
LEFT JOIN page_likes ON pages.page_id = page_likes.page_id
WHERE page_likes.page_id IS NULL
ORDER BY pages.page_id ASC

--EX5:
SELECT 7 AS month,
COUNT(DISTINCT ua.user_id) AS monthly_active_users
FROM user_actions ua
JOIN (SELECT DISTINCT user_id
      FROM user_actions
      WHERE EXTRACT(MONTH FROM event_date) = 6)
AS last_month ON ua.user_id = last_month.user_id
WHERE EXTRACT(MONTH FROM ua.event_date) = 7
GROUP BY month

--EX6:
SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(id) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY month, country

--EX7:
SELECT 
    s.product_id,
    s.year AS first_year,
    s.quantity,
    s.price
FROM Sales s
JOIN (SELECT product_id,MIN(year) AS first_year
    FROM Sales
    GROUP BY product_id) AS first_year_sales 
    ON s.product_id = first_year_sales.product_id AND s.year = first_year_sales.first_year

--EX8:
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(DISTINCT product_key) FROM Product)

--EX9:
SELECT e.employee_id
FROM Employees e
LEFT JOIN Employees m ON e.manager_id = m.employee_id
WHERE e.salary < 30000 AND m.employee_id IS NULL
ORDER BY e.employee_id

--EX10:
SELECT COUNT(*) AS duplicate_companies
FROM (
    SELECT company_id
    FROM job_listings
    GROUP BY company_id, title, description
    HAVING COUNT(*) > 1) AS duplicate_job_listings

--EX11:
SELECT m.title AS results
FROM Movies m
JOIN (
    SELECT movie_id, AVG(rating) AS avg_rating
    FROM MovieRating
    WHERE created_at >= '2020-02-01' AND created_at < '2020-03-01'
    GROUP BY movie_id
    ORDER BY avg_rating DESC, movie_id ASC
    LIMIT 1) r ON m.movie_id = r.movie_id
ORDER BY m.title ASC

--EX12:
SELECT id, num
FROM (SELECT user_id AS id, COUNT(*) AS num
    FROM (SELECT requester_id AS user_id FROM RequestAccepted
        UNION ALL
        SELECT accepter_id AS user_id FROM RequestAccepted) AS temp
    GROUP BY user_id) AS friend_counts
  ORDER BY num DESC
  LIMIT 1

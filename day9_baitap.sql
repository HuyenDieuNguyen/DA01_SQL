--Ex1:
SELECT 
SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END) AS mobile_views
FROM 
viewership
--Ex2:
SELECT 
x,y,z,
CASE 
    WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes'
    ELSE 'No'
END AS triangle
FROM 
Triangle
--Ex3:
SELECT 
CASE 
  WHEN COUNT(*) = 0 THEN 0
  ELSE ROUND((COUNT(CASE WHEN call_category IS NULL OR call_category = '' THEN 1 ELSE NULL END) / COUNT(*)) * 100, 1)
END AS call_percentage
FROM callers
--Ex4:
SELECT 
CASE
  WHEN COUNT(*) = 0 THEN 0
  ELSE ROUND((COUNT(CASE WHEN call_category IS NULL OR call_category = '' THEN 1 ELSE NULL END) / NULLIF(COUNT(*), 0)) * 100, 1)
END AS call_percentage
FROM callers



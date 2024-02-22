-- Ex1: 
SELECT NAME 
FROM CITY 
WHERE CountryCode = 'USA' AND Population > 120000;
-- Ex2:
SELECT * FROM CITY
WHERE COUNTRYCODE = 'JPN' 
-- Ex3:
SELECT CITY, STATE FROM STATION
-- Ex4:
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[aeiouAEIOU]';
-- Ex5:
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '[aeiouAEIOU]$';
-- Ex6:
SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '^[aeiouAEIOU]';
-- Ex7:
SELECT name
FROM Employee
ORDER BY name;
-- Ex8:
SELECT name
FROM Employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id ASC;
-- Ex9: 
SELECT product_id FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y'
--Ex10:
SELECT name FROM Customer
WHERE referee_id IS NULL OR referee_id != 2
--Ex11:
CREATE TABLE Country (
    name VARCHAR(255) PRIMARY KEY,
    continent VARCHAR(255),
    area INT,
    population INT,
    gdp BIGINT
);
--Ex12:
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id ASC;
--Ex13:
SELECT part, assembly_step FROM parts_assembly
WHERE finish_date IS NULL;
--Ex14:
SELECT part, assembly_step FROM parts_assembly
WHERE finish_date IS NULL;
--Ex15:
SELECT advertising_channel
FROM uber_advertising
WHERE year = 2019 AND money_spent > 100000;

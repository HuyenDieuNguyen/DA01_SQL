-- EX1:
WITH yearly_spend AS (
    SELECT
        EXTRACT(YEAR FROM transaction_date) AS year,
        product_id,
        SUM(CASE WHEN EXTRACT(YEAR FROM transaction_date) = EXTRACT(YEAR FROM CURRENT_DATE) THEN spend END) AS curr_year_spend,
        SUM(CASE WHEN EXTRACT(YEAR FROM transaction_date) = EXTRACT(YEAR FROM CURRENT_DATE) - 1 THEN spend END) AS prev_year_spend
    FROM user_transactions
    GROUP BY EXTRACT(YEAR FROM transaction_date), product_id
)
SELECT
    year,
    product_id,
    curr_year_spend,
    prev_year_spend,
    CASE 
        WHEN prev_year_spend IS NULL THEN NULL
        ELSE ROUND(((curr_year_spend - prev_year_spend) / prev_year_spend) * 100, 2)
    END AS yoy_rate
FROM yearly_spend
ORDER BY year, product_id

-- EX2:
SELECT mci.card_name, mci.issued_amount
FROM monthly_cards_issued mci
JOIN (
    SELECT card_name, MIN(issue_year * 12 + issue_month) AS min_issue_month
    FROM monthly_cards_issued
    GROUP BY card_name
) AS min_month ON mci.card_name = min_month.card_name 
              AND mci.issue_year * 12 + mci.issue_month = min_month.min_issue_month
ORDER BY mci.issued_amount DESC

-- EX3:
WITH RankedTransactions 
AS (
    SELECT 
        user_id,
        spend,
        transaction_date,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS transaction_rank
    FROM transactions
)
SELECT 
    user_id,
    spend,
    transaction_date
FROM RankedTransactions
WHERE transaction_rank = 3

-- EX4:
WITH RankedTransactions AS (
    SELECT 
        user_id,
        MAX(transaction_date) AS recent_transaction_date,
        COUNT(product_id) AS num_products,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY MAX(transaction_date) DESC) AS transaction_rank
    FROM user_transactions
    GROUP BY user_id
)
SELECT 
    recent_transaction_date,
    user_id,
    num_products
FROM RankedTransactions
WHERE transaction_rank = 1
ORDER BY recent_transaction_date

-- EX5:
SELECT user_id, tweet_date,
ROUND(AVG(tweet_count) OVER (PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_average
FROM tweets
ORDER BY user_id, tweet_date

-- EX6:
SELECT COUNT(DISTINCT t2.transaction_id) AS payment_count
FROM transactions t1
JOIN transactions t2 ON t1.merchant_id = t2.merchant_id 
                      AND t1.credit_card_id = t2.credit_card_id 
                      AND t1.amount = t2.amount
                      AND t2.transaction_id > t1.transaction_id
                      AND EXTRACT(EPOCH FROM (t2.transaction_timestamp - t1.transaction_timestamp)) <= 600

-- EX7:
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

-- EX8:
WITH Top10Artists AS (
    SELECT a.artist_id, a.artist_name, COUNT(*) AS appearances
    FROM global_song_rank g
    JOIN songs s ON g.song_id = s.song_id
    JOIN artists a ON s.artist_id = a.artist_id
    WHERE g.rank <= 10
    GROUP BY a.artist_id, a.artist_name
),
RankedArtists AS (
    SELECT artist_id, artist_name, appearances, RANK() OVER (ORDER BY appearances DESC) AS artist_rank
    FROM Top10Artists
)
SELECT artist_name, artist_rank
FROM RankedArtists
WHERE artist_rank <= 5
ORDER BY artist_rank

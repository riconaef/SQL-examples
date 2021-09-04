-- Simple Query
SELECT id, name
FROM accounts
LIMIT 10;

-- Order BY
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

-- Order BY several columns
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd

-- WHERE (pulls all rows with gloss_amt_usd larger than 999)
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5

--WHERE with strings
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil'

-- Derived columns
SELECT standard_amt_usd/standard_qty AS std_paper_price, id, account_id
FROM orders
LIMIT 10

SELECT poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per, id, account_id
FROM orders
LIMIT 10

-- LIKE, NOT LIKE
SELECT name
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s'

-- BETWEEN (includes the borders)
SELECT *
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29


SELECT *
FROM web_events
WHERE channel IN ('organic','adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC

-- combine everything
SELECT *
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND primary_poc LIKE '%Ana%' AND primary_poc NOT LIKE '%eana%'



Statement	How to Use It	Other Details
SELECT	    SELECT Col1, Col2, ...	         Provide the columns you want
FROM	      FROM Table                       Provide the table where the columns exist
LIMIT	      LIMIT 10	                       Limits based number of rows returned
ORDER BY	  ORDER BY Col	                   Orders table based on the column. Used with DESC.
WHERE	      WHERE Col > 5	                   A conditional statement to filter your results
LIKE	      WHERE Col LIKE '%me%'	           Only pulls rows where column has 'me' within the text
IN	        WHERE Col IN ('Y', 'N')	         A filter for only rows with column of 'Y' or 'N'
NOT	        WHERE Col NOT IN ('Y', 'N')	     NOT is frequently used with LIKE and IN
AND	        WHERE Col1 > 5 AND Col2 < 3      Filter rows where two or more conditions must be true
OR	        WHERE Col1 > 5 OR Col2 < 3	     Filter rows where at least one condition must be true
BETWEEN	    WHERE Col BETWEEN 3 AND 5	       Often easier syntax than using an AND

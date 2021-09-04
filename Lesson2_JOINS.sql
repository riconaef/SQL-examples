SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

--
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM accounts
JOIN orders
ON orders.account_id = accounts.id;



--example queries
SELECT a.name, a.primary_poc, w.occurred_at, w.channel
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
WHERE a.name = 'Walmart'

SELECT r.name regio_name, s.name sales_name, a.name accounts_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
ORDER BY accounts_name

SELECT r.name regio_name, a.name account_name,
o.total_amt_usd/(o.total+0.01) unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id

--further exercises
SELECT r.name regio_name, a.name account_name,
s.name sales_name
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
WHERE r.name = 'Midwest'
ORDER BY a.name

SELECT r.name regio_name, a.name account_name, total_amt_usd/(total+0.01) unit_price
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
WHERE o.standard_qty > 100

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY o.occurred_at DESC



-- GROUP BY
SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name

-- Count how many times each channel was used
SELECT w.channel, COUNT(channel) sum
FROM web_events w
GROUP BY w.channel

SELECT s.name, w.channel, COUNT(*) cou
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name, w.channel
ORDER BY cou DESC;

SELECT r.name region, w.channel, COUNT(*) num_events
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;

--HAVING (use with aggregated columns)
SELECT s.id, s.name, COUNT(*) num_reps
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_reps

--Which accounts used facebook as a channel to contact customers more than 6 times?
SELECT a.id, a.name, COUNT(*) num_events, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY num_events

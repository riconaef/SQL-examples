SELECT DATE_PART('year', occurred_at), SUM(total_amt_usd) total_dollars
FROM orders
GROUP BY 1
ORDER BY 2


SELECT DATE_PART('year', occurred_at) day_time, COUNT(*)
FROM orders
GROUP BY 1
ORDER BY 2 DESC


-- In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
SELECT DATE_TRUNC('month', o.occurred_at), SUM(o.gloss_amt_usd)
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC

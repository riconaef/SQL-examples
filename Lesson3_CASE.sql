--CASE statement
SELECT account_id, total_amt_usd, CASE WHEN total_amt_usd > 3000 THEN 'LARGE' ELSE 'SMALL' END total_amt
FROM orders

SELECT CASE WHEN total >= 2000 THEN 'At least 2000'
			      WHEN total < 2000 AND total >= 1000 THEN 'Between 1000 and 2000'
            ELSE 'Less than 1000' END AS order_category,
       COUNT(*) AS order_count
FROM orders
GROUP BY 1
ORDER BY 1 DESC



SELECT a.name, SUM(total_amt_usd),
		CASE WHEN SUM(total_amt_usd) >= 200000     					THEN 'top'
			 WHEN SUM(total_amt_usd) <= 100000
             	 THEN 'middle'
             ELSE 'low' END AS level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY 2 DESC



QUESTION 6:
--The previous didn't account for the middle, nor the dollar amount associated with the sales. Management decides they want to see these characteristics represented as well. We would like to identify top performing sales reps, which are sales reps associated with more than 200 orders or more than 750000 in total sales. The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name, the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria. Place the top sales people based on dollar amount of sales first in your final table. You might see a few upset sales people by this criteria!

SELECT s.name, COUNT(*), SUM(total_amt_usd),
		CASE WHEN COUNT(*) >= 200 OR SUM(total_amt_usd) > 750000 THEN 'top'
         WHEN COUNT(*) >= 150 OR SUM(total_amt_usd) > 500000 THEN 'middle'
         ELSE 'low' END AS top_sales
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY 1
ORDER BY 3 DESC

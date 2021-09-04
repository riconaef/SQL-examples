--Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
SELECT t3.rep_name, t3.region_name, t3.sum_usd
FROM(SELECT region_name, MAX(sum_usd) sum_usd
   FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) sum_usd
            FROM orders o
            JOIN accounts a
            ON o.account_id = a.id
            JOIN sales_reps s
            ON a.sales_rep_id = s.id
            JOIN region r
            ON s.region_id = r.id
            GROUP BY 1, 2) t1
        GROUP BY 1) t2
JOIN(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) sum_usd
      FROM orders o
      JOIN accounts a
      ON o.account_id = a.id
      JOIN sales_reps s
      ON a.sales_rep_id = s.id
      JOIN region r
      ON s.region_id = r.id
      GROUP BY 1, 2) t3
ON t3.region_name = t2.region_name AND t3.sum_usd = t2.sum_usd

-- For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
SELECT r.name region_name, COUNT(o.total) num_total_orders
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY 1
HAVING SUM(o.total_amt_usd) = (
    SELECT MAX(sum_usd)
    FROM(SELECT r.name region_name, SUM(o.total_amt_usd) sum_usd
                FROM orders o
                JOIN accounts a
                ON o.account_id = a.id
                JOIN sales_reps s
                ON a.sales_rep_id = s.id
                JOIN region r
                ON s.region_id = r.id
                GROUP BY 1) t1)

-- How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?
SELECT a.name
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total) > (SELECT total
                  FROM (SELECT a.name account_name, SUM(o.standard_qty) purch_sta_qty, SUM(o.total) total
                       FROM accounts a
                       JOIN orders o
                       ON a.id = o.account_id
                       GROUP BY 1
                       ORDER BY 2 DESC
                       LIMIT 1) t1);

--For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
SELECT a.name, w.channel, COUNT(*)
FROM web_events w
JOIN accounts a
ON a.id = w.account_id AND a.id = (SELECT id
                 FROM(SELECT a.id, a.name account_name, SUM(o.total_amt_usd) total_spent
                      FROM accounts a
                      JOIN orders o
                      ON a.id = o.account_id
                      GROUP BY 1, 2
                      ORDER BY 3 DESC
                      LIMIT 1) t1 )
GROUP BY 1, 2
ORDER BY 3 DESC

--What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
SELECT AVG(tot_spent)
FROM (SELECT a.name acc_name, SUM(total_amt_usd) tot_spent
      FROM accounts a
      JOIN orders o
      ON a.id = o.account_id
      GROUP BY 1
      ORDER BY 2 DESC
      LIMIT 10) t1

--What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.
SELECT AVG(tot_spent)
FROM(
    SELECT a.name acc_name, AVG(o.total_amt_usd) tot_spent
    FROM accounts a
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY 1
    HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_spent
                                   FROM orders o)) t1

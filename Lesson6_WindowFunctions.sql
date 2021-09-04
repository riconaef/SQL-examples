SELECT standard_amt_usd,
       SUM(standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
FROM orders


SELECT  standard_amt_usd,
        DATE_TRUNC('year', occurred_at),
        SUM(standard_amt_usd) OVER (PARTITION BY (DATE_TRUNC('year', occurred_at)) ORDER BY occurred_at) AS running_total
FROM orders



--Select the id, account_id, and total variable from the orders table,
--then create a column called total_rank that ranks this total amount
--of paper ordered (from highest to lowest) for each account using a
--partition. Your final table should have these four columns.
SELECT id, account_id, total,
RANK() OVER (PARTITION BY account_id ORDER BY total DESC) AS total_rank
FROM orders

--LAG and LEAD function
SELECT occurred_at,
       total_amt,
       LEAD(total_amt) OVER (ORDER BY occurred_at) AS lead,
       LEAD(total_amt) OVER (ORDER BY occurred_at) - total_amt AS lead_difference
FROM (
SELECT occurred_at,
       SUM(total_amt_usd) AS total_amt
  FROM orders
 GROUP BY 1
 ) sub

SELECT RIGHT(website, 3) AS type, COUNT(*) num
FROM accounts
GROUP BY 1
ORDER BY 2 DESC


SELECT LEFT(name, 1) AS first, COUNT(*) num
FROM accounts
GROUP BY 1
ORDER BY 2 DESC

SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('1','2','3','4','5','6','7','8','9','0')
            THEN 1 ELSE 0 END AS num,
      CASE WHEN LEFT(UPPER(name), 1) IN ('1','2','3','4','5','6','7','8','9','0')
            THEN 0 ELSE 1 END AS letter
FROM accounts

SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ')) AS first,
         RIGHT(primary_poc, LENGTH(primary_poc)-STRPOS(primary_poc, ' ')) AS seconde
FROM accounts;


SELECT LEFT(name, STRPOS(name, ' ')-1) AS first_name,
RIGHT(name, LENGTH(name)-STRPOS(name, ' ')) AS seconde
FROM sales_reps

--The email address should be the first name of the primary_poc .
--last name primary_poc @ company name .com.
SELECT CONCAT(LEFT(primary_poc, STRPOS(primary_poc, ' ')-1),'.',
          RIGHT(primary_poc, LENGTH(primary_poc)-STRPOS(primary_poc, ' ')),
          '@', LOWER(name), '.com') AS email
FROM accounts;

--alternatively
WITH t1 AS (SELECT name, LEFT(primary_poc, STRPOS(primary_poc, ' ')-1) AS first,
         RIGHT(primary_poc, LENGTH(primary_poc)-STRPOS(primary_poc, ' ')) AS seconde
FROM accounts)
SELECT first, seconde, CONCAT(first, '.', seconde, '@', LOWER(name), '.com')
FROM t1;

--With replacing the spaces in the company name
WITH t1 AS (SELECT name, LEFT(primary_poc, STRPOS(primary_poc, ' ')-1) AS first,
         RIGHT(primary_poc, LENGTH(primary_poc)-STRPOS(primary_poc, ' ')) AS seconde
FROM accounts)
SELECT first, seconde, CONCAT(first, '.', seconde, '@', LOWER(REPLACE(name, ' ', '')), '.com') AS email
FROM t1;

--create a password
WITH t1 AS (SELECT name, LEFT(primary_poc, STRPOS(primary_poc, ' ')-1) AS first,
         RIGHT(primary_poc, LENGTH(primary_poc)-STRPOS(primary_poc, ' ')) AS seconde
FROM accounts)
SELECT first, seconde, CONCAT(first, '.', seconde, '@', LOWER(REPLACE(name, ' ', '')), '.com') AS email,
       CONCAT(LOWER(LEFT(first,1)), LOWER(RIGHT(first,1)), LOWER(LEFT(seconde,1)), LOWER(RIGHT(seconde,1)), LENGTH(first), LENGTH(seconde), UPPER(REPLACE(name, ' ', '')))
FROM t1;

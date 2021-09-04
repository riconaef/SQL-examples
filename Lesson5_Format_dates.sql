SELECT date original_date,
	   (SUBSTR(date,7,4) || '-' ||
	   SUBSTR(date,0,3) || '-' ||
       SUBSTR(date,4,2)):: date AS date_formatted
FROM sf_crime_data




COALESCE(o.id, a.id) filled_id,
a.name, a.website, a.lat, a.long,
a.primary_poc, a.sales_rep_id,
COALESCE(o.account_id = a.id) filled_o_id,
o.occurred_at,
COALESCE(o.standard_qty, 0),
COALESCE(o.gloss_qty, 0),
COALESCE(o.total, 0),
COALESCE(o.standard_amt_usd, 0),
COALESCE(o.gloss_amt_usd, 0),
COALESCE(o.poster_amt_usd, 0),
COALESCE(o.total_amt_usd,0),

WITH src AS (
  SELECT * FROM {{ ref('raw_campaigns') }}
)
SELECT
  campaign_id::number        AS campaign_id,
  campaign_name::string      AS campaign_name,
  lower(channel)::string     AS channel,
  to_date(start_date)        AS start_date,
  to_date(end_date)          AS end_date,
  spend::number(12,2)        AS spend
FROM src
QUALIFY ROW_NUMBER() OVER (PARTITION BY campaign_id ORDER BY start_date DESC) = 1;

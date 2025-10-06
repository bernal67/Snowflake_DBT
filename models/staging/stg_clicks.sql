WITH src AS (
  SELECT * FROM {{ ref('raw_clicks') }}
)
SELECT
  click_id::number           AS click_id,
  campaign_id::number        AS campaign_id,
  to_timestamp(click_ts)     AS click_ts,
  cost_per_click::number(12,4) AS cost_per_click
FROM src
QUALIFY ROW_NUMBER() OVER (PARTITION BY click_id ORDER BY click_ts DESC) = 1;

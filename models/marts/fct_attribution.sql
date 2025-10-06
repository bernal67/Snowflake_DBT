WITH clicks AS (
  SELECT * FROM {{ ref('stg_clicks') }}
),
conversions AS (
  SELECT * FROM {{ ref('stg_conversions') }}
)
SELECT
  conv.conv_id,
  clk.click_id,
  clk.campaign_id,
  clk.click_ts,
  conv.conversion_ts,
  DATEDIFF('second', clk.click_ts, conv.conversion_ts) AS seconds_to_convert,
  conv.amount
FROM conversions conv
JOIN clicks clk
  ON conv.click_id = clk.click_id;

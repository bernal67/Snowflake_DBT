WITH fact AS (
  SELECT * FROM {{ ref('fct_attribution') }}
),
clicks AS (
  SELECT campaign_id, DATE(click_ts) AS d, COUNT(*) AS clicks, SUM(cost_per_click) AS click_cost
  FROM {{ ref('stg_clicks') }}
  GROUP BY 1,2
),
conv AS (
  SELECT campaign_id, DATE(conversion_ts) AS d, COUNT(*) AS conversions, SUM(amount) AS revenue
  FROM fact
  GROUP BY 1,2
)
SELECT
  COALESCE(c.campaign_id, v.campaign_id)     AS campaign_id,
  COALESCE(c.d, v.d)                          AS day,
  c.clicks, v.conversions,
  c.click_cost, v.revenue,
  CASE WHEN NULLIF(c.clicks,0) IS NULL THEN NULL ELSE v.conversions / NULLIF(c.clicks,0) END AS conv_per_click,
  CASE WHEN NULLIF(c.clicks,0) IS NULL THEN NULL ELSE c.click_cost / NULLIF(c.clicks,0) END   AS cpc,
  CASE WHEN NULLIF(v.conversions,0) IS NULL THEN NULL ELSE c.click_cost / NULLIF(v.conversions,0) END AS cpa,
  CASE WHEN NULLIF(c.click_cost,0) IS NULL THEN NULL ELSE (v.revenue - c.click_cost) / NULLIF(c.click_cost,0) END AS roi
FROM clicks c
FULL OUTER JOIN conv v
  ON c.campaign_id = v.campaign_id AND c.d = v.d
ORDER BY day, campaign_id;

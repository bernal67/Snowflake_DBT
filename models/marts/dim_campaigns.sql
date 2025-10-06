SELECT
  campaign_id,
  campaign_name,
  channel,
  start_date,
  end_date,
  spend
FROM {{ ref('stg_campaigns') }};

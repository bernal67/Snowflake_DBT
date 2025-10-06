WITH src AS (
  SELECT * FROM {{ ref('raw_conversions') }}
)
SELECT
  conv_id::number            AS conv_id,
  click_id::number           AS click_id,
  to_timestamp(conversion_ts) AS conversion_ts,
  amount::number(12,2)       AS amount
FROM src
QUALIFY ROW_NUMBER() OVER (PARTITION BY conv_id ORDER BY conversion_ts DESC) = 1;

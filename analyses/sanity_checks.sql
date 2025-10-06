-- Row counts & date sanity
SELECT 'clicks rows' AS metric, COUNT(*) FROM {{ ref('stg_clicks') }};
SELECT 'conversions rows' AS metric, COUNT(*) FROM {{ ref('stg_conversions') }};
SELECT 'future conversions' AS metric, COUNT(*)
FROM {{ ref('stg_conversions') }}
WHERE conversion_ts > CURRENT_TIMESTAMP();

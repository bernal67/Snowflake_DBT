# Snowflake + dbt: Marketing Analytics

A minimal **dbt** project modeling marketing data (campaigns, clicks, conversions) in **Snowflake**.  
Includes **seeds**, **staging models**, **marts**, basic **tests**, and a **KPI table** for reporting (ROI, CTR, CPC, CPA).

## 🔧 Stack
- Snowflake (warehouse/db/schema)
- dbt-core / dbt-snowflake

## 🚀 Quickstart
1. Install dbt & set your `profiles.yml` from `profiles_example.yml`.
2. Load seeds:
   ```bash
   dbt seed
   ```
3. Run models + tests:
   ```bash
   dbt run
   dbt test
   ```
4. Generate docs:
   ```bash
   dbt docs generate && dbt docs serve
   ```

## 🧱 Model Layers
- **staging/**: clean column names, types, and dedupe
- **marts/**:
  - `dim_campaigns`: campaign dims w/ spend & date ranges
  - `fct_attribution`: join clicks→conversions (last-touch)
  - `kpi_marketing`: ROI/CTR/CPC/CPA by day and campaign

## 📊 Reporting
Point BI (Power BI/Tableau) to `marts.kpi_marketing`.

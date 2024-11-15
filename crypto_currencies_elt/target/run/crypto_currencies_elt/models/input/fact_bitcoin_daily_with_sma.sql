
  create or replace   view dev.analytics.fact_bitcoin_daily_with_sma
  
   as (
    WITH base AS (
    SELECT
        symbol,
        date,
        price_close,
        volume_traded,
        trades_count
    FROM dev.analytics.stg_bitcoin_price
)
, moving_avg AS (
    SELECT
        symbol,
        date,
        price_close,
        volume_traded,
        trades_count,
        AVG(price_close) OVER(PARTITION BY symbol ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS sma_7d
    FROM base
)
SELECT * FROM moving_avg
  );


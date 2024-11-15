
  create or replace   view dev.analytics.fact_bitcoin_daily_with_rsi
  
   as (
    WITH base AS (
    SELECT
        symbol,
        date,
        price_close,
        price_close - LAG(price_close) OVER(PARTITION BY symbol ORDER BY date) AS price_change
    FROM dev.analytics.stg_bitcoin_price
)
, gains_losses AS (
    SELECT
        symbol,
        date,
        price_close,
        CASE WHEN price_change > 0 THEN price_change ELSE 0 END AS gain,
        CASE WHEN price_change < 0 THEN ABS(price_change) ELSE 0 END AS loss
    FROM base
)
, avg_gain_loss AS (
    SELECT
        symbol,
        date,
        price_close,
        AVG(gain) OVER(PARTITION BY symbol ORDER BY date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) AS avg_gain_14d,
        AVG(loss) OVER(PARTITION BY symbol ORDER BY date ROWS BETWEEN 13 PRECEDING AND CURRENT ROW) AS avg_loss_14d
    FROM gains_losses
)
SELECT
    symbol,
    date,
    price_close,
    avg_gain_14d,
    avg_loss_14d,
    CASE WHEN avg_loss_14d = 0 THEN 100
         ELSE 100 - (100 / (1 + (avg_gain_14d / avg_loss_14d))) 
    END AS rsi_14d
FROM avg_gain_loss
  );


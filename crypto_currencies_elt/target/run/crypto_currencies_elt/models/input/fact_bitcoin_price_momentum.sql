
  create or replace   view dev.analytics.fact_bitcoin_price_momentum
  
   as (
    WITH base AS (
    SELECT
        symbol,
        date,
        price_close,
        LAG(price_close, 14) OVER(PARTITION BY symbol ORDER BY date) AS price_close_14d_ago
    FROM dev.analytics.stg_bitcoin_price
)
, momentum_calc AS (
    SELECT
        symbol,
        date,
        price_close,
        price_close_14d_ago,
        -- Calculate the price momentum as percentage change over 14 days
        CASE 
            WHEN price_close_14d_ago IS NULL THEN NULL
            ELSE ((price_close - price_close_14d_ago) / price_close_14d_ago) * 100
        END AS price_momentum_14d
    FROM base
)
SELECT
    symbol,
    date,
    price_close,
    price_momentum_14d
FROM momentum_calc
ORDER BY symbol, date
  );


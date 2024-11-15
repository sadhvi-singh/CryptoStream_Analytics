
  
    

        create or replace transient table dev.analytics.crypto_price_momentum
         as
        (WITH base AS (
    SELECT
        symbol,
        date,
        price_close,
        LAG(price_close, 7) OVER(PARTITION BY symbol ORDER BY date) AS price_close_7d_ago
    FROM dev.analytics.stg_bitcoin_price
),
momentum_calc AS (
    SELECT
        symbol,
        date,
        price_close,
        price_close_7d_ago,
        -- Calculate price momentum as percentage change over 7 days
        CASE 
            WHEN price_close_7d_ago IS NULL THEN NULL
            ELSE ((price_close - price_close_7d_ago) / price_close_7d_ago) * 100
        END AS price_momentum_7d
    FROM base
),
momentum_classification AS (
    SELECT
        symbol,
        date,
        price_close,
        price_close_7d_ago,
        price_momentum_7d,
        -- Classify the momentum as Positive, Negative, or Neutral
        CASE 
            WHEN price_momentum_7d > 0 THEN 'Positive'
            WHEN price_momentum_7d < 0 THEN 'Negative'
            ELSE 'Neutral'
        END AS momentum_direction
    FROM momentum_calc
)

-- Final output with context columns
SELECT
    symbol,
    date,
    price_close,
    price_close_7d_ago,
    price_momentum_7d,
    momentum_direction
FROM momentum_classification
ORDER BY symbol, date
        );
      
  
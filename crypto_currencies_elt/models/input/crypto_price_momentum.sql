WITH base AS (
    SELECT
        symbol,
        date,
        price_close,
        COALESCE(LAG(price_close, 7) OVER(PARTITION BY symbol ORDER BY date),0) AS price_close_7d_ago
    FROM {{ ref('crypto_staging') }}
),
momentum_calc AS (
    SELECT
        symbol,
        date,
        price_close,
        price_close_7d_ago,       
        CASE 
            WHEN price_close_7d_ago = 0 THEN 0
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
        CASE 
            WHEN price_momentum_7d > 0 THEN 'Overbought'
            WHEN price_momentum_7d < 0 THEN 'Oversold'
            ELSE 'Neutral'
        END AS momentum_direction
    FROM momentum_calc
)

SELECT
    symbol,
    date,
    price_close,
    COALESCE(price_close_7d_ago, 0) as price_close_7d_ago,
    COALESCE(price_momentum_7d, 0) as price_momentum_7d,
    momentum_direction
FROM momentum_classification
ORDER BY symbol, date


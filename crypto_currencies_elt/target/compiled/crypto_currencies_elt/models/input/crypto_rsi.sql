WITH base AS (
    SELECT
        symbol,
        date,
        price_close,
        price_close - LAG(price_close) OVER(PARTITION BY symbol ORDER BY date) AS price_change
    FROM dev.analytics.crypto_staging
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
        AVG(gain) OVER(PARTITION BY symbol ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS avg_gain_7d,
        AVG(loss) OVER(PARTITION BY symbol ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS avg_loss_7d
    FROM gains_losses
)
SELECT
    symbol,
    date,
    price_close,
    avg_gain_7d,
    avg_loss_7d,
    CASE WHEN avg_loss_7d = 0 THEN 100
         ELSE 100 - (100 / (1 + (avg_gain_7d / avg_loss_7d))) 
    END AS rsi_7d
FROM avg_gain_loss
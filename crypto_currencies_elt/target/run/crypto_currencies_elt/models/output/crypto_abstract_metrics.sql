
  
    

        create or replace transient table dev.analytics.crypto_abstract_metrics
         as
        (WITH sma AS (
    SELECT
        symbol,
        date,
        sma_7d,
        price_close,
        volume_traded,
        trades_count
    FROM dev.analytics.crypto_sma
),

rsi AS (
    SELECT
        symbol,
        date,
        rsi_7d
    FROM dev.analytics.crypto_rsi
),

crypto_price_momentum AS (
    SELECT
        symbol,
        date,
        price_close,
        price_momentum_7d, 
        momentum_direction
    FROM dev.analytics.crypto_price_momentum
)

SELECT
    sma.symbol,
    sma.date,
    sma.price_close,
    sma.sma_7d,
    rsi.rsi_7d,
    sma.volume_traded,
    sma.trades_count,
    crypto_price_momentum. price_momentum_7d,
    crypto_price_momentum.momentum_direction
FROM sma
JOIN rsi ON sma.symbol = rsi.symbol AND sma.date = rsi.date
JOIN crypto_price_momentum ON sma.symbol = crypto_price_momentum.symbol AND sma.date = crypto_price_momentum.date
ORDER BY sma.symbol, sma.date
        );
      
  
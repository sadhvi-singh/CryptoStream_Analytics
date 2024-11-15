
  create or replace   view dev.analytics.stg_bitcoin_price
  
   as (
    WITH stg_bitcoin_price AS (
    SELECT 
        symbol,
        date,
        CAST(price_open AS DECIMAL(10, 3)) AS price_open,
        CAST(price_high AS DECIMAL(10, 3)) AS price_high,
        CAST(price_low AS DECIMAL(10, 3)) AS price_low,
        CAST(price_close AS DECIMAL(10, 3)) AS price_close,
        volume_traded,
        trades_count
    FROM dev.raw_data.crypto_currencies
)
SELECT * FROM stg_bitcoin_price
  );


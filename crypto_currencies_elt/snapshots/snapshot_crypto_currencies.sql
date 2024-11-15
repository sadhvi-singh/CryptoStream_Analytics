{% snapshot snapshot_crypto_currencies %}

{{
    config(
      target_schema='snapshot',
      unique_key='id',
      strategy='timestamp',
      updated_at='date',
      invalidate_hard_deletes=True
    )
}}

WITH source_data AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['symbol', 'date']) }} as id,
        symbol,
        date,
        price_open,
        price_high,
        price_low,
        price_close,
        volume_traded,
	trades_count
    FROM {{ source('raw_data', 'crypto_currencies') }}
)

SELECT * FROM source_data

{% endsnapshot %}
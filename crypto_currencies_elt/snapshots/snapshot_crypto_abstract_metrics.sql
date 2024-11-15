{% snapshot snapshot_crypto_abstract_metrics %}

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
        price_close,
        sma_7d,
        rsi_7d,
        volume_traded,
        trades_count,
        price_momentum_7d,
        momentum_direction
    FROM {{ ref('crypto_abstract_metrics') }}
)

SELECT * FROM source_data

{% endsnapshot %}
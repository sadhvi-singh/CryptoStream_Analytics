select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

with all_values as (

    select
        price_momentum_7d as value_field,
        count(*) as n_records

    from dev.analytics.crypto_abstract_metrics
    group by price_momentum_7d

)

select *
from all_values
where value_field not in (
    'Overbought','Oversold','Neutral'
)



      
    ) dbt_internal_test
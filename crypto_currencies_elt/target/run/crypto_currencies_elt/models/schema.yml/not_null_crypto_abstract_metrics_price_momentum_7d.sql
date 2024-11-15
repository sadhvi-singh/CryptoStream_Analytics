select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select price_momentum_7d
from dev.analytics.crypto_abstract_metrics
where price_momentum_7d is null



      
    ) dbt_internal_test
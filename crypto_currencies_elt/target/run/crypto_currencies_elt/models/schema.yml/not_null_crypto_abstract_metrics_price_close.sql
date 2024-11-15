select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select price_close
from dev.analytics.crypto_abstract_metrics
where price_close is null



      
    ) dbt_internal_test
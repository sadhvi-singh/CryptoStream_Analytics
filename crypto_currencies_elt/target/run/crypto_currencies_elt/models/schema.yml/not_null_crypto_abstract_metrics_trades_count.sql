select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select trades_count
from dev.analytics.crypto_abstract_metrics
where trades_count is null



      
    ) dbt_internal_test
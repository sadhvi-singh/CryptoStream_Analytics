select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select volume_traded
from dev.analytics.crypto_abstract_metrics
where volume_traded is null



      
    ) dbt_internal_test
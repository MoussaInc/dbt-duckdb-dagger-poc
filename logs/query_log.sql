-- created_at: 2026-09-10T19:41:08.699943074+00:00
-- finished_at: 2026-09-10T19:41:08.704043705+00:00
-- elapsed: 4ms
-- outcome: success
-- dialect: duckdb
-- node_id: test.dagger_test.not_null_mart_customer_revenue_customer_id.f463684890
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.dagger_test.not_null_mart_customer_revenue_customer_id.f463684890", "profile_name": "dagger_test", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select customer_id
from "dev"."main"."mart_customer_revenue"
where customer_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-09-10T19:41:08.701150756+00:00
-- finished_at: 2026-09-10T19:41:08.704216604+00:00
-- elapsed: 3ms
-- outcome: success
-- dialect: duckdb
-- node_id: test.dagger_test.not_null_mart_customer_revenue_total_revenue.fc426a5091
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.dagger_test.not_null_mart_customer_revenue_total_revenue.fc426a5091", "profile_name": "dagger_test", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select total_revenue
from "dev"."main"."mart_customer_revenue"
where total_revenue is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-09-10T19:41:08.700908154+00:00
-- finished_at: 2026-09-10T19:41:08.704717238+00:00
-- elapsed: 3ms
-- outcome: success
-- dialect: duckdb
-- node_id: test.dagger_test.not_null_stg_orders_order_id.81cfe2fe64
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.dagger_test.not_null_stg_orders_order_id.81cfe2fe64", "profile_name": "dagger_test", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select order_id
from "dev"."main"."stg_orders"
where order_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-09-10T19:41:08.701189916+00:00
-- finished_at: 2026-09-10T19:41:08.705743539+00:00
-- elapsed: 4ms
-- outcome: success
-- dialect: duckdb
-- node_id: test.dagger_test.accepted_values_stg_orders_status__completed__cancelled__pending.ee383a7b32
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.dagger_test.accepted_values_stg_orders_status__completed__cancelled__pending.ee383a7b32", "profile_name": "dagger_test", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

with all_values as (

    select
        status as value_field,
        count(*) as n_records

    from "dev"."main"."stg_orders"
    group by status

)

select *
from all_values
where value_field not in (
    'completed','cancelled','pending'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-09-10T19:41:08.699943074+00:00
-- finished_at: 2026-09-10T19:41:08.704828332+00:00
-- elapsed: 4ms
-- outcome: success
-- dialect: duckdb
-- node_id: test.dagger_test.unique_stg_orders_order_id.e3b841c71a
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.dagger_test.unique_stg_orders_order_id.e3b841c71a", "profile_name": "dagger_test", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    order_id as unique_field,
    count(*) as n_records

from "dev"."main"."stg_orders"
where order_id is not null
group by order_id
having count(*) > 1



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-09-10T19:41:08.700908138+00:00
-- finished_at: 2026-09-10T19:41:08.705486116+00:00
-- elapsed: 4ms
-- outcome: success
-- dialect: duckdb
-- node_id: test.dagger_test.not_null_stg_orders_customer_id.af79d5e4b5
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.dagger_test.not_null_stg_orders_customer_id.af79d5e4b5", "profile_name": "dagger_test", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select customer_id
from "dev"."main"."stg_orders"
where customer_id is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-09-10T19:41:08.699943079+00:00
-- finished_at: 2026-09-10T19:41:08.705494004+00:00
-- elapsed: 5ms
-- outcome: success
-- dialect: duckdb
-- node_id: test.dagger_test.unique_mart_customer_revenue_customer_id.97da55bad4
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.dagger_test.unique_mart_customer_revenue_customer_id.97da55bad4", "profile_name": "dagger_test", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    customer_id as unique_field,
    count(*) as n_records

from "dev"."main"."mart_customer_revenue"
where customer_id is not null
group by customer_id
having count(*) > 1



  
  
      
    ) dbt_internal_test;

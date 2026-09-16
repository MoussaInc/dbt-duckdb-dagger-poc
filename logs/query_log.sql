-- created_at: 2026-09-16T20:28:29.373581203+00:00
-- finished_at: 2026-09-16T20:28:29.377463986+00:00
-- elapsed: 3ms
-- outcome: success
-- dialect: duckdb
-- node_id: not available
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "dagger_test", "target_name": "dev"} */

    
    select schema_name
    from system.information_schema.schemata
    
    where lower(catalog_name) = '"dev"'
    
  
  ;
-- created_at: 2026-09-16T20:28:29.378679711+00:00
-- finished_at: 2026-09-16T20:28:29.380183156+00:00
-- elapsed: 1ms
-- outcome: success
-- dialect: duckdb
-- node_id: not available
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "dagger_test", "target_name": "dev"} */

    
        select type from duckdb_databases()
        where lower(database_name)='dev'
        and type='sqlite'
    
  ;
-- created_at: 2026-09-16T20:28:29.380751530+00:00
-- finished_at: 2026-09-16T20:28:29.381632265+00:00
-- elapsed: 880us
-- outcome: success
-- dialect: duckdb
-- node_id: not available
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "connection_name": "", "dbt_version": "2.0.0", "profile_name": "dagger_test", "target_name": "dev"} */

    
    
        create schema if not exists "dev"."main"
    ;
-- created_at: 2026-09-16T20:28:29.385903914+00:00
-- finished_at: 2026-09-16T20:28:29.421102958+00:00
-- elapsed: 35ms
-- outcome: success
-- dialect: duckdb
-- node_id: seed.dagger_test.raw_orders
-- query_id: not available
-- desc: get_relation > list_relations call
SELECT table_catalog, table_schema, table_name, table_type FROM information_schema.tables WHERE table_schema = 'main';
-- created_at: 2026-09-16T20:28:29.427606833+00:00
-- finished_at: 2026-09-16T20:28:29.431919660+00:00
-- elapsed: 4ms
-- outcome: success
-- dialect: duckdb
-- node_id: seed.dagger_test.raw_orders
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "seed.dagger_test.raw_orders", "profile_name": "dagger_test", "target_name": "dev"} */
truncate table "dev"."main"."raw_orders";
-- created_at: 2026-09-16T20:28:29.437734888+00:00
-- finished_at: 2026-09-16T20:28:29.453003617+00:00
-- elapsed: 15ms
-- outcome: success
-- dialect: duckdb
-- node_id: seed.dagger_test.raw_orders
-- query_id: not available
-- desc: add_query adapter call

          COPY "dev"."main"."raw_orders" FROM '/home/mballo/Projets/dagger_test/seeds/raw_orders.csv' (FORMAT CSV, HEADER TRUE, DELIMITER ',')
        ;
-- created_at: 2026-09-16T20:28:29.482336612+00:00
-- finished_at: 2026-09-16T20:28:29.490226792+00:00
-- elapsed: 7ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.stg_orders
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.stg_orders", "profile_name": "dagger_test", "target_name": "dev"} */

  
  create view "dev"."main"."stg_orders__dbt_tmp" as (
    select
    order_id,
    customer_id,
    order_date,
    amount,
    status
from "dev"."main"."raw_orders"
  );
;
-- created_at: 2026-09-16T20:28:29.496474124+00:00
-- finished_at: 2026-09-16T20:28:29.501425554+00:00
-- elapsed: 4ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.stg_orders
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.stg_orders", "profile_name": "dagger_test", "target_name": "dev"} */

      alter view "dev"."main"."stg_orders" rename to "stg_orders__dbt_backup"
    ;
-- created_at: 2026-09-16T20:28:29.510722561+00:00
-- finished_at: 2026-09-16T20:28:29.515279015+00:00
-- elapsed: 4ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.stg_orders
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.stg_orders", "profile_name": "dagger_test", "target_name": "dev"} */

      alter view "dev"."main"."stg_orders__dbt_tmp" rename to "stg_orders"
    ;
-- created_at: 2026-09-16T20:28:29.529280704+00:00
-- finished_at: 2026-09-16T20:28:29.533342968+00:00
-- elapsed: 4ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.stg_orders
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.stg_orders", "profile_name": "dagger_test", "target_name": "dev"} */

      drop view if exists "dev"."main"."stg_orders__dbt_backup" cascade
    ;
-- created_at: 2026-09-16T20:28:29.577239208+00:00
-- finished_at: 2026-09-16T20:28:29.583711485+00:00
-- elapsed: 6ms
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
-- created_at: 2026-09-16T20:28:29.579825706+00:00
-- finished_at: 2026-09-16T20:28:29.585468547+00:00
-- elapsed: 5ms
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
-- created_at: 2026-09-16T20:28:29.593338116+00:00
-- finished_at: 2026-09-16T20:28:29.597033034+00:00
-- elapsed: 3ms
-- outcome: success
-- dialect: duckdb
-- node_id: test.dagger_test.accepted_values_stg_orders_status__completed__cancelled__pending__error.8b16e045ff
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.dagger_test.accepted_values_stg_orders_status__completed__cancelled__pending__error.8b16e045ff", "profile_name": "dagger_test", "target_name": "dev"} */

    
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
    'completed','cancelled','pending','error'
)



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-09-16T20:28:29.593324889+00:00
-- finished_at: 2026-09-16T20:28:29.597032783+00:00
-- elapsed: 3ms
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
-- created_at: 2026-09-16T20:28:29.607186849+00:00
-- finished_at: 2026-09-16T20:28:29.609955291+00:00
-- elapsed: 2ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.int_customer_revenue
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.int_customer_revenue", "profile_name": "dagger_test", "target_name": "dev"} */

  
  create view "dev"."main"."int_customer_revenue__dbt_tmp" as (
    select
    order_id,
    customer_id,
    order_date,
    amount,
    sum(amount) over (partition by customer_id order by order_date) as cumulative_revenue,
    status
from "dev"."main"."stg_orders"
  );
;
-- created_at: 2026-09-16T20:28:29.612785069+00:00
-- finished_at: 2026-09-16T20:28:29.614837192+00:00
-- elapsed: 2ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.int_customer_revenue
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.int_customer_revenue", "profile_name": "dagger_test", "target_name": "dev"} */

      alter view "dev"."main"."int_customer_revenue" rename to "int_customer_revenue__dbt_backup"
    ;
-- created_at: 2026-09-16T20:28:29.617777208+00:00
-- finished_at: 2026-09-16T20:28:29.620279754+00:00
-- elapsed: 2ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.int_customer_revenue
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.int_customer_revenue", "profile_name": "dagger_test", "target_name": "dev"} */

      alter view "dev"."main"."int_customer_revenue__dbt_tmp" rename to "int_customer_revenue"
    ;
-- created_at: 2026-09-16T20:28:29.624086840+00:00
-- finished_at: 2026-09-16T20:28:29.625936852+00:00
-- elapsed: 1ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.int_customer_revenue
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.int_customer_revenue", "profile_name": "dagger_test", "target_name": "dev"} */

      drop view if exists "dev"."main"."int_customer_revenue__dbt_backup" cascade
    ;
-- created_at: 2026-09-16T20:28:29.637817162+00:00
-- finished_at: 2026-09-16T20:28:29.651034473+00:00
-- elapsed: 13ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.mart_customer_revenue
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.mart_customer_revenue", "profile_name": "dagger_test", "target_name": "dev"} */

  
    
    

    create  table
      "dev"."main"."mart_customer_revenue__dbt_tmp"
  
    as (
      select
    customer_id,
    count(*) as nb_orders,
    max(cumulative_revenue) as max_revenue
from "dev"."main"."int_customer_revenue"
where status = 'completed'
group by customer_id
    );
  
  ;
-- created_at: 2026-09-16T20:28:29.654784775+00:00
-- finished_at: 2026-09-16T20:28:29.657160206+00:00
-- elapsed: 2ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.mart_customer_revenue
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.mart_customer_revenue", "profile_name": "dagger_test", "target_name": "dev"} */

    SELECT index_name
    FROM duckdb_indexes()
    WHERE schema_name = 'main'
      AND table_name = 'mart_customer_revenue'
  ;
-- created_at: 2026-09-16T20:28:29.660327238+00:00
-- finished_at: 2026-09-16T20:28:29.663417477+00:00
-- elapsed: 3ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.mart_customer_revenue
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.mart_customer_revenue", "profile_name": "dagger_test", "target_name": "dev"} */

    SELECT COUNT(*) as remaining_indexes
    FROM duckdb_indexes()
    WHERE schema_name = 'main'
      AND table_name = 'mart_customer_revenue'
  ;
-- created_at: 2026-09-16T20:28:29.668083068+00:00
-- finished_at: 2026-09-16T20:28:29.671578109+00:00
-- elapsed: 3ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.mart_customer_revenue
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.mart_customer_revenue", "profile_name": "dagger_test", "target_name": "dev"} */

      alter table "dev"."main"."mart_customer_revenue" rename to "mart_customer_revenue__dbt_backup"
    ;
-- created_at: 2026-09-16T20:28:29.676037295+00:00
-- finished_at: 2026-09-16T20:28:29.680417805+00:00
-- elapsed: 4ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.mart_customer_revenue
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.mart_customer_revenue", "profile_name": "dagger_test", "target_name": "dev"} */

      alter table "dev"."main"."mart_customer_revenue__dbt_tmp" rename to "mart_customer_revenue"
    ;
-- created_at: 2026-09-16T20:28:29.688411231+00:00
-- finished_at: 2026-09-16T20:28:29.691079883+00:00
-- elapsed: 2ms
-- outcome: success
-- dialect: duckdb
-- node_id: model.dagger_test.mart_customer_revenue
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "model.dagger_test.mart_customer_revenue", "profile_name": "dagger_test", "target_name": "dev"} */

      drop table if exists "dev"."main"."mart_customer_revenue__dbt_backup" cascade
    ;
-- created_at: 2026-09-16T20:28:29.704000461+00:00
-- finished_at: 2026-09-16T20:28:29.705803086+00:00
-- elapsed: 1ms
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
-- created_at: 2026-09-16T20:28:29.712545383+00:00
-- finished_at: 2026-09-16T20:28:29.714453415+00:00
-- elapsed: 1ms
-- outcome: success
-- dialect: duckdb
-- node_id: test.dagger_test.not_null_mart_customer_revenue_max_revenue.339a0e070d
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.dagger_test.not_null_mart_customer_revenue_max_revenue.339a0e070d", "profile_name": "dagger_test", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select max_revenue
from "dev"."main"."mart_customer_revenue"
where max_revenue is null



  
  
      
    ) dbt_internal_test;
-- created_at: 2026-09-16T20:28:29.712517357+00:00
-- finished_at: 2026-09-16T20:28:29.715337576+00:00
-- elapsed: 2ms
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
-- created_at: 2026-09-16T20:28:29.713168255+00:00
-- finished_at: 2026-09-16T20:28:29.715337647+00:00
-- elapsed: 2ms
-- outcome: success
-- dialect: duckdb
-- node_id: test.dagger_test.dbt_utils_expression_is_true_mart_customer_revenue_max_revenue___0.95f33364b4
-- query_id: not available
-- desc: execute adapter call
/* {"app": "dbt", "dbt_version": "2.0.0", "node_id": "test.dagger_test.dbt_utils_expression_is_true_mart_customer_revenue_max_revenue___0.95f33364b4", "profile_name": "dagger_test", "target_name": "dev"} */

    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  



select
    1
from "dev"."main"."mart_customer_revenue"

where not(max_revenue >= 0)


  
  
      
    ) dbt_internal_test;

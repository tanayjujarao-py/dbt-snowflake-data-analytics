{{config(materialized='view')}}

select * from {{ source('source','fct_sales')}}
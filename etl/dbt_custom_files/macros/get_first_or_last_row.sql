{%- macro get_first_or_last_row(source, partition_by, order_by, column_label, get='first' ) -%}

{% set asc_or_desc = 'asc' if get == 'first' else 'desc'  %}

select
    *,
    {% if get == 'both' %}
    row_number() over (partition by {{ partition_by }} order by {{ order_by }} asc) = 1 as first_{{column_label}},
    row_number() over (partition by {{ partition_by }} order by {{ order_by }} desc) = 1 as last_{{column_label}}
    {% else %}
    row_number() over (partition by {{ partition_by }} order by {{ order_by }} {{ asc_or_desc }}) = 1 as {{column_label}}
    {% endif %}
from {{ source }}

{%- endmacro -%}

/*
-- Ref: https://discourse.getdbt.com/t/macro-to-find-first-or-last-row-of-a-group/3498
-- Example Usage:
with orders as (
   select * from {{ ref('stg_shopify__orders') }}
),

first_orders as (
  {{ get_first_or_last_row('orders', 'customer_id', 'processed_at', 'customer_order', get='both') }}
)

select 
  first_customer_order,
  last_customer_order,
  customer_id,
  order_id,
  processed_at
from first_orders order by customer_id, processed_at
*/
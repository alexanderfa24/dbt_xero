{{config(materialized='table')}}

with days as (
    {{dbt.date_spine(
        'day',
        "DATE(2000,01,01)",
        "DATE(2025,01,01)"
    )
    }}
),

final as (
    select cast(date_day as date) as date_day
    from days
)

select *
from final
-- filter the time spine to a specific range
where date_day > DATE_ADD(current_date(), INTERVAL -4 YEAR)
and date_day < DATE_ADD(current_date(), INTERVAL 30 DAY)

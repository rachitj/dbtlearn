{{ config(
    materialized='incremental',
    on_schema_change='fail'
) }}
WITH src_reviews AS (
    SELECT
        *
    FROM
        {{ ref('src_reviews') }}
)
SELECT
    *
FROM
    src_reviews
where review_text is not null

-- Incremental model filter
{% if is_incremental() %}
    AND review_date > (SELECT max(review_date) FROM {{ this }})
{% endif %}

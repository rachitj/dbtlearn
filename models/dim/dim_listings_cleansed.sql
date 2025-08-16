With src_listings AS (
    SELECT
        *
    FROM
        {{ ref('src_listings') }}
)
SELECT
    listing_id,
    listing_name,
    room_type,
    CASE
        WHEN minimum_nights= 0 then 1 
        Else minimum_nights
    END as minimum_nights,
    host_id,
    REPLACE(price_str, '$', '')::NUMBER(10, 2) as price,
    created_at,
    updated_at
FROM
    src_listings

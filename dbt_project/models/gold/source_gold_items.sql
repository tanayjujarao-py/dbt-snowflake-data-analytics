with dedup_query as (
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY id ORDER BY updatedate desc) as deduplication_id
FROM {{ source('source', 'items') }}

) 

SELECT 
    ID,
    NAME,
    CATEGORY,
    UPDATEDATE
FROM dedup_query
WHERE deduplication_id = 1
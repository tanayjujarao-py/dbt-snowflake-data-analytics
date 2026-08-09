WITH sales AS (
    SELECT
        sales_id,
        product_sk,
        customer_sk,
        {{ multiply('unit_price', 'quantity') }} as calculated_gross_amount,
        gross_amount,
        payment_method

    FROM {{ ref('bronze_sales') }}
),

PRODUCTS AS (
    SELECT 
        product_sk,
        category
    FROM {{ ref('bronze_product') }}
),

CUSTOMER AS (
    SELECT 
        CUSTOMER_SK,
        GENDER
    FROM {{ ref('bronze_customers') }} 
),
joined_query as (
    SELECT 
        s.sales_id,
        s.gross_amount,
        s.payment_method,
        p.category,
        c.gender
    FROM SALES S 
    JOIN PRODUCTS P ON S.PRODUCT_SK = P.PRODUCT_SK
    JOIN CUSTOMER C ON S.CUSTOMER_SK = C.CUSTOMER_SK
)

SELECT 
    category,
    gender,
    sum(gross_amount) as total_sales
FROM joined_query
GROUP BY category, gender
ORDER BY TOTAL_SALES DESC
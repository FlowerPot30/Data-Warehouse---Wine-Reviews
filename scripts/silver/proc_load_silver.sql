/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
	This stored procedure performs the ETL process to populate the 'silver' schema tables
	from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and clean data from Bronze into Silver table.

Parameters:
	None (This stored procedure does not accept any parameters or return any values.)

Usage Example: 
	EXEC silver.load_silver;
===============================================================================
*/

/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
	This stored procedure performs the ETL process to populate the 'silver' schema tables
	from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and clean data from Bronze into Silver table.

Parameters:
	None (This stored procedure does not accept any parameters or return any values.)

Usage Example: 
	EXEC silver.load_silver;
===============================================================================
*/

SELECT
    reviews_id,
    CASE 
        WHEN country = 'US' THEN 'united states'
        WHEN country IS NULL OR TRIM(country) = '' THEN 'unknown'
        ELSE LOWER(TRIM(country))
    END AS country,
    NULLIF(TRIM(description), '') AS description,
    ISNULL(NULLIF(TRIM(designation), ''), 'unknown') AS designation,
    points,
    CAST(TRY_CONVERT(FLOAT, NULLIF(TRIM(price), '')) AS INT) AS price,
    LOWER(ISNULL(NULLIF(TRIM(province), ''), 'unknown')) AS province,
    LOWER(ISNULL(NULLIF(TRIM(region_1), ''), 'unknown')) AS region_1,
    LOWER(ISNULL(NULLIF(TRIM(region_2), ''), 'unknown')) AS region_2,
    ISNULL(NULLIF(TRIM(taster_name), ''), 'unknown') AS taster_name,
    ISNULL(NULLIF(TRIM(taster_twitter_handle), ''), 'unknown') AS taster_twitter_handle,
    NULLIF(TRIM(title), '') AS title,
    ISNULL(NULLIF(TRIM(variety), ''), 'unknown') AS variety,
    NULLIF(TRIM(winery), '') AS winery
FROM bronze.wine_reviews


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

CREATE OR ALTER PROCEDURE silver.load_silver AS 
BEGIN 
    DECLARE @start_time DATETIME, @end_time DATETIME;
    BEGIN TRY

        SET @start_time = GETDATE();

        PRINT '================================================';
        PRINT 'Loading Silver Layer';
        PRINT '================================================';

        PRINT '>> Truncating Table: silver.wine_reviews';
        TRUNCATE TABLE silver.wine_reviews

        PRINT '>> Inserting Data Into: silver.wine_reviews';
        INSERT INTO silver.wine_reviews (
            reviews_id,
            country,
            description,
            designation,
            points,
            price,
            province,
            region_1,
            region_2,
            taster_name,
            taster_twitter_handle,
            title,
            variety,
            winery
        )
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
        FROM bronze.wine_reviews;

    END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END


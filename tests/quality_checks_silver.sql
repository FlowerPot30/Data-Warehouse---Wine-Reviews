/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
  This script performs various quality checks for data consistency, accuracy,
  and standardization across the 'silver' layer. It includes checks for:
  - Null or duplicate primary keys.
  - Unwanted spaces in string fields.
  - Data standardization and consistency.
  - Data consistency between related fields.

Usage Notes:
  - Run these checks after data loading Silver Layer.
  - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ====================================================================
-- Checking 'silver.wine_reviews'
-- ====================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
	reviews_id
FROM bronze.wine_reviews
GROUP BY reviews_id
HAVING COUNT(*) > 1 OR reviews_id IS NULL;

-- Check for unique name for each country
-- Expectation: No Results
SELECT 
	DISTINCT country
FROM bronze.wine_reviews;
-- Problem: US is the Abbreviation -> 'United States'
-- Problem: NULL value -> 'Unknown'


-- Check for Null and Empty space in description
-- Expectation: No Results
SELECT 
	description
FROM bronze.wine_reviews
WHERE description IS NULL OR TRIM(description) = '';

-- Check for Null in designation
-- Expectation: No Results
SELECT 
	designation
FROM bronze.wine_reviews
WHERE designation IS NULL OR TRIM(designation) = '';
-- Problem: There are many row containing Null 

-- Check for over 100 and lower 0 points in points column
-- Expectation: No Results
SELECT 
	points
FROM bronze.wine_reviews
WHERE points < 0 OR points > 100

-- Check for Null in points column
-- Expectation: No Results
SELECT 
	points 
FROM bronze.wine_reviews
WHERE points IS NULL

-- Check for Null or empty space in price column
-- Expectation: No Results
SELECT 
	price
FROM bronze.wine_reviews
WHERE price IS NULL OR TRIM(price) = '';
-- Problem: There are many row containing Null

-- Check for negative price
-- Expectation: No Results
SELECT 
	price 
FROM bronze.wine_reviews
WHERE price LIKE '%-%'

-- Check for Null and empty space in province, region_1 and region_2 column
-- Expectation: No Results
SELECT province
FROM bronze.wine_reviews
WHERE province IS NULL OR TRIM(province) = '';

SELECT region_1
FROM bronze.wine_reviews
WHERE region_1 IS NULL OR TRIM(region_1) = '';

SELECT region_2
FROM bronze.wine_reviews
WHERE region_2 IS NULL OR TRIM(region_2) = '';
-- Problem: There are many Null row

-- Check for Null and empty space in taster_name and taster_twitter_handle
-- Expectation: No Results
SELECT taster_name
FROM bronze.wine_reviews
WHERE taster_name IS NULL OR TRIM(taster_name) = '';

SELECT taster_twitter_handle
FROM bronze.wine_reviews
WHERE taster_twitter_handle IS NULL OR TRIM(taster_twitter_handle) = '';
-- Problem: There are many Null row

-- Check for Null and empty space in title column
-- Expectation: No Results
SELECT title
FROM bronze.wine_reviews
WHERE title IS NULL OR TRIM(title) = '';

-- Check for Null and empty space in variety column
-- Expectation: No Results
SELECT variety
FROM bronze.wine_reviews
WHERE variety IS NULL OR TRIM(variety) = '';
-- Problem: There is only one Null row

-- Check for Null and empty space in winery column
-- Expectation: No Results
SELECT winery
FROM bronze.wine_reviews
WHERE winery IS NULL OR TRIM(winery) = '';

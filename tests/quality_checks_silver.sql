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

SELECT *
FROM bronze.wine_reviews;

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
	reviews_id
FROM bronze.wine_reviews
GROUP BY reviews_id
HAVING COUNT(*) > 1 OR reviews_id IS NULL;

-- Check 

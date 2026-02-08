/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_production_src
-- =============================================================================

IF OBJECT_ID('gold.dim_production_src', 'V') IS NOT NULL
    DROP VIEW gold.dim_production_src;

GO

CREATE VIEW gold.dim_production_src AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY country, province, region_1, region_2) AS prod_source_id,
    country,
    province,
    region_1,
    region_2
FROM (
    SELECT DISTINCT country, province, region_1, region_2
    FROM silver.wine_reviews
) t;

GO

-- =============================================================================
-- Create Dimension: gold.dim_reviewer
-- =============================================================================

IF OBJECT_ID('gold.dim_reviewer', 'V') IS NOT NULL
    DROP VIEW gold.dim_reviewer;

GO

CREATE VIEW gold.dim_reviewer AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY taster_name, taster_twitter_handle) AS reviewer_id,
    taster_name,
    taster_twitter_handle
FROM (
    SELECT DISTINCT taster_name, taster_twitter_handle
    FROM silver.wine_reviews
) t;

GO

-- =============================================================================
-- Create Dimension: gold.dim_wine_info
-- =============================================================================

IF OBJECT_ID('gold.dim_wine_info', 'V') IS NOT NULL
    DROP VIEW gold.dim_wine_info;

GO

CREATE VIEW gold.dim_wine_info AS 
SELECT 
    ROW_NUMBER() OVER (ORDER BY designation, title, winery) AS wine_id,
    designation,
    title,
    variety,
    winery
FROM (
    SELECT DISTINCT designation, title, variety, winery
    FROM silver.wine_reviews
) t;

GO

-- =============================================================================
-- Create Dimension: gold.dim_review_text
-- =============================================================================

IF OBJECT_ID('gold.dim_review', 'V') IS NOT NULL
    DROP VIEW gold.dim_review;

GO

CREATE VIEW gold.dim_review AS 
SELECT 
    ROW_NUMBER() OVER (ORDER BY description) AS review_txt_id,
    description
FROM (
    SELECT DISTINCT description
    FROM silver.wine_reviews
) t;

GO

-- =============================================================================
-- Create Dimension: gold.fact_review
-- =============================================================================

IF OBJECT_ID('gold.fact_review', 'V') IS NOT NULL
    DROP VIEW gold.fact_review;

GO

CREATE VIEW gold.fact_review AS
SELECT 
    w.reviews_id,
    ps.prod_source_id,
    r.review_txt_id,
    wi.wine_id,
    rv.reviewer_id,
    points,
    price
FROM silver.wine_reviews w

JOIN gold.dim_production_src ps 
    ON w.country = ps.country
    AND w.province = ps.province
    AND w.region_1 = ps.region_1
    AND w.region_2 = ps.region_2

JOIN gold.dim_review r
    ON w.description = r.description

JOIN gold.dim_wine_info wi
    ON w.designation = wi.designation
   AND w.title = wi.title
   AND w.variety = wi.variety
   AND w.winery = wi.winery

JOIN gold.dim_reviewer rv
    ON w.taster_name = rv.taster_name
   AND w.taster_twitter_handle = rv.taster_twitter_handle;

/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID('silver.wine_reviews', 'U') IS NOT NULL
	DROP TABLE silver.wine_reviews;
GO

CREATE TABLE silver.wine_reviews (
	reviews_id INT,
	country VARCHAR(255),
	description VARCHAR(1000),
	designation VARCHAR(255),
	points INT,
	price INT,
	province VARCHAR(255),
	region_1 VARCHAR(255),
	region_2 VARCHAR(255),
	taster_name VARCHAR(255),
	taster_twitter_handle VARCHAR(255),
	title VARCHAR(255),
	variety	VARCHAR(255),
	winery VARCHAR(255)
)

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


/*
===============================================================================
Store Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
	This stored procedure loads data into the 'bronze' schema from external CSV file.
	It performs the following actions:
	- Truncates the bronze tables before loading data.
	- Use the 'BULK INSERT' command to load data from CSV file to bronze tables.

Parameters:
	None (This stored procedure does not accept any parameters or return any values.)

Usage Example:
	EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY

		PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';
		
		PRINT '------------------------------------------------';
		PRINT 'Loading wine_reviews Tables';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.wine_reviews;
		
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.wine_reviews
		FROM 'C:\Users\potte\OneDrive\เดสก์ท็อป\WINE\dataset\winemag-data-130k-v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR  = ',',
			TABLOCK,
			FIELDQUOTE = '"',
			ROWTERMINATOR = '0x0a',
			FORMAT='CSV',
			CODEPAGE = '65001'
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
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

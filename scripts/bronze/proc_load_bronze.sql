/*
================================================
Stored Procedure: Load Bronze Layer
================================================
Script Purpose: 
  This This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following actions:
  -  Deletes the data from the bronze tables while keeping the structure of the tables intact, before loading the data.
  -  Uses the 'BULK INSERT' command to load data from CSV files to bronze tables.

  Parameters:
  None
  This stored procedure does not accept any parameters or return any values.

  Usage:
  (If the tables exist)
  EXEC bronze.load_bronze;
-----------------------------------------------
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @layer_start_time DATETIME, @layer_end_time DATETIME;
	BEGIN TRY

	SET @layer_start_time = GETDATE();

	PRINT '======================================';
	PRINT 'Loading Bronze Layer';
	PRINT '======================================';

	PRINT '--------------------------------------';
	PRINT 'Loading CRM Tables';
	PRINT '--------------------------------------';

	SET @start_time = GETDATE();
	PRINT '>> Truncating/ DELETE FROM: bronze.crm_cust_info';
	DELETE FROM bronze.crm_cust_info;

	PRINT '>> Inserting Data Into: bronze.crm_cust_info';
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\PRANAV BHANDAWAT\Documents\School\Data with Baara -youtube\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '>> --------------';

	SET @start_time = GETDATE();
	PRINT '>> Truncating/ DELETE FROM: bronze.crm_prd_info';
	DELETE FROM bronze.crm_prd_info;

	PRINT '>> Inserting Data Into: bronze.crm_prd_info';
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\PRANAV BHANDAWAT\Documents\School\Data with Baara -youtube\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @start_time = GETDATE();
	PRINT '>> Truncating/ DELETE FROM: bronze.crm_sales_details';
	DELETE FROM bronze.crm_sales_details;

	PRINT '>> Inserting Data Into: bronze.crm_sales_details';
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\PRANAV BHANDAWAT\Documents\School\Data with Baara -youtube\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'Loading time: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	PRINT '--------------------------------------';
	PRINT 'Loading ERP Tables';
	PRINT '--------------------------------------';

	SET @start_time = GETDATE();
	PRINT '>> Truncating/ DELETE FROM: bronze.erp_cust_az12';
	DELETE FROM bronze.erp_cust_az12;

	PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Users\PRANAV BHANDAWAT\Documents\School\Data with Baara -youtube\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'Loading time: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @start_time = GETDATE();
	PRINT '>> Truncating/ DELETE FROM: bronze.erp_loc_a101';
	DELETE FROM bronze.erp_loc_a101;

	PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
	BULK INSERT bronze.erp_loc_a101
	FROM 'C:\Users\PRANAV BHANDAWAT\Documents\School\Data with Baara -youtube\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'Loading time: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @start_time = GETDATE();
	PRINT '>> Truncating/ DELETE FROM: bronze.erp_px_cat_g1v2';
	DELETE FROM bronze.erp_px_cat_g1v2;

	PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\PRANAV BHANDAWAT\Documents\School\Data with Baara -youtube\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT 'Loading time: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @layer_end_time = GETDATE();

	PRINT '===================================';
	PRINT 'Loading Bronze Layer is Completed';
	PRINT 'Bronze Layer Loading time: ' + CAST(DATEDIFF(second, @layer_start_time, @layer_end_time) AS VARCHAR) + ' seconds';
	PRINT '===================================';

	END TRY
	BEGIN CATCH
		PRINT '===================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '===================================';
	END CATCH
END

EXEC bronze.load_bronze;

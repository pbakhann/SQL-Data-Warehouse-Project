/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME ;
	BEGIN TRY
	SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Loading CRM Table';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info <<';
		TRUNCATE TABLE [bronze].[crm_cust_info];
		BULK INSERT [bronze].[crm_cust_info]
		FROM	
		'C:\Users\bprom\Desktop\dwh_project_baraa\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH ( 
		FIRSTROW = 2
		,FIELDTERMINATOR = ','
		,TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration is' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------------------'; 

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info <<';
		TRUNCATE TABLE [bronze].[crm_prd_info] ;
		BULK INSERT [bronze].[crm_prd_info]
		FROM
		'C:\Users\bprom\Desktop\dwh_project_baraa\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH ( 
		FIRSTROW = 2
		,FIELDTERMINATOR = ','
		,TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration is' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details <<';
		TRUNCATE TABLE[bronze].[crm_sales_details] ;
		BULK INSERT [bronze].[crm_sales_details] 
		FROM 
		'C:\Users\bprom\Desktop\dwh_project_baraa\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH ( 
		FIRSTROW = 2
		,FIELDTERMINATOR = ','
		,TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration is' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		
		
		PRINT '------------------------------------------------';
		PRINT 'Loading ERP Table';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12 <<';
		TRUNCATE TABLE [bronze].[erp_cust_az12];
		BULK INSERT [bronze].[erp_cust_az12]
		FROM 
		'C:\Users\bprom\Desktop\dwh_project_baraa\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH ( 
		FIRSTROW = 2
		,FIELDTERMINATOR = ','
		,TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration is' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101 <<';
		TRUNCATE TABLE [bronze].[erp_loc_a101];
		BULK INSERT [bronze].[erp_loc_a101]
		FROM 
		'C:\Users\bprom\Desktop\dwh_project_baraa\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH ( 
		FIRSTROW = 2
		,FIELDTERMINATOR = ','
		,TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration is' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2 <<';
		TRUNCATE TABLE [bronze].[erp_px_cat_g1v2];
		BULK INSERT [bronze].[erp_px_cat_g1v2]
		FROM 
		'C:\Users\bprom\Desktop\dwh_project_baraa\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH ( 
		FIRSTROW = 2
		,FIELDTERMINATOR = ','
		,TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration is' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '------------------------------------------------';
	
	SET @batch_end_time = GETDATE(); 
	PRINT '=============================================';
	PRINT '	Total Loading Time is' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
	PRINT '=============================================';


	END TRY
	BEGIN CATCH
		PRINT '=========================================';
		PRINT 'Error occured during loading Bronze Layer';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() as NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() as NVARCHAR);
		PRINT '=========================================';
	END CATCH
END


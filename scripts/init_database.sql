/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'datawarehouse_project_bara' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE master;
GO

-- Drop and recreate the 'datawarehouse_project_bara' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'datawarehouse_project_bara')
BEGIN
    ALTER DATABASE datawarehouse_project_bara SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE datawarehouse_project_bara;
END;
GO

-- Create the 'datawarehouse_project_bara' database
CREATE DATABASE datawarehouse_project_bara;
GO

USE datawarehouse_project_bara;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

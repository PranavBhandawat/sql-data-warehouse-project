/*
============================================================
Crete Database and Schemas
============================================================
Script Purpose:
  This script creates a new database named "DataWarehouse". The below code doesn't check if the database already exists. 
  If a database with this name already exists then, an error will be thrown.
  This will protect the users from dropping the already existing database.
  The script will additionally set up three schemas within the database: 'bronze', 'silver', 'gold'.

  Additional Tip:
  Change the database's name to something other than 'DataWarehouse' if the following error occurs-
  Error in SQL: The object name already exists in the database. */

USE master;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;

USE DataWarehouse;

-- Create Schemas
CREATE SCHEMA bronze;
GO
  
CREATE SCHEMA silver;
GO
  
CREATE SCHEMA gold;
GO


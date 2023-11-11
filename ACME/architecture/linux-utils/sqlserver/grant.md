https://chartio.com/learn/databases/grant-sql-server-table-permissions/
enter SSMS
Create a new login
Enter a descriptive Login name, select SQL Server authentication, and enter a secure password.  On the bottom of the page select the database Chartio will be connecting to as the Default database.

Select the User Mapping tab, check the box next to the desired database, confirm that ‘db_owner’ is selected, and click OK.
GRANT SELECT ON "dbo"."Customer" TO "chartio_read_only"

Stored Procedure
https://learn.microsoft.com/en-us/sql/relational-databases/stored-procedures/grant-permissions-on-a-stored-procedure?view=sql-server-ver16
USE AdventureWorks2012;   
GRANT EXECUTE ON SCHEMA::HumanResources
    TO Recruiting11;  
GO  

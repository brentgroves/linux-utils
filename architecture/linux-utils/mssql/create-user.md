https://www.mssqltips.com/sqlservertip/5242/adding-users-to-azure-sql-databases/#:~:text=MEMBER%20%5Btest%5D%3B-,Connect%20to%20your%20Azure%20SQL%20Database%20server%20with%20SSMS%20as,the%20db_datareader%20and%20db_datawriter%20roles.
https://www.mssqltips.com/sqlservertip/5242/adding-users-to-azure-sql-databases/#:~:text=MEMBER%20%5Btest%5D%3B-,Connect%20to%20your%20Azure%20SQL%20Database%20server%20with%20SSMS%20as,the%20db_datareader%20and%20db_datawriter%20roles.

CREATE LOGIN alex 
WITH PASSWORD = 'y1!JFs41Vf' 

CREATE USER [alex] 
FOR LOGIN [alex] 
WITH DEFAULT_SCHEMA = planner; 
  
-- add user to role(s) in db 
ALTER ROLE db_datareader ADD MEMBER [test]; 
ALTER ROLE db_datawriter ADD MEMBER [test]; 

CREATE USER alex
WITH DEFAULT_SCHEMA = planner
WITH PASSWORD = 'y1!JFs41Vf'
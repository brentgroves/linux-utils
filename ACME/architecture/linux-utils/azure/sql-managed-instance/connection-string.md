https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/public-endpoint-configure?view=azuresql#obtaining-the-managed-instance-public-endpoint-connection-string

Obtaining the managed instance public endpoint connection string
Navigate to the managed instance configuration page that has been enabled for public endpoint. Select the Connection strings tab under the Settings configuration.

The public endpoint host name comes in the format <mi_name>.public.<dns_zone>.database.windows.net and that the port used for the connection is 3342. Here's an example of a server value of the connection string denoting the public endpoint port that can be used in SQL Server Management Studio or Azure Data Studio connections: <mi_name>.public.<dns_zone>.database.windows.net,3342

Driver={ODBC Driver 18 for SQL Server};Server=tcp:mgsqlmi.public.48d444e7f69b.database.windows.net,3342;Uid=mgadmin@mgsqlmi;Pwd=b`+~p4;q8.e2>NHW;Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;

HRT-KORS43

https://go.microsoft.com/fwlink/?linkid=2223270
https://learn.microsoft.com/en-us/azure/azure-sql/database/transparent-data-encryption-tde-overview?view=azuresql&tabs=azure-portal
Transparent data encryption for SQL Database, SQL Managed Instance, and Azure Synapse Analytics
Transparent data encryption (TDE) helps protect Azure SQL Database, Azure SQL Managed Instance, and Azure Synapse Analytics against the threat of malicious offline activity by encrypting data at rest. It performs real-time encryption and decryption of the database, associated backups, and transaction log files at rest without requiring changes to the application. By default, TDE is enabled for all newly deployed Azure SQL Databases and must be manually enabled for older databases of Azure SQL Database. For Azure SQL Managed Instance, TDE is enabled at the instance level and newly created databases. TDE must be manually enabled for Azure Synapse Analytics.

**[transparent data encryption](https://learn.microsoft.com/en-us/sql/relational-databases/security/encryption/transparent-data-encryption?view=sql-server-ver16)**

Transparent data encryption (TDE) encrypts SQL Server, Azure SQL Database, and Azure Synapse Analytics data files. This encryption is known as encrypting data at rest.

To help secure a user database, you can take precautions like:

Designing a secure system.
Encrypting confidential assets.
Building a firewall around the database servers.
However, a malicious party who steals physical media like drives or backup tapes can restore or attach the database and browse its data.

One solution is to encrypt sensitive data in a database and use a certificate to protect the keys that encrypt the data. This solution prevents anyone without the keys from using the data. But you must plan this kind of protection in advance.

TDE does real-time I/O encryption and decryption of data and log files. The encryption uses a database encryption key (DEK). The database boot record stores the key for availability during recovery. The DEK is a symmetric key. It's secured by a certificate that the server's master database stores or by an asymmetric key that an EKM module protects.

TDE protects data at rest, which is the data and log files. It lets you follow many laws, regulations, and guidelines established in various industries. This ability lets software developers encrypt data by using AES and 3DES encryption algorithms without changing existing applications.

TDE is not available for system databases. It can't be used to encrypt master, model, or msdb. tempdb is automatically encrypted when a user database enabled TDE, but can't be encrypted directly.
TDE doesn't provide encryption across communication channels. For more information about how to encrypt data across communication channels, see Enable Encrypted Connections to the Database Engine (SQL Server Configuration Manager).

Related topics:

Transparent data encryption for SQL Database, SQL Managed Instance, and Azure Synapse Analytics
Get started with transparent data encryption (TDE) in Azure Synapse Analytics
Move a TDE Protected Database to Another SQL Server
Enable TDE on SQL Server Using EKM
Use SQL Server Connector with SQL Encryption Features
The SQL Server Security Blog on TDE with FAQ


**[SQL Managed Instance security capabilities](https://www.sqltreeo.com/docs/azure-sql-database-and-sql-managed-instance-security-capabilities)**
Information protection and encryption
Transport Layer Security (Encryption-in-transit)
SQL Database, SQL Managed Instance, and Azure Synapse Analytics secure customer data by encrypting data in motion with Transport Layer Security (TLS).

SQL Database, SQL Managed Instance, and Azure Synapse Analytics enforce encryption (SSL/TLS) at all times for all connections. This ensures all data is encrypted "in transit" between the client and server irrespective of the setting of Encrypt or TrustServerCertificate in the connection string.

As a best practice, recommend that in the connection string used by the application, you specify an encrypted connection and not trust the server certificate. This forces your application to verify the server certificate and thus prevents your application from being vulnerable to man in the middle type attacks.

For example when using the ADO.NET driver this is accomplished via Encrypt=True and TrustServerCertificate=False. If you obtain your connection string from the Azure portal, it will have the correct settings.



Network security
Microsoft Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics provide a relational database service for cloud and enterprise applications. To help protect customer data, firewalls prevent network access to the server until access is explicitly granted based on IP address or Azure Virtual network traffic origin.
IP firewall rules
IP firewall rules grant access to databases based on the originating IP address of each request. as shown in below figure.
**![IP firewall rules](https://www.sqltreeo.com/user_images/20210222101749YZ3m-5a76ffb622e7.jpg)**

Virtual network firewall rules
Virtual network service endpoints extend your virtual network connectivity over the Azure backbone and enable Azure SQL Database to identify the virtual network subnet that traffic originates from. To allow traffic to reach Azure SQL Database, use the SQL service tags to allow outbound traffic through Network Security Groups.

Virtual network rules enable Azure SQL Database to only accept communications that are sent from selected subnets inside a virtual network.

Access management
 

Authentication
Authentication is the process of proving the user is who they claim to be. Azure SQL Database and SQL Managed Instance support two types of authentication:

·       SQL authentication:

SQL authentication refers to the authentication of a user when connecting to Azure SQL Database or Azure SQL Managed Instance using username and password. A server admin login with a username and password must be specified when the server is being created. Using these credentials, a server admin can authenticate to any database on that server or instance as the database owner. After that, additional SQL logins and users can be created by the server admin, which enable users to connect using username and password.

·       Azure Active Directory authentication:

Azure Active Directory authentication is a mechanism of connecting to Azure SQL Database, Azure SQL Managed Instance and Azure Synapse Analytics by using identities in Azure Active Directory (Azure AD). Azure AD authentication allows administrators to centrally manage the identities and permissions of database users along with other Azure services in one central location. This includes the minimization of password storage and enables centralized password rotation policies.

A server admin called the Active Directory administrator must be created to use Azure AD authentication with SQL Database. Azure AD authentication supports both managed and federated accounts. The federated accounts support Windows users and groups for a customer domain federated with Azure AD.
Authorization
Authorization refers to the permissions assigned to a user within a database in Azure SQL Database or Azure SQL Managed Instance, and determines what the user is allowed to do. Permissions are controlled by adding user accounts to database roles and assigning database-level permissions to those roles or by granting the user certain object-level permissions.

As a best practice, create custom roles when needed. Add users to the role with the least privileges required to do their job function. Do not assign permissions directly to users. The server admin account is a member of the built-in db_owner role, which has extensive permissions and should only be granted to few users with administrative duties. For applications, use the EXECUTE AS to specify the execution context of the called module or use Application Roles with limited permissions. This practice ensures that the application that connects to the database has the least privileges needed by the application. Following these best practices also fosters separation of duties.
Row-level security
Row-Level Security enables customers to control access to rows in a database table based on the characteristics of the user executing a query (for example, group membership or execution context). Row-Level Security can also be used to implement custom Label-based security concepts.
Threat protection
SQL Database and SQL Managed Instance secure customer data by providing auditing and threat detection capabilities.

SQL auditing in Azure Monitor logs and Event Hubs
SQL Database and SQL Managed Instance auditing tracks database activities and helps maintain compliance with security standards by recording database events to an audit log in a customer-owned Azure storage account. Auditing allows users to monitor ongoing database activities, as well as analyze and investigate historical activity to identify potential threats or suspected abuse and security violations. 

Advanced Threat Protection
 

Advanced Threat Protection is analyzing your logs to detect unusual behavior and potentially harmful attempts to access or exploit databases. Alerts are created for suspicious activities such as SQL injection, potential data infiltration, and brute force attacks or for anomalies in access patterns to catch privilege escalations and breached credentials use. Alerts are viewed from the Azure Security Center, where the details of the suspicious activities are provided and recommendations for further investigation given along with actions to mitigate the threat. Advanced Threat Protection can be enabled per server for an additional fee. 


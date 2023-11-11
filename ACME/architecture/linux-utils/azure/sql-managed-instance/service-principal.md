https://learn.microsoft.com/en-us/azure/azure-sql/database/authentication-aad-service-principal?view=azuresql

Azure Active Directory (Azure AD) supports user creation in Azure SQL Database (SQL DB) on behalf of Azure AD applications (service principals). This is supported for Azure SQL Database and Azure SQL Managed Instance.

Service principal (Azure AD applications) support
This article applies to applications that are integrated with Azure AD, and are part of Azure AD registration. These applications often need authentication and authorization access to Azure SQL to perform various tasks. This feature allows service principals to create Azure AD users in SQL Database. There was a limitation preventing Azure AD object creation on behalf of Azure AD applications that was removed.


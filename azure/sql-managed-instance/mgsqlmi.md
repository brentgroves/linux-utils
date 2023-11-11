Settings for our Azure SQL managed instance.
Name: mgsqlmi 
Minimum TLS version: 1.2 (we can lower this to 1.0 or 1.1)
System assigned managed identity: On
A system assigned managed identity enables Azure resources to authenticate to cloud services (e.g. Azure Key Vault) without storing credentials in code. Once enabled, all necessary permissions can be granted via Azure role-based-access-control. The lifecycle of this type of managed identity is tied to the lifecycle of this resource. Additionally, each resource (e.g. Virtual Machine) can only have one system assigned managed identity. 
admin: mgadmin
vnet-mgsqlmi/ManagedInstance
https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/public-endpoint-configure?view=azuresql
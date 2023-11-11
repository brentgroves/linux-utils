https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/public-endpoint-configure?view=azuresql#allow-public-endpoint-traffic-on-the-network-security-group
If you have the configuration page of the managed instance still open, navigate to the Overview tab. Otherwise, go back to your SQL managed instance resource. Select the Virtual network/subnet link, which will take you to the Virtual network configuration page.

Select the Subnets tab on the left configuration pane of your Virtual network, and make note of the SECURITY GROUP for your managed instance.

Go back to your resource group that contains your managed instance. You should see the Network security group name noted above. Select the name to go into the network security group configuration page.

Select the Inbound security rules tab, and Add a rule that has higher priority than the deny_all_inbound rule with the following settings:

https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/public-endpoint-configure?view=azuresql
Configure public endpoint in Azure SQL Managed Instance
Article
03/14/2023
9 contributors
Applies to:  Azure SQL Managed Instance

Public endpoint for a managed instance enables data access to your managed instance from outside the virtual network. You're able to access your managed instance from multi-tenant Azure services like Power BI, Azure App Service, or an on-premises network. By using the public endpoint on a managed instance, you don't need to use a VPN, which can help avoid VPN throughput issues.

In this article, you learn how to:

Enable public endpoint for your managed instance in the Azure portal
Enable public endpoint for your managed instance using PowerShell
Configure your managed instance network security group to allow traffic to the managed instance public endpoint
Obtain the managed instance public endpoint connection string
Permissions
Due to the sensitivity of data that is in a managed instance, the configuration to enable managed instance public endpoint requires a two-step process. This security measure adheres to separation of duties (SoD):

Enabling public endpoint on a managed instance needs to be done by the managed instance admin. The managed instance admin can be found on Overview page of your managed instance resource.
Allowing traffic using a network security group that needs to be done by a network admin. For more information, see network security group permissions.

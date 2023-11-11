https://learn.microsoft.com/en-us/cli/azure/query-azure-cli?tabs=concepts%2Cbash#formatting-query-results
Formatting query results
The Azure CLI uses JSON as its default output format, however different output formats may better suit a query depending on its purpose and results. Note that queries are always run on the JSON output first and then formatted.

This section will go over tsv and table formatting and some use cases for each format. For more information about output formats, see Output formats for Azure CLI commands.

TSV output format
The tsv output format returns tab- and newline-separated values without additional formatting, keys, or other symbols. This is useful when the output is consumed by another command.

One use case for tsv formatting is queries that retrieve a value out of a CLI command, such as an Azure resource ID or resource name, and store the value in a local environment variable. By default the results are returned in JSON format. This may be an issue when dealing with JSON strings which are enclosed in " characters. The quotes may not be interpreted by the shell if the command output is directly assigned to the environment variable. This can be seen in the following example that assigns a query result to an environment variable:

USER=$(az vm show --resource-group QueryDemo --name TestVM --query "osProfile.adminUsername")
echo $USER
USER=$(az vm show --name TestVM --query "osProfile.adminUsername")
echo $USER

USER=$(az vm show --name TestVM --query "osProfile.adminUsername")

az vm list --query "[].{Admin:osProfile.adminUsername,Name:name,ResourceGroup:resourceGroup}"

The table format prints output as an ASCII 
az network public-ip show --resource-group mc_reports-aks_reports-aks_centralus --name ingressAKSPublicIP --query "{objectID:id}" --output table

az vm list --query "[].{Name:name, OS:storageProfile.osDisk.osType, Admin:osProfile.adminUsername}" --output table



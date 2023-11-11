https://learn.microsoft.com/en-us/cli/azure/query-azure-cli?tabs=concepts%2Cbash#jmespath-functions
JMESPath functions
JMESPath also has built-in functions that allow for more complex queries and for modifying query output. This section focuses on using JMESPath functions to create queries while the Manipulating output with functions section demonstrates how to use functions to modify the output.

Expressions are evaluated before calling the function, so arguments themselves can be JMESPath expressions. The following examples demonstrates this by using contains(string, substring), which checks to see if a string contains a substring. This command finds all VMs using SSD storage for their OS disk:

az vm list --resource-group QueryDemo --query "[?contains(storageProfile.osDisk.managedDisk.storageAccountType,'SSD')].{Name:name, Storage:storageProfile.osDisk.managedDisk.storageAccountType}"

az vm list --query "[?contains(storageProfile.osDisk.managedDisk.storageAccountType,'SSD')].{Name:name, Storage:storageProfile.osDisk.managedDisk.storageAccountType}"
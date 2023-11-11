https://learn.microsoft.com/en-us/cli/azure/query-azure-cli?tabs=concepts%2Cbash

The Azure CLI uses the --query parameter to execute a JMESPath query on the results of commands. JMESPath is a query language for JSON, giving you the ability to select and modify data from CLI output.

The --query parameter is supported by all commands in the Azure CLI. This article covers how to use the features of JMESPath and gives examples of queries. Learn about JMESPath concepts that are useful for querying under the concepts tab. See examples of JMESPath queries under the examples tab.

Azure CLI uses queries to select and modify the output of Azure CLI commands. Queries are executed client-side on the Azure CLI command's returned JSON object before any display formatting.

The escape characters needed in queries differ for different environments. It is recommended to run queries in Azure CloudShell or cmd because these shells require less escape characters. To ensure the query examples are syntactically correct, select the tab for the shell you are using.

Even when using an output format other than JSON, CLI command results are first treated as JSON for queries. CLI results are either a JSON array or dictionary. Arrays are sequences of objects that can be indexed, and dictionaries are unordered objects accessed with keys.

The following is an example of an array:

JSON

Copy
[ 
  1,
  2,
  3
]
The following is an example of a dictionary:

JSON

Copy
{
  "isRunning": false,
  "time": "12:00",
  "number": 1
}
Commands that could return more than one object return an array, and commands that always return only a single object return a dictionary.

The following command gets the SSH public keys authorized to connect to the VM by adding a query:

az vm show --resource-group QueryDemo --name TestVM --query "osProfile.linuxConfiguration.ssh.publicKeys"

Get multiple values
To get more than one property, put expressions separated by commas in square brackets [ ] (a multiselect list). The following command gets the VM name, admin user, and SSH key all at once:

az vm show --resource-group QueryDemo --name TestVM --query "[name, osProfile.adminUsername, osProfile.linuxConfiguration.ssh.publicKeys[0].keyData]"

Rename properties in a query
To get a dictionary instead of an array when querying for multiple values, use the { } (multiselect hash) operator. The format for a multiselect hash is {displayName:JMESPathExpression, ...}. displayName will be the string shown in output, and JMESPathExpression is the JMESPath expression to evaluate. Modifying the example from the last section by changing the multiselect list to a hash:

az vm show --resource-group QueryDemo --name TestVM --query "{VMName:name, admin:osProfile.adminUsername, sshKey:osProfile.linuxConfiguration.ssh.publicKeys[0].keyData}"

Get properties in an array
An array has no properties of its own, but it can be indexed. This feature is shown in the last example with the expression publicKeys[0], which gets the first element of the publicKeys array. There's no guarantee CLI output is ordered, so avoid using indexing unless you're sure of the order or don't care which element you get. To access the properties of elements in an array, you do one of two operations: flattening or filtering. This section covers how to flatten an array.

Flattening an array is done with the [] JMESPath operator. All expressions after the [] operator are applied to each element in the current array. If [] appears at the start of the query, it flattens the CLI command result. The results of az vm list can be inspected with this feature. The following query gets the name, OS, and administrator name for each VM in a resource group:

az vm list --resource-group QueryDemo --query "[].{Name:name, OS:storageProfile.osDisk.osType, admin:osProfile.adminUsername}"
Any array can be flattened, not just the top-level result returned by the command. In the last section, the expression osProfile.linuxConfiguration.ssh.publicKeys[0].keyData was used to get the SSH public key for sign-in. To get every SSH public key, the expression could instead be written as osProfile.linuxConfiguration.ssh.publicKeys[].keyData. This query expression flattens the osProfile.linuxConfiguration.ssh.publicKeys array, and then runs the keyData expression on each element:

az vm show --resource-group QueryDemo --name TestVM --query "{VMName:name, admin:osProfile.adminUsername, sshKeys:osProfile.linuxConfiguration.ssh.publicKeys[].keyData }"
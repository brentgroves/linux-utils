https://learn.microsoft.com/en-us/cli/azure/query-azure-cli?tabs=concepts%2Cbash

Filter arrays with boolean expressions
The other operation used to get data from an array is filtering. Filtering is done with the [?...] JMESPath operator. This operator takes a predicate as its contents. A predicate is any statement, including Boolean properties, that can be evaluated to either true or false. Expressions where the predicate evaluates to true are included in the output.

The first query demonstrate how to list the names of all Azure subscriptions connected to your account whose isDefault property is true. The second and third queries show two different ways to list all subscriptions whose isDefault property is false.

# Boolean values are assumed to be true, so you can directly evaluate the isDefault property to return the default subscription.
az account list --query "[?isDefault].name"

# To check if a Boolean property is false, you can use the comparison operator == or the logical operator !.
az account list --query '[?!isDefault].name'
az account list --query "[?isDefault == \`false\`].name"

JMESPath offers the standard comparison and logical operators. These include <, <=, >, >=, ==, and !=. JMESPath also supports logical and (&&), or (||), and not (!). Expressions can be grouped within parenthesis, allowing for more complex predicate expressions. For the full details on predicates and logical operations, see the JMESPath specification.

In the last section, you flattened an array to get the complete list of all VMs in a resource group. Using filters, this output can be restricted to only Linux VMs:

az vm list --resource-group QueryDemo --query "[?storageProfile.osDisk.osType=='Linux'].{Name:name,  admin:osProfile.adminUsername}" --output table


az vm list --query "[?storageProfile.osDisk.osType=='Linux'].{Name:name,  admin:osProfile.adminUsername}" --output table
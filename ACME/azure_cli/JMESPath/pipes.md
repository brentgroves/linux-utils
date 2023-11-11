Pipe expressions
Similar to how | is used in the command line, | can be used in JMESPath queries to apply expressions to intermediate query results. We can also use | to break down complex queries into simpler subexpressions. To shorten the query from the previous section, use | to apply the filter after flattening and selecting data.

az vm list --resource-group QueryDemo --query "[].{Name:name, Storage:storageProfile.osDisk.managedDisk.storageAccountType} | [? contains(Storage,'SSD')]"

az vm list --query "[].{Name:name, Storage:storageProfile.osDisk.managedDisk.storageAccountType} | [? contains(Storage,'SSD')]"

Manipulating output with functions
JMESPath functions also have another purpose, which is to operate on the results of a query. Any function that returns a non-boolean value changes the result of an expression. For example, you can sort data by a property value with sort_by(array, &sort_expression). JMESPath uses a special operator, &, for expressions that should be evaluated later as part of a function. The next example shows how to sort a VM list by OS disk size:

az vm list --resource-group QueryDemo --query "sort_by([].{Name:name, Size:storageProfile.osDisk.diskSizeGb}, &Size)" --output table

az vm list --query "sort_by([].{Name:name, Size:storageProfile.osDisk.diskSizeGb}, &Size)" --output table

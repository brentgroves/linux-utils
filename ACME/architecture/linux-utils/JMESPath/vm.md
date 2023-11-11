https://www.azurecitadel.com/cli/jmespath/

az vm list --show-details --output table --query "[*].[name, hardwareProfile.vmSize, storageProfile.osDisk.osType, privateIps, publicIps, fqdns, powerState]"

az vm list --show-details --output json --query "[*].{VM:name, Size:hardwareProfile.vmSize, OS:storageProfile.osDisk.osType, IP:privateIps, PIP:publicIps, FQDN:fqdns, State:powerState}"

az vm list --output json --query "[?location == 'westeurope']"
az vm list --output json --query "[?storageProfile.osDisk.osType == 'Linux']"
az vm list --output tsv --query "[?name == 'vmName'].id"

As in Bash, we can use pipes in our JMESPATH queries to get to the desired point. As a simple example, compare the following:

az vm list --output tsv --query "[?name == 'vmName']"
az vm list --output tsv --query "[?name == 'vmName']|[0]"
The VM name should be unique within that subscription and resource group, so the first will provide the array slice containing only one element. In the second command we pull out just that first element, so the JSON output from that command will have stripped out the surrounding square braces.

query="length([?storageProfile.osDisk.osType == 'Linux'])"
az vm list --output tsv --query "$query"


query="[?ends_with(storageProfile.osDisk.managedDisk.storageAccountType, 'LRS')]"
az vm list --show-details --output json --query "$query"

query="reverse(sort_by([], &storageProfile.osDisk.diskSizeGb))"
az vm list --output json --query "$query"

to_array, to_string, to_number

az vm show --resource-group QueryDemo --name TestVM --query "[name, osProfile.adminUsername, osProfile.linuxConfiguration.ssh.publicKeys[0].keyData]"

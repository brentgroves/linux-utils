https://learn.microsoft.com/en-us/cli/azure/
https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest
export RESOURCEGROUP=planner
az group create --name $RESOURCEGROUP --location centralus
# locations: eastus, westeurope, centralus, canadacentral, canadaeast

{
  "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/planner",
  "location": "centralus",
  "managedBy": null,
  "name": "planner",
  "properties": {
    "provisioningState": "Succeeded"
  },
  "tags": null,
  "type": "Microsoft.Resources/resourceGroups"
}
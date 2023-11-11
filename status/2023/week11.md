
Good morning dear ones,
I hope you and your loved ones weathered the snow storm ok! I'm thinking that this wintery weather won't last much longer so hang in there my friends because Spring can't be that far away :-)
Please feel free to contact me friends at anytime at home or at work.
Sincerely yours,
Brent 260-564-4868

Azure:
A reports service principal and resource group.
Deploy a web app and load balancer in AKS.
Generate client id for web app.
Add web app external ip to Teams tab.
Reports:
ETL report pipelines:
Generates current report to be used in Microsoft teams Power BI  in both MongoDB and Azure SQL managed instance.

MongoDB
- is good for storing complete reports accessible with a report id.
- Previously ran reports are not deleted from MongoDB.
- Can move MongoDB report to Azure SQL managed instance for viewing in Microsoft Teams.
Azure SQL managed instance:
- is better at making Microsoft Teams accessible live reports using Microsoft Report Builder license.
- Used to store 1 report of each type whose data set is updated on a regularly scheduled basis for advanced Power BI reports. 
Power BI Gateway:
- Installed on on-premise server.
- used by Power Automate to refresh datasets on a scheduled basis.
- Only necessary for Power BI reports.

https://powerbi.microsoft.com/en-us/gateway/


ETL Scripts:
I deleted the old ETL automation deployment a few weeks ago by accident and will have to manually run the ETL pipeline until the new version is online. 

Helped: 
Created Azure SQL data wharehouse user with access to planner schema for Alex Modarassi who is creating an automated Microsoft planner app that stores planner tasks to a SQL database.

Credentials store:
Pass is a command-line credential store that uses GPG, to keep any items safe and easily accessible.
Pass features:
- It makes a GPG file for every thing that it encrypts.
- It initializes a git repo for team sharing.
- It also has plugins for software, such as dockerhub.

GPG: Definition from: https://medium.com/@chasinglogic/the-definitive-guide-to-password-store-c337a8f023a1
GPG works in much the samhttps://learn.microsoft.com/en-us/power-bi/paginated-reports/paginated-reports-odbc-supportfor Microsoft Report Builder.
2. Department BI Reports
Catagorized in teams by department and report type.
Only most recent ETL generated report of each type made active at any time.
Advanced customer manipulation with modern BI charts, graphs, and dashboards.
3. Individual BI Reports
Catagorized in teams by customer and report type.
Only 1 report of each type made active at any time.
Active report chosen from all customer reports of that type from report id.
Newly selected active report transfered from MongoDB QNAP storage to Azure DW. 
Advanced customer manipulation with modern BI charts, graphs, and dashboards.

Request:
Like to have a service principal with contributer rights in a reports and planner resource group.

https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest

```
# Run Azure CLI
## Login to Azure

```
#login and follow prompts
az login 
```
# create an Azure resource group
export RESOURCEGROUP=reports-aks
echo $RESOURCEGROUP
$ az group create --name $RESOURCEGROUP --location centralus
# locations: eastus, westeurope, centralus, canadacentral, canadaeast

az group list

az group show --name $RESOURCEGROUP

## Create Service Principal
```
https://learn.microsoft.com/en-us/cli/azure/ad/sp?view=azure-cli-latest#az-ad-sp-create-for-rbac
SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment -n "api://reports-sp" -o json)
https://discuss.hashicorp.com/t/values-of-identifieruris-property-must-use-a-verified-domain-documentation-needs-an-update/37828

echo $SERVICE_PRINCIPAL_JSON

#Keep the `appId` and `password` for later use!
https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/invalid-service-principal-profile-credentials-or-client-secret

SERVICE_PRINCIPAL=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
export SERVICE_PRINCIPAL=f1b415e1-cc37-44ae-b6a9-a22f1a31a48b
echo $SERVICE_PRINCIPAL

SERVICE_PRINCIPAL_SECRET=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')
export SERVICE_PRINCIPAL_SECRET=~Q&4:0Js*e@bpP)=XNhm,:}Sz9Z2Fi1b
echo $SERVICE_PRINCIPAL_SECRET
~Q&4:0Js*e@bpP)=XNhm,:}Sz9Z2Fi1b

az ad sp list --filter "displayname eq 'reports-sp'" 

regen this secret because the original secret may contain an invalid characters
https://learn.microsoft.com/en-us/azure/aks/azure-ad-integration-cli
# Get the service principal secret
https://learn.microsoft.com/en-us/cli/azure/ad/sp/credential?view=azure-cli-latest#az-ad-sp-credential-reset
SERVICE_PRINCIPAL_SECRET=$(az ad sp credential reset \
    --name $SERVICE_PRINCIPAL \
    --credential-description "AKSPassword" \
    --query password -o tsv)
echo $SERVICE_PRINCIPAL_SECRET
bouqz~%~1gPW$0L5xEZv~[n];HC0oqvj
SERVICE_PRINCIPAL_SECRET="bouqz~%~1gPW$0L5xEZv~[n];HC0oqvj"
echo $SERVICE_PRINCIPAL_SECRET
```

# grant contributor role over the resource group to our service principal
https://learn.microsoft.com/en-us/cli/azure/role/assignment?view=azure-cli-latest#az-role-assignment-create
az role assignment create --assignee $SERVICE_PRINCIPAL \
--scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$RESOURCEGROUP" \
--role Contributor

{
  "canDelegate": null,
  "id": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/resourceGroups/reports-aks/providers/Microsoft.Authorization/roleAssignments/4640090d-719b-455f-b63e-11bab865ac11",
  "name": "4640090d-719b-455f-b63e-11bab865ac11",
  "principalId": "da29e589-8bc3-45ff-8b8e-f8ab2206a603",
  "principalType": "ServicePrincipal",
  "resourceGroup": "reports-aks",
  "roleDefinitionId": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c",
  "scope": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/resourceGroups/reports-aks",
  "type": "Microsoft.Authorization/roleAssignments"
}
```
```

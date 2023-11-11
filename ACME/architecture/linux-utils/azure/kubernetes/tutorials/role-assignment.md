# grant contributor role over the resource group to our service principal
```
az role assignment create --assignee $SERVICE_PRINCIPAL \
--scope "/subscriptions/$SUBSCRIPTION/resourceGroups/$RESOURCEGROUP" \
--role Contributor

{
  "canDelegate": null,
  "id": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/resourceGroups/aks-getting-started/providers/Microsoft.Authorization/roleAssignments/50229936-4eb2-4570-b2c8-407bd19734db",
  "name": "50229936-4eb2-4570-b2c8-407bd19734db",
  "principalId": "2b221519-16b7-478a-9cc5-af0694155b9c",
  "principalType": "ServicePrincipal",
  "resourceGroup": "aks-getting-started",
  "roleDefinitionId": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c",
  "scope": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/resourceGroups/aks-getting-started",
  "type": "Microsoft.Authorization/roleAssignments"
}
```

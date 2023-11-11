# Reset the service principal
https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/invalid-service-principal-profile-credentials-or-client-secret
https://learn.microsoft.com/en-us/cli/azure/ad/sp/credential?view=azure-cli-latest#az-ad-sp-credential-reset

# get sp id
az ad sp list --filter "displayname eq 'api://reports'" 
[
  {
    "accountEnabled": true,
    "addIns": [],
    "alternativeNames": [],
    "appDescription": null,
    "appDisplayName": "api://reports",
    "appId": "15cdd566-98bb-4130-8ec5-5c58cffb34bf",
    "appOwnerOrganizationId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
    "appRoleAssignmentRequired": false,
    "appRoles": [],
    "applicationTemplateId": null,
    "createdDateTime": "2023-03-06T21:53:48Z",
    "deletedDateTime": null,
    "description": null,
    "disabledByMicrosoftStatus": null,
    "displayName": "api://reports",
    "homepage": null,
>>> "id": "cc991d02-41dc-422b-84c2-7abc97f304fe",
 

az ad sp credential reset --id "cc991d02-41dc-422b-84c2-7abc97f304fe"
# have not tested
export SERVICE_PRINCIPAL_SECRET=$(az ad sp credential reset --id "cc991d02-41dc-422b-84c2-7abc97f304fe --query password -o tsv")
az ad sp credential reset --id "cc991d02-41dc-422b-84c2-7abc97f304fe" --credential-description "reports password" 

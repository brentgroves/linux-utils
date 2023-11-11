https://build5nines.com/azure-cli-2-list-set-azure-subscription/
To view which Azure Subscription the Azure CLI’s context is currently set to target, run the following command:

Notice that the Azure CLI commands refer to the Azure Subscription as an account. This will define the base (or prefix) command for working with Azure Subscriptions as az account.
az account show
{
  "environmentName": "AzureCloud",
  "homeTenantId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
  "id": "f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a",
  "isDefault": true,
  "managedByTenants": [],
  "name": "sub_mgmain_itservices",
  "state": "Enabled",
  "tenantId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
  "user": {
    "name": "bgroves@buschegroup.com",
    "type": "user"
  }
}

List Azure Subscriptions
You first need to know some details about your Azure Subscriptions in order to update the Azure Subscription the Azure CLI’s context is set to. The specific detail you need to know are the id or name of your Azure Subscriptions. When you use the az account list Azure CLI command, the terminal response will be JSON that contains this information about all the Azure Subscriptions your current login has access to.

To view a list of all the Azure Subscriptions you have access to, run the following command:

az account list

[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "07476fd3-6a57-4e3f-80ab-a1be2af5d10a",
    "id": "c9170272-6419-45d7-a3d5-9526a65e8e91",
    "isDefault": false,
    "managedByTenants": [],
    "name": "Azure subscription 1",
    "state": "Enabled",
    "tenantId": "07476fd3-6a57-4e3f-80ab-a1be2af5d10a",
    "user": {
      "name": "brent.groves@outlook.com",
      "type": "user"
    }
  },
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
    "id": "f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a",
    "isDefault": true,
    "managedByTenants": [],
    "name": "sub_mgmain_itservices",
    "state": "Enabled",
    "tenantId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
    "user": {
      "name": "bgroves@buschegroup.com",
      "type": "user"
    }
  }
]

Set Azure Subscription to Target
Once you know which Azure Subscription you need to scope the Azure CLI context to, or which Azure Subscription you want to run commands against, then you will set the Azure CLI to use that subscription.

To set the Azure Subscription you want to target with Azure CLI commands, you will run the following command to tell it explicitly which subscription you wish to target:

# Set subscription by Id
az account set --subscription XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
Mobex/"sub_mgmain_itservices" = id:f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a
Outlook/"Azure subscription 1" = id:c9170272-6419-45d7-a3d5-9526a65e8e91

Personal subscription
"id": "c9170272-6419-45d7-a3d5-9526a65e8e91",
"name": "Azure subscription 1",
    "user": {
      "name": "brent.groves@outlook.com",
      "type": "user"
    }

"id": "f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a",
"name": "sub_mgmain_itservices",
  "user": {
    "name": "bgroves@buschegroup.com",
    "type": "user"
  }

# Set subscription by Name
az account set --subscription "Company Subscription"



When the az account show command is executed, you’ll see a JSON response written to the terminal with information about the specific Azure Subscription the Azure CLI is currently set to work with:


az account subscription list
  {
    "authorizationSource": "RoleBased",
    "displayName": "sub_mgmain_itservices",
    "id": "/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a",
    "state": "Enabled",
    "subscriptionId": "f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a",
    "subscriptionPolicies": {
      "locationPlacementId": "Public_2014-09-01",
      "quotaId": "CSP_2015-05-01",
      "spendingLimit": "Off"
    }
  }
]
az account subscription show --id "f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a"

  "scope": "/subscriptions/c9170272-6419-45d7-a3d5-9526a65e8e91/resourceGroups/reports-aks",
az account list
[
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "07476fd3-6a57-4e3f-80ab-a1be2af5d10a",
    "id": "c9170272-6419-45d7-a3d5-9526a65e8e91",
    "isDefault": false,
    "managedByTenants": [],
    "name": "Azure subscription 1",
    "state": "Enabled",
    "tenantId": "07476fd3-6a57-4e3f-80ab-a1be2af5d10a",
    "user": {
      "name": "brent.groves@outlook.com",
      "type": "user"
    }
  },
  {
    "cloudName": "AzureCloud",
    "homeTenantId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
    "id": "f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a",
    "isDefault": true,
    "managedByTenants": [],
    "name": "sub_mgmain_itservices",
    "state": "Enabled",
    "tenantId": "b4b87e8f-df64-41ff-9ba4-a4930ebc804b",
    "user": {
      "name": "bgroves@buschegroup.com",
      "type": "user"
    }
  }
]

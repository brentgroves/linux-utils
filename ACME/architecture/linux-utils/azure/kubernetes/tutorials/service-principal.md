## Create Service Principal

Kubernetes needs a service account to manage our Kubernetes cluster </br>
Lets create one! </br>

```
SERVICE_PRINCIPAL_JSON=$(az ad sp create-for-rbac --skip-assignment -n "api://aks-getting-started-sp" -o json)
https://discuss.hashicorp.com/t/values-of-identifieruris-property-must-use-a-verified-domain-documentation-needs-an-update/37828

echo $SERVICE_PRINCIPAL_JSON
{ "appId": "d91be8b2-5d43-4f50-8dc1-4049a108e1a6", "displayName": "aks-getting-started-sp", "name": "api://aks-getting-started-sp", "password": "PhcC\"V\"'Mc/J{86'>jwkZ{sIo6+d~v{I", "tenant": "07476fd3-6a57-4e3f-80ab-a1be2af5d10a" }

#Keep the `appId` and `password` for later use!
https://learn.microsoft.com/en-us/troubleshoot/azure/azure-kubernetes/invalid-service-principal-profile-credentials-or-client-secret

SERVICE_PRINCIPAL=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.appId')
SERVICE_PRINCIPAL=d91be8b2-5d43-4f50-8dc1-4049a108e1a6
echo $SERVICE_PRINCIPAL

SERVICE_PRINCIPAL_SECRET=$(echo $SERVICE_PRINCIPAL_JSON | jq -r '.password')
had to regen this secret because the original secret contained invalid characters
https://learn.microsoft.com/en-us/azure/aks/azure-ad-integration-cli
# Get the service principal secret
SERVICE_PRINCIPAL_SECRET=$(az ad sp credential reset \
    --name $SERVICE_PRINCIPAL \
    --credential-description "AKSPassword" \
    --query password -o tsv)
echo $SERVICE_PRINCIPAL_SECRET
bouqz~%~1gPW$0L5xEZv~[n];HC0oqvj
SERVICE_PRINCIPAL_SECRET="bouqz~%~1gPW$0L5xEZv~[n];HC0oqvj"
echo $SERVICE_PRINCIPAL_SECRET
```

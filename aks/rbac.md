https://www.trendmicro.com/cloudoneconformity/knowledge-base/azure/AKS/enable-role-based-access-control-for-kubernetes-service.html

To determine if Kubernetes Role-Based Access Control is enabled for your AKS clusters, perform the following actions:

Run aks list command (Windows/macOS/Linux) using custom query filters to list the name and the associated resource group for each Azure Kubernetes Service (AKS) cluster available in the current subscription:

az aks list --output table --query '[*].{name:name, resourceGroup:resourceGroup}'
Name         ResourceGroup
-----------  ---------------
reports-aks  reports

  Run aks show command (Windows/macOS/Linux) using the name of the AKS cluster that you want to examine and its associated resource group as identifier parameters to describe the configuration status of the Kubernetes Role-Based Access Control function set for the selected AKS resource:

az aks show --name reports-aks --resource-group reports --query 'enableRbac'

true

If you would like to enable client source IP preservation for requests to containers in your cluster, add --set controller.service.externalTrafficPolicy=Local to the Helm install command. The client source IP is stored in the request header under X-Forwarded-For. When you're using an ingress controller with client source IP preservation enabled, TLS pass-through won't work.

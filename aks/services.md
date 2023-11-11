https://learn.microsoft.com/en-us/azure/aks/use-multiple-node-pools#assign-a-public-ip-per-node-for-your-node-pools-preview

https://www.webagesolutions.com/blog/chapter-1-deploying-and-exposing-applications-on-aks

https://youtu.be/eyvLwK5C2dw

https://medium.com/microsoftazure/aks-different-load-balancing-options-for-a-single-cluster-when-to-use-what-abd2c22c2825
Azure load balancer
When working with Cloud managed Kubernetes offerings, you have the option to create a cloud network load balancer to expose your k8s application outside the cluster. This is done by deploying a service object with type: LoadBalancer.

In AKS , deploying such service will build an Azure Load Balancer outside the cluster that is preconfigured on your behalf with the right frontend, load balancing rules, health checks and backend pools in order to get to your application pods. Creating many LoadBalancer services in the same cluster will simply add new Frontends, load balancing rules and backend pools to the same load balancer.

One thing to note is since AKS clusters comes already with a public Azure Load Balancer that provides outbound internet connectivity to the nodes. Azure will use the same Load Balancer when creating services with public endpoints to minimize on creating more Load Balancers. However, If you choose to create LoadBalancer services with private endpoints to expose your application internally on the vnet level, this will trigger the creation of a new internal Azure load balancer. Let’s see how to create both types of services in Azure.

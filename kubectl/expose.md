https://www.containiq.com/post/kubectl-expose

Each resource inside a running Kubernetes instance is assigned an IP address that’s used as the basis for communication. However, the resources are ephemeral, and change when a new Kubernetes resource is created. Moreover, resources like pods can have multiple instances, each with a different dynamic IP.

This means that if you want to communicate with a given resource, a robust framework is required. This issue is addressed by Kubernetes Services. A Kubernetes Service groups a set of resources and links them using network policy. Resources can also be logically linked using selector.

kubectl expose helps you to expose your resources by creating a service, and will create different services to serve different use cases. For example, if you’re debugging your application from an external environment by sending mock HTTP requests to your pods, this is made possible by exposing the pods and interacting with them using a NodePort service.

Similarly, pods can be exposed internally to other pods in a cluster using a ClusterIP service. This might be required for accessing an internal engine that processes your data and returns results that you don’t want exposed externally. Another important use case is when you’re deploying your application to a cloud platform, and you have a huge number of pods. Exposing the whole deployment using the LoadBalancer service can help to distribute the incoming traffic across the available and healthy pods in the deployment.

In this article, you’ll learn how to expose your pods with the kubectl expose command in different practical scenarios, and will be provided with code samples and configurations that you can run on your local machine using minikube and kubectl. You’ll also learn about best practices to follow when using the kubectl expose command.


kubectl is a command-line tool that helps an end user to interact with the Kubernetes cluster by way of the Kubernetes API. Each action in Kubernetes is undertaken by the control plane, and the instructions for these actions come in through the Kubernetes API server. The API server validates the incoming request, transforms the data, and sends it to the control plane. The control plane maintains the DNS and networking information of Kubernetes resources, and interacts with them using an IP address. Having a service allows you to group the resources under a single IP address.

When the kubectl expose command is run, it takes the name of the resource, the port, the target port that should be used to expose, the protocol over which to expose, and the type of the service. It sends this data using a REST request to the Kubernetes API server, which then instructs the control plane to make the service and assign an IP to it.

The Kubernetes resources that can be exposed using a service are pods, deployments, replica sets, and replication controllers. kubectl expose uses selectors to expose the resources to a given port.

When deploying data-intensive applications, it’s a common practice to use internal containers that do concurrent processing as a way of ensuring that a single pod doesn’t take all the CPU and memory utilization that is available to it. This distribution of load might require you to interact with internal pods, for which you’ll need an internal IP address. This is the ideal use case for ClusterIP. The internal pods are deployed and exposed, and the resultant IP is used by the main pods to interact with them. Thanks to kubectl expose, you only need to provide the IP of the service and not of the pod. If an internal pod becomes unhealthy and inactive, a new pod with a new IP will be created, but because of the selector, it will be mapped to the same service.

The pods run on nodes. In a network where there are multiple nodes, each node will have a unique, stable IP address and, like any physical machine, you can interact with the IP and port. This is the purpose of the NodePort service, which is responsible for exposing your resources externally. The application’s port needs to be mapped with the port of the node, and kubectl expose gives you the option to configure it. For example, if you have a container serving on port 8000, you can expose it on port 80 of your node using the kubectl expose option --target-port.

In an application with a high number of active users, the traffic must be evenly distributed among the available pods. This is handled by the LoadBalancer service. Without load balancing, a pod’s finite resources will become overwhelmed, and the pod will inevitably go down.


Expose the internal-deployment using ClusterIP:


console@bash:~$ kubectl expose deployment internal-deployment --port=80 --target-port=8008 --name=internal-service
This will create a service for internal-deployment. The service is named internal-service, and is on the target port of 8008. As you can see, the type of IP is ClusterIP over TCP protocol, which is the default of the kubectl expose command:

# Expose using Nodeport
To expose the external deployment as a NodePort service, you can specify the type as NodePort in kubectl expose:
console@bash:~$ kubectl expose deployment external-deployment --port=80 --target-port=8000 --name=external-service --type=NodePort

After this, you can see the details of external-service using the following command:


console@bash:~$ kubectl describe service external-service

Name:                     external-service
Namespace:                default
Labels:                   app=external-deployment
Annotations:              <none>
Selector:                 app=external-deployment
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.109.230.202
IPs:                      10.109.230.202
Port:                     <unset>  80/TCP
TargetPort:               8000/TCP
NodePort:                 <unset>  30193/TCP
Endpoints:                172.17.0.5:8000,172.17.0.6:8000,172.17.0.7:8000
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>


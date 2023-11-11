https://medium.com/microsoftazure/aks-different-load-balancing-options-for-a-single-cluster-when-to-use-what-abd2c22c2825
Azure load balancer
When working with Cloud managed Kubernetes offerings, you have the option to create a cloud network load balancer to expose your k8s application outside the cluster. This is done by deploying a service object with type: LoadBalancer.

In AKS , deploying such service will build an Azure Load Balancer outside the cluster that is preconfigured on your behalf with the right frontend, load balancing rules, health checks and backend pools in order to get to your application pods. Creating many LoadBalancer services in the same cluster will simply add new Frontends, load balancing rules and backend pools to the same load balancer.

One thing to note is since AKS clusters comes already with a public Azure Load Balancer that provides outbound internet connectivity to the nodes. Azure will use the same Load Balancer when creating services with public endpoints to minimize on creating more Load Balancers. However, If you choose to create LoadBalancer services with private endpoints to expose your application internally on the vnet level, this will trigger the creation of a new internal Azure load balancer. Let’s see how to create both types of services in Azure.

First using public endpoint:

cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Service
metadata:
  name: printhostname-svc-public
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: printhostname
EOF
Second using a private endpoint:

cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Service
metadata:
  name: printhostname-svc-private
  annotations:
    service.beta.kubernetes.io/azure-load-balancer-internal: "true"
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: printhostname
EOF
Check the two services are created:

kubectl get svc
NAME                      TYPE         CLUSTER-IP    EXTERNAL-IP
kubernetes                ClusterIP    10.2.0.1      <none>     
printhostname-svc-private LoadBalancer 10.2.0.123    192.168.1.97    
printhostname-svc-public  LoadBalancer 10.2.0.15     20.72.139.123   


https://medium.com/microsoftazure/aks-different-load-balancing-options-for-a-single-cluster-when-to-use-what-abd2c22c2825
# Load balancing options
In order to test the different load balancing options, we will start with deploying a sample k8s application. Then we will attempt to expose it outside our cluster.

For this blog, We built a simple python webserver docker image that simply prints back the hostname of the container where it’s running. The container image is stored in docker hub under docker.io/raddaoui:printhostname:v1. You can find the source code and the docker file to build the image here.

Create a deployment object with 3 replicas of our “printhostname” server app by deploying the manifest below:

cat <<EOF | kubectl apply -f -
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: printhostname
spec:
  replicas: 3
  selector:
    matchLabels:
      app: printhostname
  template:
    metadata:
      labels:
        app: printhostname
    spec:
      nodeSelector:
        "kubernetes.io/os": linux
      containers:
      - name: debug
        image: docker.io/raddaoui/printhostname:v1
        ports:
        - containerPort: 80
          name: http
EOF

We have our app deployed, let’s expose it outside our cluster using the different methods available in AKS and explain the reasoning behind choosing one versus another.

Azure load balancer
When working with Cloud managed Kubernetes offerings, you have the option to create a cloud network load balancer to expose your k8s application outside the cluster. This is done by deploying a service object with type: LoadBalancer.

In AKS , deploying such service will build an Azure Load Balancer outside the cluster that is preconfigured on your behalf with the right frontend, load balancing rules, health checks and backend pools in order to get to your application pods. Creating many LoadBalancer services in the same cluster will simply add new Frontends, load balancing rules and backend pools to the same load balancer.

One thing to note is since AKS clusters comes already with a public Azure Load Balancer that provides outbound internet connectivity to the nodes. Azure will use the same Load Balancer when creating services with public endpoints to minimize on creating more Load Balancers. However, If you choose to create LoadBalancer services with private endpoints to expose your application internally on the vnet level, this will trigger the creation of a new internal Azure load balancer. Let’s see how to create both types of services in Azure.

First using public endpoint:

cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Service
metadata:
  name: printhostname-svc-public
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: printhostname
EOF

Second using a private endpoint:

cat <<EOF | kubectl apply -f -
---
apiVersion: v1
kind: Service
metadata:
  name: printhostname-svc-private
  annotations:
    service.beta.kubernetes.io/azure-load-balancer-internal: "true"
spec:
  type: LoadBalancer
  ports:
  - port: 80
  selector:
    app: printhostname
EOF

Check the two services are created:

kubectl get svc
NAME                      TYPE         CLUSTER-IP    EXTERNAL-IP
kubernetes                ClusterIP    10.2.0.1      <none>     
printhostname-svc-private LoadBalancer 10.2.0.123    192.168.1.97    
printhostname-svc-public  LoadBalancer 10.2.0.15     20.72.139.123   


We can now access our application externally under http://20.72.139.123 or internally if you have private access to the VNET under http://192.168.1.97.

— When to use?

This method is useful when you want to expose non HTTP(s) type services. It can be used to directly expose a k8s service outside the cluster. Azure Loadbalancers are pass-through type load balancers so there is no filtering or routing happening here and features such as SSL offloading, URL routing, WAF,.etc are not supported. Any type of traffic can be sent here such as TCP, UDP, HTTP, Websockets.,etc.

Be aware, that with a public LoadBalancer service, each application requires a public IP address assigned and mapped to the service in the AKS cluster which can be expensive when you expose multiple services overtime.
https://blog.knoldus.com/what-is-headless-service-setup-a-service-in-kubernetes/
https://itnext.io/exposing-statefulsets-in-kubernetes-698730fb92a1
Following the normal practice of having a single Service point to all instances of your application doesn’t work when you want to query a specific instance directly. This is already handled internally with the Headless Service you create alongside the StatefulSet. The created ervice will not be given a clusterIP, but will instead simply include a list of Endpoints. These Endpoints are then used to generate instance-specific DNS records in the form of: <StatefulSet>-<Ordinal>.<Service>.<Namespace>.svc.cluster.local e.g., app-0.myapp.default.svc.cluster.local.

In the default behaviour of Kubernetes we assign as Internal IP address to the service.And with this IP address the service will proxy and load-balance the requests to the pods.We can choose which kind of service type we need while deploying it. These service types are-

ClusterIP- For exposing the server on cluster-internal IP address
NodePort- For exposing the service through a static port on the node
LoadBalancer- to expose the service using an external load-balancer

apiVersion: v1
kind: Service
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  ports:
  - port: 80
    name: web
  clusterIP: None
  selector:
    app: nginx
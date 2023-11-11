https://itnext.io/exposing-statefulsets-in-kubernetes-698730fb92a1

TL;DR:
StatefulSet Pods have the label: statefulset.kubernetes.io/pod-name which contains their generated name (<StatefulSet Name>-<Ordinal>). You can create individual Services for each instance that use that label as their selector to expose the individual instances of the StatefulSet.
To remove a potential extra hop, create the Services with the attribute externalTrafficPolicy and set it to Local.
You can automate this process with a nifty cluster automation tool metacontroller.

apiVersion: v1
kind: Service
metadata:
  name: app-0
spec:
  type: LoadBalancer
  externalTrafficPolicy: Local
  selector:
    statefulset.kubernetes.io/pod-name: app-0
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80

Following the normal practice of having a single Service point to all instances of your application doesn’t work when you want to query a specific instance directly. This is already handled internally with the Headless Service you create alongside the StatefulSet. The created ervice will not be given a clusterIP, but will instead simply include a list of Endpoints. These Endpoints are then used to generate instance-specific DNS records in the form of: <StatefulSet>-<Ordinal>.<Service>.<Namespace>.svc.cluster.local e.g., app-0.myapp.default.svc.cluster.local.

kubectl describe svc mysql3

Name:              mysql3
Namespace:         default
Labels:            app=mysql3
Annotations:       <none>
Selector:          app=mysql3
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                None
IPs:               None
Port:              <unset>  3306/TCP
TargetPort:        3306/TCP
Endpoints:         10.1.148.13:3306
Session Affinity:  None
Events:            <none>

Now, how do you replicate that when you want to expose it externally as a LoadBalancer Service? The Kubernetes developers have thought of this already. ;) Each Pod in the StatefulSet has it’s own label that includes its generated Pod identity: statefulset.kubernetes.io/pod-name. You know what that means? It means we can use it in a Service Selector!

apiVersion: v1
kind: Service
metadata:
  name: app-0
spec:
  type: LoadBalancer
  selector:
    statefulset.kubernetes.io/pod-name: app-0
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80

While the headless service might not take care of all our needs, we can create additional Services that point to the individual Pods of the StatefulSet. Generally speaking, StatefulSets aren’t being scaled up or down without some careful planning, so it’s worth the small amount of extra effort to create some additional Services.

With that, we will be able to expose our instances individually, but we can actually improve on this a bit.

When an external Kubernetes Service (NodePort and LoadBalancer) is created, it will open a port on all nodes in the cluster that can be used for reaching our exposed Service. This is great in a general sense, when you spread traffic across many instances of the same Pod, but not so much when you want to direct traffic to a singular one. It’d be better if we could direct traffic directly to the node running the specific instance of our StatefulSet. Thankfully, the devs thought of this scenario too!

You can route traffic directly to the node by setting the Service attribute externalTrafficPolicy to Local. This forces the Service to only proxy traffic for local endpoints. Meaning, any node in the cluster that is not running the specific instance of the Pod will not proxy traffic, and will therefore fail any external healthcheck.

apiVersion: v1
kind: Service
metadata:
  name: app-0
spec:
  type: LoadBalancer
  externalTrafficPolicy: Local
  selector:
    statefulset.kubernetes.io/pod-name: app-0
  ports:
  - protocol: TCP
    port: 80
    targetPort: 80

This may seem a little odd, but it’s a very useful and generic method that can play nice with the various cloud providers and their load balancers. By not proxying the traffic, the nodes will automatically be removed from the load balancer pool for that external Service forcing traffic to only go to the node running that specific instance.

With that, you should be able to expose StatefulSets externally and remove the unnecessary extra hop when routing traffic to a single instance.

Bonus:
If you don’t want to have to manage creating an additional Service per Pod for your StatefulSet, it can be automated using a powerful cluster automation tool called metacontroller. It allows you to create your own simple controllers where you can trigger additional scripts or actions. One of their examples automates the Service creation for StatefulSet instances using their DecoratorController.


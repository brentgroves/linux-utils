# MinIO operator

<https://min.io/docs/minio/kubernetes/upstream/operations/installation.html#id1>

MinIO Operator Components
The MinIO Operator exists in its own namespace.

Within the Operator’s namespace, the MinIO Operator utilizes two pods: - The Operator pod for the base Operator functions to deploy, manage, modify, and maintain tenants. - Console pod for the Operator’s Graphical User Interface, the Operator Console.

When you use the Operator to create a tenant, the tenant must have its own namespace. Within that namespace, the Operator generates the pods required by the tenant configuration.

Each pod runs three containers:

MinIO Container that runs all of the standard MinIO functions, equivalent to basic MinIO installation on baremetal. This container stores and retrieves objects in the provided mount points (persistent volumes).

InitContainer that only exists during the launch of the pod to manage configuration secrets during startup. Once startup completes, this container terminates.

SideCar container that monitors configuration secrets for the tenant and updates them as they change. This container also monitors for root credentials and creates an error if it does not find root credentials.

Starting with v5.0.6, the MinIO Operator supports custom init containers for additional pod initialization that may be required for your environment.

The tenant utilizes Persistent Volume Claims to talk to the Persistent Volumes that store the objects.

<https://min.io/docs/minio/kubernetes/upstream/_images/OperatorsComponent-Diagram.png>

kubectl get all -n minio-operator
NAME                                  READY   STATUS    RESTARTS   AGE
pod/minio-operator-66847c5bd7-5c5kc   1/1     Running   0          47h
pod/minio-operator-66847c5bd7-dxq2q   1/1     Running   0          47h
pod/console-78d567bfc8-lnd94          1/1     Running   0          47h
pod/microk8s-ss-0-0                   1/1     Running   0          47h

NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
service/operator           ClusterIP   10.152.183.70    <none>        4222/TCP,4221/TCP               47h
service/console            ClusterIP   10.152.183.136   <none>        9090/TCP,9443/TCP               47h
service/minio              ClusterIP   10.152.183.180   <none>        80/TCP                          47h
service/microk8s-console   ClusterIP   10.152.183.221   <none>        9090/TCP                        47h
service/microk8s-hl        ClusterIP   None             <none>        9000/TCP                        47h
service/console-np         NodePort    10.152.183.112   <none>        9090:30551/TCP,9443:30552/TCP   46h

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/minio-operator   2/2     2            2           47h
deployment.apps/console          1/1     1            1           47h

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/minio-operator-66847c5bd7   2         2         2       47h
replicaset.apps/console-78d567bfc8          1         1         1       47h

NAME                             READY   AGE
statefulset.apps/microk8s-ss-0   1/1     47h

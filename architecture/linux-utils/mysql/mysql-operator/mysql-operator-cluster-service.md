# MySQL Operator Cluster Service

**[](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-innodbcluster-service.html)**

MySQL InnoDB Cluster Service Explanation
For connecting to the InnoDB Cluster, a Service is created inside the Kubernetes cluster. The exported ports represent read-write and read-only ports for both the MySQL Protocol and X Protocol.

```bash
kubectl describe service mycluster

Output looks similar to this:


Name:              mycluster
Namespace:         default
Labels:            mysql.oracle.com/cluster=mycluster
                   tier=mysql
Annotations:       <none>
Selector:          component=mysqlrouter,mysql.oracle.com/cluster=mycluster,tier=mysql
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.106.33.215
IPs:               10.106.33.215
Port:              mysql  3306/TCP
TargetPort:        6446/TCP
Endpoints:         172.17.0.12:6446
Port:              mysqlx  33060/TCP
TargetPort:        6448/TCP
Endpoints:         172.17.0.12:6448
Port:              mysql-alternate  6446/TCP
TargetPort:        6446/TCP
Endpoints:         172.17.0.12:6446
Port:              mysqlx-alternate  6448/TCP
TargetPort:        6448/TCP
Endpoints:         172.17.0.12:6448
Port:              mysql-ro  6447/TCP
TargetPort:        6447/TCP
Endpoints:         172.17.0.12:6447
Port:              mysqlx-ro  6449/TCP
TargetPort:        6449/TCP
Endpoints:         172.17.0.12:6449
Port:              router-rest  8443/TCP
TargetPort:        8443/TCP
Endpoints:         172.17.0.12:8443
Session Affinity:  None
Events:            <none>

An alternative view showing services named mycluster and mycluster-instances:

$> kubectl get service
Output looks similar to this:


NAMESPACE     NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                                                  AGE
default       kubernetes            ClusterIP   10.96.0.1        <none>        443/TCP                                                  2d1h
default       mycluster             ClusterIP   10.102.198.226   <none>        3306/TCP,33060/TCP,6446/TCP,6448/TCP,6447/TCP,6449/TCP   2d
default       mycluster-instances   ClusterIP   None             <none>        3306/TCP,33060/TCP,33061/TCP                             2d


```

The long host name used to connect to an InnoDB Cluster from within a Kubernetes cluster is {innodbclustername}.{namespace}.svc.cluster.local, which routes to the current primary/replica using MySQL Router, depending on the port. Acceptable host name forms:

{innodbclustername}.{namespace}.svc.cluster.local
{innodbclustername}.{namespace}.svc
{innodbclustername}.{namespace}
{innodbclustername}

Using these names goes to the Kubernetes LoadBalancer (part of Kubernetes Service), which redirects to MySQL Router. MySQL Router then talks to the individual server based on the role, such as PRIMARY or SECONDARY.

For example, assuming 'mycluster' as the InnoDB Cluster name in the 'default' namespace:

mycluster.default.svc.cluster.local

Using only {innodbclustername} as the host name assumes the session's context is either the default namespace or set accordingly. Alternatively you may use the clusterIP instead of a host name; here's an example that retrieves it:

$> kubectl get service/mycluster -o jsonpath='{.spec.clusterIP}'

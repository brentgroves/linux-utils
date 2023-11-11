# MySQL Operator Connecting

**[MySQL Operator Connecting](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-connecting.html)**

This section utilizes the {innodbclustername}.{namespace}.svc.cluster.local form when connecting; and typically refers to the {innodbclustername} shorthand form that assumes the default namespace. See Section 3.4, “MySQL InnoDB Cluster Service Explanation” for additional information.

## Connect with MySQL Shell

```bash
Create a new container with MySQL Shell to administer a MySQL InnoDB Cluster. This is the preferred method, although every MySQL Operator for Kubernetes and MySQL InnoDB Cluster container also has MySQL Shell installed if you need to troubleshoot a specific pod.

These examples assume the InnoDB Cluster is named 'mycluster' and using the 'default' namespace.

Create the new container with MySQL Shell; this example uses the MySQL Operator for Kubernetes image but other images work too, such as container-registry.oracle.com/mysql/community-server:8.0.

This example creates a new container named "myshell" using a MySQL Operator image, and immediately executes MySQL Shell:

$> kubectl run --rm -it myshell --image=container-registry.oracle.com/mysql/community-operator -- mysqlsh
If you don't see a command prompt, try pressing enter.

MySQL JS >

Now connect to the InnoDB Cluster from within MySQL Shell's interface:

MySQL JS>  \connect root@mycluster

Creating a session to 'root@mycluster'
Please provide the password for 'root@mycluster': ******

MySQL mycluster JS>

The root@mycluster shorthand works as it assumes port 3306 (MySQL Router redirects to 6446) and the default namespace.

Optionally pass in additional arguments to mysqlsh, for example:

$> kubectl run --rm -it myshell --image=container-registry.oracle.com/mysql/community-operator -- mysqlsh root@mycluster --sql
If you don't see a command prompt, try pressing enter.
******

MySQL mycluster SQL>
The "******" represents entering the MySQL user's password to MySQL Shell as MySQL Shell prompts for a password by default. The root@mycluster represents user root on host mycluster, and assumes the default namespace. Setting "-sql initiates MySQL Shell into SQL mode.

Troubleshooting a Specific Container
Every MySQL Operator for Kubernetes and MySQL InnoDB Cluster container has MySQL Shell installed, so for troubleshooting you may need to connect to a specific pod in the cluster. For example, connecting to a pod named mycluster-0:

$> kubectl --namespace default exec -it mycluster-0 -- bash
Defaulted container "sidecar" out of: sidecar, mysql, initconf (init), initmysql (init)
bash-4.4#

bash-4.4# mysqlsh root@localhost
Please provide the password for 'root@localhost': ******
```

## Connect with Port Forwarding

Optionally use port forwarding to create a redirection from your local machine to easily use a MySQL client such as MySQL Workbench. We'll use port 3306 for a read-write connection to the primary on port 6446:

```bash
$> kubectl port-forward service/mycluster 3306

Forwarding from 127.0.0.1:3306 -> 6446
Forwarding from [::1]:3306 -> 6446
To test, open a second terminal using the MySQL command line or MySQL Shell with the InnoDB Cluster user's credentials:

$> mysql -h127.0.0.1 -uroot -p


To demonstrate the connection to a local MySQL instance:

mysql> select @@hostname;
+-------------+
| @@hostname  |
+-------------+
| mycluster-0 |
+-------------+
Not seeing a port-forward to 127.0.0.1:3306 in this example means a local MySQL installation is likely installed and active on the system.

Using port names instead of port numbers also works:

$> kubectl port-forward service/mycluster mysql
Forwarding from 127.0.0.1:3306 -> 6446
Forwarding from [::1]:3306 -> 6446
^C

$> kubectl port-forward service/mycluster mysql-ro
Forwarding from 127.0.0.1:6447 -> 6447
Forwarding from [::1]:6447 -> 6447
A list of port names with their associated ports:


mysql:            3306
mysqlx:           33060
mysql-alternate:  6446
mysqlx-alternate: 6448
mysql-ro:         6447
mysqlx-ro:        6449
router-rest:      8443


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

kubectl port-forward service/mycluster mysql

https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/

NodePort builds on top of the ClusterIP Service and provides a way to expose a group of Pods to the outside world. At the API level, the only difference from the ClusterIP is the mandatory service type which has to be set to NodePort, the rest of the values can remain the same
https://www.tkng.io/services/nodeport/
---
---
apiVersion: v1
kind: Service
metadata:
  name: mycluster-np
spec:
  type: NodePort
  selector:
    component=mysqlrouter,mysql.oracle.com/cluster=mycluster,tier=mysql
  ports:
    # By default and for convenience, the `targetPort` is set to the same value as the incoming `port` field.
    # but the target port is 6446 in our case but since the ClusterIP uses 3306 I will also.
  - port: 3306
    targetPort: mysql 
    # Optional field
    # By default and for convenience, the Kubernetes control plane will allocate a port from a range (default: 30000-32767)
    # Note: A Service can map any incoming port to a targetPort. 
    # By default and for convenience, the targetPort is set to the same value as the port field.    
    nodePort: 30051

https://kubernetes.io/docs/concepts/services-networking/service/

apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: NodePort
  selector:
    app.kubernetes.io/name: MyApp
  ports:
      # By default and for convenience, the `targetPort` is set to the same value as the `port` field.
    - port: 80
      targetPort: 80
      # Optional field
      # By default and for convenience, the Kubernetes control plane will allocate a port from a range (default: 30000-32767)
      nodePort: 30007
```

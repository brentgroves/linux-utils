<https://severalnines.com/blog/mysql-innodb-cluster-80-complete-operation-walk-through-part-two/>

kubectl run --rm -it myshell --image=container-registry.oracle.com/mysql/community-operator -- mysqlsh root@mycluster
cluster = dba.getCluster();
cluster.status()
cluster.describe()

cluster.checkInstanceState("mycluster-1.mycluster-instances.default.svc.cluster.local:3306")

Shutting Down the Cluster
The best way to shut down the cluster gracefully by stopping the MySQL Router service first (if it’s running) on the application server:

$ myrouter/stop.sh

<https://docs.oracle.com/en/cloud/iaas/verrazzano/1.5/vzdoc/docs/troubleshooting/troubleshooting-mysql/>

kubectl get pods -n keycloak -l component=mysqld
NAME      READY   STATUS        RESTARTS   AGE
mysql-0   0/3     Terminating   0          60m

You can repair this issue by restarting the mysql-operator pod.
CopyCopyCopyCopyCopyCopyCopy
$ kubectl delete pod -l name=mysql-operator -n mysql-operator

MySQL router pod in CrashLoopBackOff state
Here is an example of what this condition looks like.
CopyCopyCopyCopy
$ kubectl get pods -n keycloak -l component=mysqlrouter
NAME                            READY   STATUS             RESTARTS   AGE
mysql-router-757595f6c5-pdgxj   1/2     CrashLoopBackOff   0          109m
You can repair this issue by deleting the pod that is in the CrashLoopBackOff state.
CopyCopyCopy
$ kubectl delete pod -n keycloak mysql-router-757595f6c5-pdgxj
InnoDBCluster object stuck Terminating
This condition has been observed to occur on an uninstallation of Verrazzano.

Here is an example of what this condition looks like.
CopyCopy
$ kubectl get InnoDBCluster -n keycloak
NAME    STATUS    ONLINE   INSTANCES   ROUTERS   AGE
mysql   OFFLINE   0        1           1         7m51s
You can repair this issue by restarting the mysql-operator pod.
Copy
$ kubectl delete pod -l name=mysql-operator -n mysql-operator

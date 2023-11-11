deploy mysql stateful set
/home/brent/src/Reporting/prod/k8s/mysql-node/stateful-set/test
kubectl apply -f mysql-set.yaml
kubectl get pods -o wide
NAME                READY   STATUS    RESTARTS   AGE     IP            NODE        NOMINATED NODE   READINESS GATES
mysql-reports31-0   1/1     Running   0          2d1h    10.1.59.137   reports31   <none>           <none>
mysql-set-0         1/1     Running   0          8m50s   10.1.148.5    reports33   <none>           <none>

kubectl get pvc,pv
Create a Service for the StatefulSet Application
Now, create the service for the MySQL Pod. Do not use the load balancer service for a stateful application, but instead, create a headless service for the MySQL application.
kubectl apply -f mysql-service.yaml
Get the list of running services:
kubectl get svc
NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
kubernetes            ClusterIP   10.152.183.1     <none>        443/TCP          3d23h
mysql-reports31-svc   NodePort    10.152.183.220   <none>        3306:30031/TCP   2d1h
mysql                 ClusterIP   None             <none>        3306/TCP         16s

Create a Client for MySQL
If you want to access MySQL, then you will need a MySQL client tool. 
kubectl apply -f mysql-client.yaml
kubectl get pods -o wide
NAME                READY   STATUS    RESTARTS   AGE    IP            NODE        NOMINATED NODE   READINESS GATES
mysql-reports31-0   1/1     Running   0          2d1h   10.1.59.137   reports31   <none>           <none>
mysql-set-0         1/1     Running   0          15m    10.1.148.5    reports33   <none>           <none>
mysql-client        1/1     Running   0          102s   10.1.59.138   reports31   <none>           <none>

Then enter this into the MySQL client:
kubectl exec --stdin --tty mysql-client -- sh
Next, access the MySQL application using the MySQL client and create databases on the Pods.
If you are not already in the MySQL client Pod, enter it now:
kubectl exec -it mysql-client /bin/sh
To access MySQL, you can use the same standard MySQL command to connect with the MySQL server:
mysql -u root -p -h host-server-name
For access, you will need a MySQL server name. The syntax of the MySQL server in the Kubernetes cluster is given below:
stateful_name-ordinal_number.mysql.default.svc.cluster.local
#Example
mysql-set-0.mysql.default.svc.cluster.local
Connect with the MySQL primary Pod using the following command. When asked for a password, enter the one you made in the “Create a Secret” section above.
mysql -u root -p -h mysql-set-0.mysql.default.svc.cluster.local

create database erp;
create table erp.trial_balance_multi_level
(
 pcn int null,
 period int null,
 period_display varchar(7),
 category_type VARCHAR(10),
 category_name VARCHAR(50),
 sub_category_name VARCHAR(50) ,
 account_no VARCHAR(20),
 account_name VARCHAR(110),
 current_debit_credit DECIMAL(18,2),
 ytd_debit_credit DECIMAL(18,2),
 CONSTRAINT PK_trial_balance_multi_level PRIMARY KEY (period_display,account_no) -- when this gets imported there is a period_display but no period.
);
insert into erp.trial_balance_multi_level
values
(123681,202212,'12-2022','cat_type','category_name','sub_category_name','account_no','account_name',0.00,0.00);
select * from erp.trial_balance_multi_level;

 joseluisq/mysql-client
 https://github.com/joseluisq/docker-mysql-client
https://stackoverflow.com/questions/49194719/authentication-plugin-caching-sha2-password-cannot-be-loaded
https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html


If we delete the pod will the stateful-set controller assign the new pod to the same pv?
kubectl delete pod mysql-set-0
kubectl get pod -o wide
NAME                READY   STATUS    RESTARTS   AGE    IP            NODE        NOMINATED NODE   READINESS GATES
mysql-reports31-0   1/1     Running   0          2d3h   10.1.59.137   reports31   <none>           <none>
mysql-client        1/1     Running   0          26m    10.1.59.139   reports31   <none>           <none>
mysql-set-0         1/1     Running   0          21s    10.1.148.6    reports33   <none>           <none>
note: mysql-set-0 has a new ip.
kubectl get pvc,pv
NAME                                            STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/mysql-store-mysql-set-0   Bound    pvc-d280476a-91ed-47df-b0d7-072c76608326   5Gi        RWO            mayastor       80m

NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                             STORAGECLASS   REASON   AGE
persistentvolume/pvc-d280476a-91ed-47df-b0d7-072c76608326   5Gi        RWO            Delete           Bound    default/mysql-store-mysql-set-0   mayastor                80m

kubectl exec --stdin --tty mysql-client -- sh
mysql -u root -p -h mysql-set-0.mysql.default.svc.cluster.local
use erp;
select * from erp.trial_balance_multi_level;


if the node with the stateful set pod crashes will the controller recreate the stateful-set on another node?
ssh brent@reports33
kubectl describe statefulset mysql-set
Name:               mysql-set
Namespace:          default
CreationTimestamp:  Wed, 01 Feb 2023 22:05:51 +0000
Selector:           app=mysql
Labels:             <none>
Annotations:        <none>
Replicas:           1 desired | 1 total
Update Strategy:    RollingUpdate
  Partition:        0
Pods Status:        1 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  app=mysql
  Containers:
   mysql:
    Image:      brentgroves/mysql:8.0
    Port:       3306/TCP
    Host Port:  0/TCP
    Environment:
      MYSQL_ROOT_PASSWORD:  <set to the key 'password3' in secret 'lastpass'>  Optional: false
      TZ:                   America/Fort_Wayne
    Mounts:
      /var/lib/mysql from mysql-store (rw)
  Volumes:  <none>
Volume Claims:
  Name:          mysql-store
  StorageClass:  mayastor
  Labels:        <none>
  Annotations:   <none>
  Capacity:      5Gi
  Access Modes:  [ReadWriteOnce]
Events:          <none>

kubectl describe pv pvc-d280476a-91ed-47df-b0d7-072c76608326
Name:              pvc-d280476a-91ed-47df-b0d7-072c76608326
Labels:            <none>
Annotations:       pv.kubernetes.io/provisioned-by: io.openebs.csi-mayastor
Finalizers:        [kubernetes.io/pv-protection external-attacher/io-openebs-csi-mayastor]
StorageClass:      mayastor
Status:            Bound
Claim:             default/mysql-store-mysql-set-0
Reclaim Policy:    Delete
Access Modes:      RWO
VolumeMode:        Filesystem
Capacity:          5Gi
Node Affinity:     
  Required Terms:  
    Term 0:        kubernetes.io/hostname in [reports31]
    Term 1:        kubernetes.io/hostname in [reports33]
    Term 2:        kubernetes.io/hostname in [reports32]
Message:           
Source:
    Type:              CSI (a Container Storage Interface (CSI) volume source)
    Driver:            io.openebs.csi-mayastor
    FSType:            ext4
    VolumeHandle:      d280476a-91ed-47df-b0d7-072c76608326
    ReadOnly:          false
    VolumeAttributes:      ioTimeout=60
                           local=true
                           protocol=nvmf
                           repl=1
                           storage.kubernetes.io/csiProvisionerIdentity=1674949643676-8081-io.openebs.csi-mayastor

microk8s stop
ssh brent@reports31
kubectl get nodes
NAME        STATUS     ROLES    AGE     VERSION
reports32   Ready      <none>   4d      v1.26.1
reports31   Ready      <none>   4d      v1.26.1
reports33   NotReady   <none>   3d23h   v1.26.1

kubectl get pods -o wide
NAME                READY   STATUS        RESTARTS   AGE    IP            NODE        NOMINATED NODE   READINESS GATES
mysql-reports31-0   1/1     Running       0          2d3h   10.1.59.137   reports31   <none>           <none>
mysql-client        1/1     Running       0          49m    10.1.59.139   reports31   <none>           <none>
mysql-set-0         1/1     Terminating   0          23m    10.1.148.6    reports33   <none>           <none>


kubectl get pvc,pv
kubectl get pvc,pv
NAME                                            STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistentvolumeclaim/mysql-store-mysql-set-0   Bound    pvc-d280476a-91ed-47df-b0d7-072c76608326   5Gi        RWO            mayastor       98m

NAME                                                        CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                             STORAGECLASS   REASON   AGE
persistentvolume/pvc-d280476a-91ed-47df-b0d7-072c76608326   5Gi        RWO            Delete           Bound    default/mysql-store-mysql-set-0   mayastor                98m

kubectl describe statefulset mysql-set
Name:               mysql-set
Namespace:          default
CreationTimestamp:  Wed, 01 Feb 2023 22:05:51 +0000
Selector:           app=mysql
Labels:             <none>
Annotations:        <none>
Replicas:           1 desired | 1 total
Update Strategy:    RollingUpdate
  Partition:        0
Pods Status:        1 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  app=mysql
  Containers:
   mysql:
    Image:      brentgroves/mysql:8.0
    Port:       3306/TCP
    Host Port:  0/TCP
    Environment:
      MYSQL_ROOT_PASSWORD:  <set to the key 'password3' in secret 'lastpass'>  Optional: false
      TZ:                   America/Fort_Wayne
    Mounts:
      /var/lib/mysql from mysql-store (rw)
  Volumes:  <none>
Volume Claims:
  Name:          mysql-store
  StorageClass:  mayastor
  Labels:        <none>
  Annotations:   <none>
  Capacity:      5Gi
  Access Modes:  [ReadWriteOnce]
Events:          <none>
kubectl get pods -o wide

kubectl exec --stdin --tty mysql-client -- sh
mysql -u root -p -h mysql-set-0.mysql.default.svc.cluster.local
use erp;
select * from erp.trial_balance_multi_level;

Next:
stopped k8s on reports33
stateful set was terminating when I left.
Will the stateful-set controller be able to start the set on another node?
Did the database replicate to all the nodes?
Do you have to wait a long time for it to replicate?
Do you have to create a custome storage class for replication to work?

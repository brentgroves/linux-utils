https://github.com/canonical/microk8s/issues/3714

The mayastor pools should be created automatically by the mayastor daemonset when it comes up on each node the first time. Can you please share the following logs from your mayastor daemonset? If something went wrong, they should give a clue as to what happened:

Thank you for looking into this issue. I have attached the logs you requested.  
kubectl logs -n mayastor mayastor-b6nql > ~/Downloads/mayastor-b6nql
kubectl logs -n mayastor mayastor-lp84p > ~/Downloads/mayastor-lp84p
kubectl logs -n mayastor mayastor-2tjdb > ~/Downloads/mayastor-2tjdb

microk8s kubectl get msp -n mayastor
NAME                        NODE        STATUS   CAPACITY      USED         AVAILABLE
microk8s-reports33-pool     reports33   Online   21449670656   3221225472   18228445184
pool-reports32-994175.img   reports32   Online   19977469952   7516192768   12461277184
pool-reports31-cd5afc.img   reports31   Online   19977469952   7516192768   12461277184

**Only 1 mayastorpools created**

#### Summary
When I enabled mayastor on a 3 node HA cluster only 1 mayastorpools is created.  
#### What Should Happen Instead?
3 mayastorpools should get created.  
#### Reproduction Steps
1. sudo microk8s enable core/mayastor --default-pool-size 20G
2. sudo microk8s.kubectl get pod -n mayastor 
```
NAME                                     READY   STATUS    RESTARTS      AGE
etcd-operator-mayastor-65f9967f5-s9lrf   1/1     Running   0             42h
mayastor-csi-cb629                       2/2     Running   0             42h
mayastor-csi-jtzr6                       2/2     Running   0             42h
mayastor-csi-htf2t                       2/2     Running   0             42h
etcd-djlr7lvfs8                          1/1     Running   0             42h
core-agents-55d76bb877-87pj5             1/1     Running   1 (42h ago)   42h
etcd-88lphrb7wv                          1/1     Running   0             42h
msp-operator-74ff9cf5d5-w8l4t            1/1     Running   0             42h
rest-77d69fb479-4lp7m                    1/1     Running   0             42h
etcd-ffxccpr8tf                          1/1     Running   0             42h
mayastor-b6nql                           1/1     Running   0             42h
csi-controller-54ccfcfbcc-lgn69          3/3     Running   0             42h
mayastor-lp84p                           1/1     Running   0             42h
mayastor-2tjdb                           1/1     Running   0             42h
```
3. sudo microk8s.kubectl get mayastorpool -n mayastor  
```
NAME                        NODE        STATUS   CAPACITY      USED   AVAILABLE  
microk8s-reports33-pool     reports33   Online   21449670656   0      21449670656  
only 1 pool is created
```
5. The image files get created.  
```
ls -alh /var/snap/microk8s/common/mayastor/data
each node has an image file like this:
-rw-r--r-- 1 root root  20G Jan 29 02:25 microk8s.img
```
7. manually create mayastorpool on other 2 nodes.
```
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py add --node reports31 --size 20GB
'
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py add --node reports51 --size 20GB
'

sudo microk8s.kubectl get mayastorpool -n mayastor
NAME                        NODE        STATUS   CAPACITY      USED   AVAILABLE
microk8s-reports33-pool     reports33   Online   21449670656   0      21449670656
pool-reports32-994175.img   reports32   Online   19977469952   0      19977469952
pool-reports31-cd5afc.img   reports31   Online   19977469952   0      19977469952
```

**Notes**
This mayastor experiment was conduction on a 3 freshly installed Ubuntu 22.04 system running on dell optiplex 9020,7010, and 7020.  
I did notice that there is now a zombie process on the main node.  


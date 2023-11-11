

kubectl logs -n mayastor mayastor-pnmvg > ~/Downloads/reports51/mayastor-pnmvg
kubectl logs -n mayastor mayastor-gxx5z > ~/Downloads/reports51/mayastor-gxx5z
kubectl logs -n mayastor mayastor-bk2c8 > ~/Downloads/reports51/mayastor-bk2c8
kubectl logs -n mayastor mayastor-gzbwf > ~/Downloads/reports51/mayastor-gzbwf

mayastor-pnmvg 172.20.88.66   reports52   
mayastor-gxx5z 172.20.88.68   reports54 
mayastor-bk2c8 172.20.88.67   reports53 
mayastor-gzbwf 172.20.88.65   reports51 

kubectl get msp -n mayastor                  
NAME                      NODE        STATUS   CAPACITY      USED   AVAILABLE
microk8s-reports52-pool   reports52   Online   21449670656   0      21449670656


7. manually create mayastorpool on other 3 nodes.
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py add --node reports51 --size 20GB
'
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py add --node reports53 --size 20GB
'
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py add --node reports54 --size 20GB
'

kubectl get msp -n mayastor

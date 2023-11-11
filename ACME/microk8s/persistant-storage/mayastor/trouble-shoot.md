https://discuss.kubernetes.io/t/addon-openebs-mayastor-clustered-storage/19451
https://github.com/openebs/mayastor/issues/new?assignees=GlennBullingham&labels=new&template=bug_report.md&title=
[2023-01-28T23:47:19.062471928+00:00  INFO mayastor::subsys::config:mod.rs:216] Applying Mayastor configuration settings
EAL: No available 1048576 kB hugepages reported
TELEMETRY: No legacy callbacks, legacy socket not created



https://github.com/openebs/mayastor/issues/1133

microk8s.kubectl logs -n mayastor daemonset/mayastor
Defaulted container "mayastor" out of: mayastor, registration-probe (init), etcd-probe (init), initialize-pool (init)
[2023-01-10T17:16:08.399054776+00:00 ERROR mayastor:mayastor.rs:84] insufficient free pages available PAGES_NEEDED=1024 nr_pages=1024
[2023-01-10T20:56:54.296489463+00:00 ERROR mayastor::lvs::lvs_pool:lvs_pool.rs:423] error=errno: EEXIST: File exists failed to create pool microk8s-reports01-pool

sudo microk8s disable mayastor --remove-storage 

kubectl -n mayastor logs pod/mayastor-7f8bs
kubectl -n mayastor logs pod/mayastor-pdd9j
kubectl -n mayastor logs pod/mayastor-p565r
kubectl -n mayastor logs pod/mayastor-s47ls
Defaulted container "mayastor" out of: mayastor, registration-probe (init), etcd-probe (init), initialize-pool (init)
[2023-01-10T17:18:38.925254797+00:00 ERROR mayastor:mayastor.rs:84] insufficient free pages available PAGES_NEEDED=1024 nr_pages=1024

sudo sysctl vm.nr_hugepages=1024
echo 'vm.nr_hugepages=1024' | sudo tee -a /etc/sysctl.conf

sudo sysctl vm.nr_hugepages=1048
echo 'vm.nr_hugepages=1048' | sudo tee -a /etc/sysctl.conf
sudo nvim /etc/sysctl.conf
cat /etc/sysctl.conf

sudo sysctl vm.nr_hugepages=2048
echo 'vm.nr_hugepages=2048' | sudo tee -a /etc/sysctl.conf

grep HugePages /proc/meminfo
AnonHugePages:     12288 kB
ShmemHugePages:        0 kB
FileHugePages:         0 kB
HugePages_Total:    1024
HugePages_Free:     1021
HugePages_Rsvd:       61
HugePages_Surp:        0

https://microk8s.io/docs/addon-mayastor


https://github.com/canonical/microk8s-core-addons/issues/25

@stygmate @balchua @lopesdasilva Hi, sorry for taking long. It looks to me like the hugepages message is unrelated to the issue at hand. I've been unable to replicate the issue locally, can you try the following:

microk8s.kubectl edit -n mayastor daemonset mayastor
and append the following command-line argument to the mayastor service: - --env-context=--iova-mode=pa       

mayastor -l <core-list> -g <grpc-endpoint> -y <mayastor-config> -N <node-name> -p <persistent-store-endpoint> -R <registration-endpoint>
error: Found argument '-e' which wasn't expected, or isn't valid in this context


pod/mayastor-pdd9j                           0/1     CrashLoopBackOff   2 (45s ago)   117s
pod/mayastor-b8mdw                           0/1     CrashLoopBackOff   2 (38s ago)   2m2s
pod/mayastor-rtj6p                           0/1     CrashLoopBackOff   3 (30s ago)   112s


WARNING: /var/snap/microk8s/common/mayastor/data/microk8s.img already exists.
To prevent data loss, no pool will be created by default. To fix this, you
can do a clean install of the mayastor addon with:

    microk8s disable mayastor --remove-storage
    microk8s enable mayastor

sudo microk8s.kubectl get mayastorpool -n mayastor
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py --help
'

# create a mayastor pool using `/dev/sdb` on node `uk8s-1`
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py add --node uk8s-1 --device /dev/sdb
'

# create a mayastor pool of 100GB using a sparse image file on node `uk8s-1`. The image file will be placed under `/var/snap/microk8s/common/mayastor/data`.
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py add --node uk8s-1 --size 100GB
'

sudo microk8s.kubectl get mayastorpool -n mayastor

sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py add --node reports31 --size 20GB
'

sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py add --node reports32 --size 20GB
'

# list mayastor pools
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py list
'

# delete a mayastor pool. --force removes it even if the pool is in use, --purge removes the backing image file
# the mayastor pool name is required, as it appears in the output of the list command
sudo snap run --shell microk8s -c '
  $SNAP_COMMON/addons/core/addons/mayastor/pools.py remove microk8s-uk8s-1-pool --force --purge
'
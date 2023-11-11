Worker Node Count
As of version 1.0 the minimum supported worker node count is three nodes.
Note also, that when using the synchronous replication feature (N+1 mirroring), the number of worker nodes to which Mayastor pods are deployed should be no less than the desired replication factor. E.g. four-way mirroring of a volume would require Mayastor pods to be deployed to a minimum of four worker nodes within the cluster.

https://mayastor.gitbook.io/introduction/quickstart/configure-mayastor#create-mayastor-pool-s
Configure Pools for Use with this Quickstart
To continue with this quick start exercise, a minimum of one pool is necessary, created and hosted on one of the Mayastor nodes in the cluster. However, the number of pools available limits the extent to which the synchronous n-way mirroring feature ("replication") of Persistent Volumes can be configured for testing and evaluation; the number of pools configured should be no fewer than the desired maximum replication factor of the PVs to be created. Also, while placing data replicas ensure that appropriate redundancy is provided. Mayastor's control plane will avoid locating more than one replica of a volume on the same Mayastor node. Therefore, for example, the minimum viable configuration for a Mayastor deployment which is intended to test 3-way mirrored PVs must have three Mayastor Nodes, each having one Mayastor Pool, with each of those pools having one unique block device allocated to it.


Create Mayastor StorageClass(s)
Mayastor dynamically provisions Persistent Volumes (PV) based on StorageClass definitions created by the user. Parameters of the definition are used to set the characteristics and behaviour of its associated PVs. For a detailed description of these parameters see storage class parameter description. Most importantly StorageClass definition is used to control the level of data protection afforded to it (that is, the number of synchronous data replicas which are maintained, for purposes of redundancy). It is possible to create any number of StorageClass definitions, spanning all permitted parameter permutations.
We illustrate this quickstart guide with two examples of possible use cases; one which offers no data redundancy (i.e. a single data replica), and another having three data replicas. You can modify these as required to match your own desired test cases, within the limitations of the cluster under test.
**1 replica**
cat <<EOF | kubectl create -f -
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: mayastor-1
parameters:
  repl: '1'
  protocol: 'nvmf'
  ioTimeout: '60'
  local: 'true'
provisioner: io.openebs.csi-mayastor
volumeBindingMode: WaitForFirstConsumer
EOF
**3 replica**
cat <<EOF | kubectl create -f -
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: mayastor-3
parameters:
  repl: '3'
  protocol: 'nvmf'
  ioTimeout: '60'
  local: 'true'
provisioner: io.openebs.csi-mayastor
volumeBindingMode: WaitForFirstConsumer
EOF

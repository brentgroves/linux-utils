https://mayastor.gitbook.io/introduction/quickstart/configure-mayastor#create-mayastor-pool-s
Create Mayastor StorageClass(s)
Mayastor dynamically provisions Persistent Volumes (PV) based on StorageClass definitions created by the user. Parameters of the definition are used to set the characteristics and behaviour of its associated PVs. For a detailed description of these parameters see storage class parameter description. Most importantly StorageClass definition is used to control the level of data protection afforded to it (that is, the number of synchronous data replicas which are maintained, for purposes of redundancy). It is possible to create any number of StorageClass definitions, spanning all permitted parameter permutations.
We illustrate this quickstart guide with two examples of possible use cases; one which offers no data redundancy (i.e. a single data replica), and another having three data replicas. You can modify these as required to match your own desired test cases, within the limitations of the cluster under test.
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
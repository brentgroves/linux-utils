https://mayastor.gitbook.io/introduction/quickstart/deploy-a-test-application

Deploy the FIO Test Pod
The Mayastor CSI driver will cause the application pod and the corresponding Mayastor volume's NVMe target/controller ("Nexus") to be scheduled on the same Mayastor Node, in order to assist with restoration of volume and application availabilty in the event of a storage node failure.
In this version, applications using PVs provisioned by Mayastor can only be successfully scheduled on Mayastor Nodes. This behaviour is controlled by the local: parameter of the corresponding StorageClass, which by default is set to a value of true. Therefore, this is the only supported value for this release - setting a non-local configuration may cause scheduling of the application pod to fail, as the PV cannot be mounted to a worker node other than a MSN. This behaviour will change in a future release.

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

cat <<EOF | kubectl create -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: ms-volume-claim
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: mayastor
EOF


kubectl apply -f https://raw.githubusercontent.com/openebs/Mayastor/v1.0.5/deploy/fio.yaml

cat <<EOF | kubectl create -f -
kind: Pod
apiVersion: v1
metadata:
  name: fio
spec:
  nodeSelector:
    openebs.io/engine: mayastor
  volumes:
    - name: ms-volume
      persistentVolumeClaim:
        claimName: ms-volume-claim
  containers:
    - name: fio
      image: nixery.dev/shell/fio
      args:
        - sleep
        - "1000000"
      volumeMounts:
        - mountPath: "/volume"
          name: ms-volume
EOF


https://mayastor.gitbook.io/introduction/quickstart/deploy-a-test-application

Verify the Volume and the Deployment
We will now verify the Volume Claim and that the corresponding Volume and Mayastor Volume resources have been created and are healthy.
Verify the Volume Claim
The status of the PVC should be "Bound".
kubectl get pvc ms-volume-claim
kubectl get pvc mysql-store-mysql-set-0
kubectl get pv pvc-d280476a-91ed-47df-b0d7-072c76608326

Verify the Mayastor Volume
The status of the volume should be "online".
To verify the status of volume Mayastor Kubectl plugin is used.
kubectl mayastor --rest=http://reports31:30011 get volumes
# Microk8s minio addon

## references

<https://docs.onepanel.ai/docs/deployment/configuration/miniotenants/>
<https://microk8s.io/docs/addon-minio>
<https://min.io/docs/minio/kubernetes/upstream/index.html>
<https://thedatabaseme.de/2022/03/26/backup-to-s3-configure-zalando-postgres-operator-backup-with-wal-g/>
<https://thedatabaseme.de/2022/03/20/i-do-it-on-my-own-then-self-hosted-s3-object-storage-with-minio-and-docker/>
<https://minio-py.min.io/>
<https://min.io/docs/minio/linux/reference/minio-mc/mc-cp.html>

<https://microk8s.io/docs/addon-minio>
<https://min.io/docs/minio/linux/developers/minio-drivers.html#minio-drivers>

MinIO is a well-known and established project in the CNCF ecosystem that provides cloud-agnostic S3-compatible object storage. It is free, open-source and well-trusted by multiple organizations.

The minio addon can be used to deploy MinIO on a MicroK8s cluster using minio-operator, as well as the kubectl-minio CLI tool for managing the deployment. Optionally, this addon deploys a single MinIO tenant so that you can get started using it out of the box. The default tenant can be configured (storage capacity, number of volumes, security) using command-line arguments when enabling the addon (see below).

The MinIO addon can use the simple hostpath storage for single-node clusters, or any storage class you decide for multi-node clusters.

kubectl get all -n minio-operator
NAME                                  READY   STATUS    RESTARTS   AGE
pod/minio-operator-66847c5bd7-5c5kc   1/1     Running   0          47h
pod/minio-operator-66847c5bd7-dxq2q   1/1     Running   0          47h
pod/console-78d567bfc8-lnd94          1/1     Running   0          47h
pod/microk8s-ss-0-0                   1/1     Running   0          47h

NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                         AGE
service/operator           ClusterIP   10.152.183.70    <none>        4222/TCP,4221/TCP               47h
service/console            ClusterIP   10.152.183.136   <none>        9090/TCP,9443/TCP               47h
service/minio              ClusterIP   10.152.183.180   <none>        80/TCP                          47h
service/microk8s-console   ClusterIP   10.152.183.221   <none>        9090/TCP                        47h
service/microk8s-hl        ClusterIP   None             <none>        9000/TCP                        47h
service/console-np         NodePort    10.152.183.112   <none>        9090:30551/TCP,9443:30552/TCP   46h

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/minio-operator   2/2     2            2           47h
deployment.apps/console          1/1     1            1           47h

NAME                                        DESIRED   CURRENT   READY   AGE
replicaset.apps/minio-operator-66847c5bd7   2         2         2       47h
replicaset.apps/console-78d567bfc8          1         1         1       47h

NAME                             READY   AGE
statefulset.apps/microk8s-ss-0   1/1     47h

## Enable

Enable
For single-node development clusters, enable the MinIO add-on with a single command:

sudo microk8s enable minio

For a more advanced use-case (see sudo microk8s enable minio:-h for a list of all supported arguments), that deploys a MinIO tenant with 300GB storage capacity using the ceph-xfs storage class:

sudo microk8s enable minio -c 300Gi -s ceph-xfs

sudo microk8s kubectl-minio tenant list
[sudo] password for brent:

Tenant 'microk8s', Namespace 'minio-operator', Total capacity 20 GiB

  Current status: Initialized
  MinIO version: minio/minio:RELEASE.2022-09-17T00-09-45Z

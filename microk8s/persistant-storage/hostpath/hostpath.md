
# https://microk8s.io/docs/addon-hostpath-storage
https://github.com/canonical/microk8s/issues/2618

The storage addon (microk8s enable storage) is not meant to be used in multi-node clusters. On a multi-node cluster storage is expected to be provided by an external to k8s service. Maybe you may want to look at openebs [1] for which we also have an addon [2].

Use Open EBS
https://www.youtube.com/watch?v=xLPRh-jJyQI

https://github.com/allyjunio/microk8s-mongodb-demo/blob/master/resources/mongodb-service.yaml


The hostpath storage MicroK8s add-on can be used to easily provision PersistentVolumes backed by a host directory. It is ideal for local development, but note that PersistentVolumeClaims created by the hostpath storage provisioner are bound to the local node, so it is impossible to move them to a different node.

https://www.server-world.info/en/note?os=Debian_11&p=microk8s&f=5

microk8s enable storage
pushd ~/src/linux-utils/microk8s/hostpath

microk8s kubectl apply -f test-pvc.yaml

Then use microk8s kubectl get pod,pvc to verify that the volume and the container were successfully created:

NAME             READY   STATUS    RESTARTS   AGE
pod/test-nginx   1/1     Running   0          32s

NAME                             STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS        AGE
persistentvolumeclaim/test-pvc   Bound    pvc-c48dbcc1-ca7e-482d-954f-b9e80119e438   1Gi        RWO            microk8s-hostp
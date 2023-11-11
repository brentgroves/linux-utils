# default storage class

<https://kubernetes.io/docs/tasks/administer-cluster/change-default-storage-class/>

Change the default StorageClass
This page shows how to change the default Storage Class that is used to provision volumes for PersistentVolumeClaims that have no special requirements.

Why change the default storage class?
Depending on the installation method, your Kubernetes cluster may be deployed with an existing StorageClass that is marked as default. This default StorageClass is then used to dynamically provision storage for PersistentVolumeClaims that do not require any specific storage class. See PersistentVolumeClaim documentation for details.

The pre-installed default StorageClass may not fit well with your expected workload; for example, it might provision storage that is too expensive. If this is the case, you can either change the default StorageClass or disable it completely to avoid dynamic provisioning of storage.

Deleting the default StorageClass may not work, as it may be re-created automatically by the addon manager running in your cluster. Please consult the docs for your installation for details about addon manager and how to disable individual addons.

Changing the default StorageClass
List the StorageClasses in your cluster:

kubectl get storageclass
NAME         PROVISIONER               RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
mayastor-3   io.openebs.csi-mayastor   Delete          WaitForFirstConsumer   false                  7d19h
mayastor     io.openebs.csi-mayastor   Delete          WaitForFirstConsumer   false                  7d19h
mayastor-2   io.openebs.csi-mayastor   Delete          WaitForFirstConsumer   false                  7d19h

The default StorageClass is marked by (default).

## Mark the default StorageClass as non-default

The default StorageClass has an annotation storageclass.kubernetes.io/is-default-class set to true. Any other value or absence of the annotation is interpreted as false.

To mark a StorageClass as non-default, you need to change its value to false:

kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'

where standard is the name of your chosen StorageClass.

## Mark a StorageClass as default

Similar to the previous step, you need to add/set the annotation storageclass.kubernetes.io/is-default-class=true.

kubectl patch storageclass mayastor -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

Please note that at most one StorageClass can be marked as default. If two or more of them are marked as default, a PersistentVolumeClaim without storageClassName explicitly specified cannot be created.

kubectl get storageclass
NAME                 PROVISIONER               RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
mayastor-3           io.openebs.csi-mayastor   Delete          WaitForFirstConsumer   false                  7d19h
mayastor-2           io.openebs.csi-mayastor   Delete          WaitForFirstConsumer   false                  7d19h
mayastor (default)   io.openebs.csi-mayastor   Delete          WaitForFirstConsumer   false                  7d19h

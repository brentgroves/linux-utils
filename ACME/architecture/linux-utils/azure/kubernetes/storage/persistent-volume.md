https://learn.microsoft.com/en-us/azure/aks/concepts-storage#azure-netapp-files
Persistent volumes
Volumes defined and created as part of the pod lifecycle only exist until you delete the pod. Pods often expect their storage to remain if a pod is rescheduled on a different host during a maintenance event, especially in StatefulSets. A persistent volume (PV) is a storage resource created and managed by the Kubernetes API that can exist beyond the lifetime of an individual pod.

You can use Azure Disks or Files to provide the PersistentVolume. As noted in the Volumes section, the choice of Disks or Files is often determined by the need for concurrent access to the data or the performance tier.

A PersistentVolume can be statically created by a cluster administrator, or dynamically created by the Kubernetes API server. If a pod is scheduled and requests currently unavailable storage, Kubernetes can create the underlying Azure Disk or Files storage and attach it to the pod. Dynamic provisioning uses a StorageClass to identify what type of Azure storage needs to be created.

 Important

Persistent volumes can't be shared by Windows and Linux pods due to differences in file system support between the two operating systems.
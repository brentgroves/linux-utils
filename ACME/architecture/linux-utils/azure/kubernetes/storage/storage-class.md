
Storage classes
To define different tiers of storage, such as Premium and Standard, you can create a StorageClass.

The StorageClass also defines the reclaimPolicy. When you delete the pod and the persistent volume is no longer required, the reclaimPolicy controls the behavior of the underlying Azure storage resource. The underlying storage resource can either be deleted or kept for use with a future pod.

For clusters using the Container Storage Interface (CSI) drivers the following extra StorageClasses are created:

https://learn.microsoft.com/en-us/azure/aks/concepts-storage#storage-classes
Permission	Reason
managed-csi	Uses Azure StandardSSD locally redundant storage (LRS) to create a Managed Disk. The reclaim policy ensures that the underlying Azure Disk is deleted when the persistent volume that used it is deleted. The storage class also configures the persistent volumes to be expandable, you just need to edit the persistent volume claim with the new size.
managed-csi-premium	Uses Azure Premium locally redundant storage (LRS) to create a Managed Disk. The reclaim policy again ensures that the underlying Azure Disk is deleted when the persistent volume that used it is deleted. Similarly, this storage class allows for persistent volumes to be expanded.
azurefile-csi	Uses Azure Standard storage to create an Azure File Share. The reclaim policy ensures that the underlying Azure File Share is deleted when the persistent volume that used it is deleted.
azurefile-csi-premium	Uses Azure Premium storage to create an Azure File Share. The reclaim policy ensures that the underlying Azure File Share is deleted when the persistent volume that used it is deleted.
azureblob-nfs-premium	Uses Azure Premium storage to create an Azure Blob storage container and connect using the NFS v3 protocol. The reclaim policy ensures that the underlying Azure Blob storage container is deleted when the persistent volume that used it is deleted.
azureblob-fuse-premium	Uses Azure Premium storage to create an Azure Blob storage container and connect using BlobFuse. The reclaim policy ensures that the underlying Azure Blob storage container is deleted when the persistent volume that used it is deleted.
Unless you specify a StorageClass for a persistent volume, the default StorageClass will be used. Ensure volumes use the appropriate storage you need when requesting persistent volumes.

You can create a StorageClass for additional needs using kubectl. The following example uses Premium Managed Disks and specifies that the underlying Azure Disk should be retained when you delete the pod:

YAML

Copy
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: managed-premium-retain
provisioner: disk.csi.azure.com
parameters:
  skuName: Premium_LRS
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true
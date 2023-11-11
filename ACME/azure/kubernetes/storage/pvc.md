https://learn.microsoft.com/en-us/azure/aks/concepts-storage#storage-classes
Once an available storage resource has been assigned to the pod requesting storage, PersistentVolume is bound to a PersistentVolumeClaim. Persistent volumes are 1:1 mapped to claims.

The following example YAML manifest shows a persistent volume claim that uses the managed-premium StorageClass and requests a Disk 5Gi in size:

YAML

Copy
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: azure-managed-disk
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: managed-premium-retain
  resources:
    requests:
      storage: 5Gi
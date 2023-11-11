https://learn.microsoft.com/en-us/azure/aks/concepts-storage
Volumes
Kubernetes typically treats individual pods as ephemeral, disposable resources. Applications have different approaches available to them for using and persisting data. A volume represents a way to store, retrieve, and persist data across pods and through the application lifecycle.

Traditional volumes are created as Kubernetes resources backed by Azure Storage. You can manually create data volumes to be assigned to pods directly, or have Kubernetes automatically create them. Data volumes can use: Azure Disks, Azure Files, Azure NetApp Files, or Azure Blobs.

Azure Files
Use Azure Files to mount a Server Message Block (SMB) version 3.1.1 share or Network File System (NFS) version 4.1 share backed by an Azure storage account to pods. Azure Files let you share data across multiple nodes and pods and can use:

Azure Premium storage backed by high-performance SSDs
Azure Standard storage backed by regular HDDs

Azure Blob Storage
Use Azure Blob Storage to create a blob storage container and mount it using the NFS v3.0 protocol or BlobFuse.

Block Blobs
Volume types
Kubernetes volumes represent more than just a traditional disk for storing and retrieving information. Kubernetes volumes can also be used as a way to inject data into a pod for use by the containers.

Common volume types in Kubernetes include:

emptyDir
Commonly used as temporary space for a pod. All containers within a pod can access the data on the volume. Data written to this volume type persists only for the lifespan of the pod. Once you delete the pod, the volume is deleted. This volume typically uses the underlying local node disk storage, though it can also exist only in the node's memory.

secret
You can use secret volumes to inject sensitive data into pods, such as passwords.

Create a Secret using the Kubernetes API.
Define your pod or deployment and request a specific Secret.
Secrets are only provided to nodes with a scheduled pod that requires them.
The Secret is stored in tmpfs, not written to disk.
When you delete the last pod on a node requiring a Secret, the Secret is deleted from the node's tmpfs.
Secrets are stored within a given namespace and can only be accessed by pods within the same namespace.
configMap
You can use configMap to inject key-value pair properties into pods, such as application configuration information. Define application configuration information as a Kubernetes resource, easily updated and applied to new instances of pods as they're deployed.

Like using a secret:

Create a ConfigMap using the Kubernetes API.
Request the ConfigMap when you define a pod or deployment.
ConfigMaps are stored within a given namespace and can only be accessed by pods within the same namespace.
https://kubernetes.io/docs/tasks/access-application-cluster/communicate-containers-same-pod-shared-volume/

Kubernetes broadly supports three categories of volumes:

Persistent volumes: storage in the Kubernetes cluster that is preprovisioned or created via dynamic provisioning using storage classes
Projected volumes: a type of storage that can map several existing volumes in the same directory
Ephemeral volumes: storage that does not persist across restarts like emptyDir (useful for logs), configMap, or secret


https://www.spectrocloud.com/blog/how-to-share-data-between-containers-with-k8s-shared-volumes/


https://www.spectrocloud.com/blog/how-to-share-data-between-containers-with-k8s-shared-volumes/
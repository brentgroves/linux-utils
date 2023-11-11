https://github.com/openebs/mayastor/issues/1082

kubectl get pvc
kubectl get pv
kubectl delete pvc test-pvc


I would like to propose you may add to the documentation how to delete volumes from a pool. I apologize in advance if this is already explained somewhere, but obviously I could not find it.
The reason for that is because the current supported provisioning is only thick, the available pool space could run out in some situations, and therefore it could be needed to remove some volumes that are not needed anymore.
What I just did is to delete the corresponding PVC and the PV using the regular kubectl, but when I checkout the volumes with the mayastor plugin (kubectl mayastor get volumes) the volumes are still there wasting space from the pool.

kubectl mayastor get volumes

A question to those experiencing this issue - is the reclaimPolicy of the corresponding StorageClass set to Delete?

If so, then the PV created during dynamic provisioning should also carry the Delete policy, and that being the case, Mayastor assets (i.e. replicas) should be deleted automatically when the PVC (and hence PV) is deleted. If that is not the case, then this is a bug that we should look into but it isn't behaviour which is currently seen during system testing of the current release.

As has been noted, setting the reclaimPolicy to anything other than Delete will lead to orphaned assets. There is currently no benefit in setting this policy to Retain, since once the corresponding PVC and/or PV have been deleted there is no way to restore access to the volume from the underlying, orphaned replicas. This is by design - Mayastor is currently predicated on dynamic provisioning and doesn't support static.

A later version of Mayastor (expected Q4 2022) will likely feature automated garbage collection of orphaned volumes (i.e. set to Retain when the PVC has been deleted).


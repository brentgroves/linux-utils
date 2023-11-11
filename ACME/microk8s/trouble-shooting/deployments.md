https://polarsquad.com/blog/check-your-kubernetes-deployments
kubectl rollout status deployment mongodb-reports31
journalctl -u kubelet
cat /var/log/syslog | grep 'mongodb'
Unable to attach or mount volumes for pod;
Error: "MountVolume.NewMounter initialization failed for volume \"mongodb-reports31-pv\" (UniqueName: \"kubernetes.io/local-volume/mongodb-reports31-pv\") pod \"mongodb-reports31-75c8795d6c-vk9z4\" (UID: \"21d1fb9f-a130-44bd-bf87-9489f5c2f708\") : path \"/mnt/mongodb\" does not exist"
<https://microk8s.io/docs/addon-minio>

Addon: MinIO
On this page
Enable
Access S3 endpoint and MinIO console
Using kubectl-minio
1.26
Compatibility: amd64 arm64
Source: See MinIO documentation

MinIO is a well-known and established project in the CNCF ecosystem that provides cloud-agnostic S3-compatible object storage. It is free, open-source and well-trusted by multiple organizations.

The minio addon can be used to deploy MinIO on a MicroK8s cluster using minio-operator, as well as the kubectl-minio CLI tool for managing the deployment. Optionally, this addon deploys a single MinIO tenant so that you can get started using it out of the box. The default tenant can be configured (storage capacity, number of volumes, security) using command-line arguments when enabling the addon (see below).

The MinIO addon can use the simple hostpath storage for single-node clusters, or any storage class you decide for multi-node clusters.

Enable
For single-node development clusters, enable the MinIO add-on with a single command:

sudo microk8s enable minio

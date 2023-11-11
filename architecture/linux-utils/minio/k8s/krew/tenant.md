# kubectl minio tenant

<https://min.io/docs/minio/kubernetes/upstream/reference/kubectl-minio-plugin/kubectl-minio-tenant.html>

kubectl minio tenant creates and manages tenants for the MinIO Operator.

Command Requires MinIO Operator

Use the following command to validate that the operator is online and available prior to running this command:

kubectl get deployments -A --field-selector metadata.name=minio-operator
NAMESPACE        NAME             READY   UP-TO-DATE   AVAILABLE   AGE
minio-operator   minio-operator   2/2     2            2           20h

Issue the kubectl minio init command to initiate the operator if it is not already running in the Kubernetes cluster.

Subcommands
The kubectl minio tenant command includes the following subcommands:
create
list
info
expand
report
upgrade
delete

kubectl minio tenant info tenant1
Tenant 'tenant1', Namespace 'example', Total capacity 10 GiB

Current status: Initialized
MinIO version: minio/minio:RELEASE.2023-10-07T15-07-38Z
MinIO service: minio/ClusterIP (port 443)
Console service: tenant1-console/ClusterIP (port 9443)

POOL    SERVERS VOLUMES(SERVER) CAPACITY(VOLUME)
0       1       4               2.5 GiB

MinIO Root User Credentials:
MINIO_ROOT_USER="2FM1SE1H11R3F7Y0443V"
MINIO_ROOT_PASSWORD="4FLx8NN1bWNF9PsEQvziSNNCPYwF7MpiKwctLQlw"

kubectl get svc tenant1-console -n example -o yaml

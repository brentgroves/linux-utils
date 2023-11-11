# Kubectl minio proxy

<https://min.io/docs/minio/kubernetes/upstream/reference/kubectl-minio-plugin/kubectl-minio-proxy.html>

kubectl minio proxy creates a temporary proxy to forward traffic from the local host machine to the MinIO Operator Console. The Operator Console provides a rich user interface for deploying and managing MinIO Tenants.

This command is an alternative to configuring Ingress to grant access to the Operator Console pods.

Command Requires MinIO Operator

Use the following command to validate that the operator is online and available prior to running this command:

kubectl get deployments -A --field-selector metadata.name=minio-operator
Issue the kubectl minio init command to initiate the operator if it is not already running in the Kubernetes cluster.

The following command creates proxy to use to access the operator graphical user interface for the myminio namespace:

kubectl minio proxy --namespace myminio

SYNTAX
Flags
The command supports the following flags:

--namespace
Optional
The namespace for which to access the operator.

Defaults to minio-operator.

# Deploy a MinIO Tenant

There may be an issue with installing the operator this way on Microk8s so it may be a good idea to use the Microk8s addon instead.
<https://microk8s.io/docs/addon-minio>

## Issue directpv

<https://github.com/minio/directpv/issues/11>

<https://min.io/docs/minio/kubernetes/upstream/operations/install-deploy-manage/deploy-minio-tenant.html#deploy-minio-distributed>

Deploy a MinIO Tenant
This procedure documents deploying a MinIO Tenant onto a stock Kubernetes cluster using the MinIO Operator Console.

The MinIO Operator Console is designed with deploying multi-node distributed MinIO Deployments.

Deploying Single-Node topologies requires additional configurations not covered in this documentation. You can alternatively use a simple Kubernetes YAML object to describe a Single-Node topology for local testing and evaluation as necessary.

MinIO does not recommend nor support single-node deployment topologies for production environments.

The Operator Console provides a rich user interface for deploying and managing MinIO Tenants on Kubernetes infrastructure. Installing the MinIO Kubernetes Operator automatically installs and configures the Operator Console.

This documentation assumes familiarity with all referenced Kubernetes concepts, utilities, and procedures. While this documentation may provide guidance for configuring or deploying Kubernetes-related resources on a best-effort basis, it is not a replacement for the official Kubernetes Documentation.

Prerequisites
MinIO Kubernetes Operator and Plugin
The procedures on this page requires a valid installation of the MinIO Kubernetes Operator and assumes the local host has a matching installation of the MinIO Kubernetes Operator. This procedure assumes the latest stable Operator and Plugin version 5.0.10.

See Deploy the MinIO Operator for complete documentation on deploying the MinIO Operator.

You can install the MinIO plugin using either the Kubernetes Krew plugin manager or manually by downloading and installing the plugin binary to your local host:

Krew Plugin Manager
Krew is a kubectl plugin manager developed by the Kubernetes SIG CLI group. See the krew installation documentation for specific instructions. You can use the Krew plugin for Linux, MacOS, and Windows operating systems.

You can use Krew to install the MinIO kubectl plugin using the following commands:

kubectl krew update
kubectl krew install minio
If you want to update the MinIO plugin with Krew, use the following command:

kubectl krew upgrade minio
You can validate the installation of the MinIO plugin using the following command:

kubectl minio version
The output should match 5.0.10.

Manual (Linux, MacOS)

Manual (Windows)

## Issue directpv

<https://github.com/minio/directpv/issues/11>

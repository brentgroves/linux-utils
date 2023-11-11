
# minio install

## references

<https://min.io/download#/kubernetes>
<https://thedatabaseme.de/2022/03/26/backup-to-s3-configure-zalando-postgres-operator-backup-with-wal-g/>
<https://thedatabaseme.de/2022/03/20/i-do-it-on-my-own-then-self-hosted-s3-object-storage-with-minio-and-docker/>
<https://minio-py.min.io/>
<https://min.io/docs/minio/linux/reference/minio-mc/mc-cp.html>

<https://microk8s.io/docs/addon-minio>
<https://min.io/docs/minio/linux/developers/minio-drivers.html#minio-drivers>

## Minio K8s docs

<https://min.io/docs/minio/kubernetes/upstream/index.html>

MinIO Object Storage for Kubernetes
MinIO is an object storage solution that provides an Amazon Web Services S3-compatible API and supports all core S3 features. MinIO is built to deploy anywhere - public or private cloud, baremetal infrastructure, orchestrated environments, and edge infrastructure.

This site documents Operations, Administration, and Development of MinIO deployments on Kubernetes platform for the latest stable version of the MinIO Operator: 5.0.10.

MinIO is released under dual license GNU Affero General Public License v3.0 and MinIO Commercial License. Deployments registered through MinIO SUBNET use the commercial license and include access to 24/7 MinIO support.

You can get started exploring MinIO features using our play server at <https://play.min.io>. play is a public MinIO cluster running the latest stable MinIO server. Any file uploaded to play should be considered public and non-protected.

Quickstart: MinIO for Kubernetes
This procedure deploys a Single-Node Single-Drive MinIO server onto Kubernetes for early development and evaluation of MinIO Object Storage and its S3-compatible API layer.

Use the MinIO Operator to deploy and manage production-ready MinIO tenants on Kubernetes.

Prerequisites
An existing Kubernetes deployment where at least one Worker Node has a locally-attached drive.

A local kubectl installation configured to create and access resources on the target Kubernetes deployment.

Familiarity with Kubernetes environments

Familiarity with using a Terminal or Shell environment

Procedure
Download the MinIO Object

Download the MinIO Kubernetes Object Definition
Download minio-dev.yaml to your host machine:

```bash
curl https://raw.githubusercontent.com/minio/docs/master/source/extra/examples/minio-dev.yaml -O
```

The file describes two Kubernetes resources:

A new namespace minio-dev, and

A MinIO pod using a drive or volume on the Worker Node for serving data

Select the overview of the minio object yaml for a more detailed description of the object.

Overview of the MinIO Object YAML

Apply the MinIO Object Definition

The following command applies the minio-dev.yaml configuration and deploys the objects to Kubernetes:

kubectl apply -f minio-dev.yaml
The command output should resemble the following:

namespace/minio-dev created
pod/minio created
You can verify the state of the pod by running kubectl get pods:

kubectl get pods -n minio-dev
The output should resemble the following:

NAME    READY   STATUS    RESTARTS   AGE
minio   1/1     Running   0          77s
You can also use the following commands to retrieve detailed information on the pod status:

kubectl describe pod/minio -n minio-dev

kubectl logs pod/minio -n minio-dev

Temporarily Access the MinIO S3 API and Console

Use the kubectl port-forward command to temporarily forward traffic from the MinIO pod to the local machine:

kubectl port-forward pod/minio 9000 9090 -n minio-dev
The command forwards the pod ports 9000 and 9090 to the matching port on the local machine while active in the shell. The kubectl port-forward command only functions while active in the shell session. Terminating the session closes the ports on the local machine.

Note

The following steps of this procedure assume an active kubectl port-forward command.

To configure long term access to the pod, configure Ingress or similar network control components within Kubernetes to route traffic to and from the pod. Configuring Ingress is out of the scope for this documentation.

Connect your Browser to the MinIO Server

Access the MinIO Console by opening a browser on the local machine and navigating to <http://127.0.0.1:9090>.

Log in to the Console with the credentials minioadmin | minioadmin. These are the default root user credentials.

You can use the MinIO Console for general administration tasks like Identity and Access Management, Metrics and Log Monitoring, or Server Configuration. Each MinIO server includes its own embedded MinIO Console.

<https://min.io/docs/minio/kubernetes/upstream/administration/minio-console.html#minio-console>

Connect the MinIO Client

If your local machine has mc installed, use the mc alias set command to authenticate and connect to the MinIO deployment:

mc alias set k8s-minio-dev <http://127.0.0.1:9000> minioadmin minioadmin
mc admin info k8s-minio-dev
The name of the alias

The hostname or IP address and port of the MinIO server

The Access Key for a MinIO user

The Secret Key for a MinIO user

<https://min.io/docs/minio/linux/developers/minio-drivers.html#minio-drivers>

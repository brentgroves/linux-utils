<https://min.io/download#/kubernetes>

Overview
MinIO is a Kubernetes-native high performance object store with an S3-compatible API. The MinIO Kubernetes Operator supports deploying MinIO Tenants onto private and public cloud infrastructures (“Hybrid” Cloud).

The following procedure installs the latest stable version (5.0.10) of the MinIO Operator and MinIO Plugin on Kubernetes infrastructure:

The MinIO Operator installs a Custom Resource Definition (CRD) to support describing MinIO tenants as a Kubernetes object. See the MinIO Operator CRD Reference for complete documentation on the MinIO CRD.

The MinIO Kubernetes Plugin brings native support for deploying and managing MinIO tenants on a Kubernetes cluster using the kubectl minio command.

This documentation assumes familiarity with referenced Kubernetes concepts, utilities, and procedures. While this documentation may provide guidance for configuring or deploying Kubernetes-related resources on a best-effort basis, it is not a replacement for the official Kubernetes Documentation.

kubectl describe deployment minio-operator -n minio-operator
Name:                   minio-operator
Namespace:              minio-operator
CreationTimestamp:      Sat, 28 Oct 2023 17:23:25 -0400
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 1
                        operator.min.io/authors: MinIO, Inc.
                        operator.min.io/license: AGPLv3
                        operator.min.io/support: <https://subnet.min.io>
Selector:               name=minio-operator
Replicas:               2 desired | 2 updated | 2 total | 2 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:           name=minio-operator
  Annotations:      operator.min.io/authors: MinIO, Inc.
                    operator.min.io/license: AGPLv3
                    operator.min.io/support: <https://subnet.min.io>
  Service Account:  minio-operator
  Containers:
   minio-operator:
    Image:      minio/operator:v4.5.1
    Port:       <none>
    Host Port:  <none>
    Requests:
      cpu:                200m
      ephemeral-storage:  500Mi
      memory:             256Mi
    Environment:
      CLUSTER_DOMAIN:  cluster.local
    Mounts:            <none>
  Volumes:             <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   minio-operator-66847c5bd7 (2/2 replicas created)
Events:          <none>

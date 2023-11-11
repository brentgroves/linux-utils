# Postgres operator

**[Postgres operator](https://postgres-operator.readthedocs.io/en/latest/)**
**[Zalando Blog Series](https://thedatabaseme.de/tag/zalando-operator/)**

## Status

Status
This project is currently in active development. It is however already used internally by Zalando in order to run Postgres clusters on K8s in larger numbers for staging environments and a growing number of production clusters. In this environment the operator is deployed to multiple K8s clusters, where users deploy manifests via our CI/CD infrastructure or rely on a slim user interface to create manifests.

Please, report any issues discovered to <https://github.com/zalando/postgres-operator/issues>.

## The Postgres operator manages PostgreSQL clusters on Kubernetes (K8s)

The operator watches additions, updates, and deletions of PostgreSQL cluster manifests and changes the running clusters accordingly. For example, when a user submits a new manifest, the operator fetches that manifest and spawns a new Postgres cluster along with all necessary entities such as K8s StatefulSets and Postgres roles. See this Postgres cluster manifest for settings that a manifest may contain.

The operator also watches updates to its own configuration and alters running Postgres clusters if necessary. For instance, if the Docker image in a pod is changed, the operator carries out the rolling update, which means it re-spawns pods of each managed StatefulSet one-by-one with the new Docker image.

Finally, the operator periodically synchronizes the actual state of each Postgres cluster with the desired state defined in the cluster's manifest.

The operator aims to be hands free as configuration works only via manifests. This enables easy integration in automated deploy pipelines with no access to K8s directly.

### Scope

The scope of the Postgres Operator is on provisioning, modifying configuration and cleaning up Postgres clusters that use Patroni, basically to make it easy and convenient to run Patroni based clusters on K8s. The provisioning and modifying includes K8s resources on one side but also e.g. database and role provisioning once the cluster is up and running. We try to leave as much work as possible to K8s and to Patroni where it fits, especially the cluster bootstrap and high availability. The operator is however involved in some overarching orchestration, like rolling updates to improve the user experience.

Monitoring or tuning Postgres is not in scope of the operator in the current state. However, with globally configurable sidecars we provide enough flexibility to complement it with other tools like ZMON, Prometheus or more Postgres specific options.

### What is Patroni

Patroni is an open-source tool that helps to deploy, manage, and monitor highly available PostgreSQL clusters using physical streaming replication. The Patroni daemon runs on all nodes of PostgreSQL cluster, monitors the state of Postgres process(es), and publishes the state to the Distributed Key-Value Store.

## Overview of involved entities

Here is a diagram, that summarizes what would be created by the operator, when a new Postgres cluster CRD is submitted:

**![Postgres Operator Entity Diagram](https://postgres-operator.readthedocs.io/en/latest/diagrams/operator.png)**

This picture is not complete without an overview of what is inside a single cluster pod, so let's zoom in:

**![Postgres Operator Pod Diagram](https://postgres-operator.readthedocs.io/en/latest/diagrams/pod.png)**

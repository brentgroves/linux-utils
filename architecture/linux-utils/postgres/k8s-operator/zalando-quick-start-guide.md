# Zalando Postgres Operator deployment

<https://postgres-operator.readthedocs.io/en/latest/quickstart/>

## Deployment options

The Postgres Operator can be deployed in the following ways:

Manual deployment
Kustomization
Helm chart
Manual deployment setup on Kubernetes
The Postgres Operator can be installed simply by applying yaml manifests. Note, we provide the /manifests directory as an example only; you should consider adjusting the manifests to your K8s environment (e.g. namespaces).

<https://juan-medina.com/2019/12/12/postgresql-k8s/>

## First, clone the repository and change to the directory

```bash
git clone <https://github.com/zalando/postgres-operator.git>
cd postgres-operator
rm -rf .git
```

## Now we will install the operator using the manifests

```bash
# apply the manifests in the following order
kubectl create -f manifests/configmap.yaml  # configuration
configmap/postgres-operator created

kubectl create -f manifests/operator-service-account-rbac.yaml  # 
serviceaccount/postgres-operator created
clusterrole.rbac.authorization.k8s.io/postgres-operator created
clusterrolebinding.rbac.authorization.k8s.io/postgres-operator created
clusterrole.rbac.authorization.k8s.io/postgres-pod created

kubectl create -f manifests/postgres-operator.yaml  # deployment
deployment.apps/postgres-operator created

kubectl create -f manifests/api-service.yaml  # operator API to be used by UI
service/postgres-operator created

# Now to check that the operator has started we could do:

kubectl get pod -l name=postgres-operator
NAME                                READY   STATUS    RESTARTS       AGE
postgres-operator-77f6d658c-mtnt4   1/1     Running   1 (3m6s ago)   3m21s
```

## Create a Postgres cluster

If the operator pod is running it listens to new events regarding postgresql resources. Now, it's time to submit your first Postgres cluster manifest.

```bash
kubectl create -f manifests/minimal-postgres-manifest.yaml
postgresql.acid.zalan.do/acid-minimal-cluster created
```

After the cluster manifest is submitted and passed the validation the operator will create Service and Endpoint resources and a StatefulSet which spins up new Pod(s) given the number of instances specified in the manifest. All resources are named like the cluster. The database pods can be identified by their number suffix, starting from -0. They run the Spilo container image by Zalando. As for the services and endpoints, there will be one for the master pod and another one for all the replicas (-repl suffix). Check if all components are coming up. Use the label application=spilo to filter and list the label spilo-role to see who is currently the master.

```bash
# check the deployed cluster
kubectl get postgresql
NAME                   TEAM   VERSION   PODS   VOLUME   CPU-REQUEST   MEMORY-REQUEST   AGE   STATUS
acid-minimal-cluster   acid   15        2      1Gi                                     98s   Creating

# check created database pods
kubectl get pods -l application=spilo -L spilo-role
acid-minimal-cluster-0   1/1     Running   0          2m30s   
acid-minimal-cluster-1   1/1     Running   0          104s    

# check created service resources
kubectl get svc -l application=spilo -L spilo-role
NAME                          TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE     SPILO-ROLE
acid-minimal-cluster          ClusterIP   10.152.183.165   <none>        5432/TCP   2m51s   master
acid-minimal-cluster-repl     ClusterIP   10.152.183.132   <none>        5432/TCP   2m51s   replica
acid-minimal-cluster-config   ClusterIP   None             <none>        <none>     2m1s 
```

## Connect to the Postgres cluster via psql

You can create a port-forward on a database pod to connect to Postgres. See the user guide for instructions. With minikube it's also easy to retrieve the connections string from the K8s service that is pointing to the master pod:

```bash
export HOST_PORT=$(minikube service acid-minimal-cluster --url | sed 's,.*/,,')
export PGHOST=$(echo $HOST_PORT | cut -d: -f 1)
export PGPORT=$(echo $HOST_PORT | cut -d: -f 2)
```

## Creating a Database

Operators work with resource, when we provide to k8s a resource with the data for a register operator it will use it to install it.

For example les create a database named movies with and admin user name moviesdba and a user named moviesuser. For this we will create a file that will could name movies-db.yml :

```yaml
apiVersion: "acid.zalan.do/v1"
kind: postgresql
metadata:
  name: movies-db-cluster
  namespace: default
spec:
  teamId: "movies"
  volume:
    size: 1Gi
  numberOfInstances: 2
  users:
    moviesdba:  # database owner
    - superuser
    - createdb
    moviesuser: []  # roles
  databases:
    movies: moviesdba  # dbname: owner
  postgresql:
    version: "11"
```

## didn't do this from the official guide

There is a Kustomization manifest that combines the mentioned resources (except for the CRD) - it can be used with kubectl 1.14 or newer as easy as:

kubectl apply -k github.com/zalando/postgres-operator/manifests
For convenience, we have automated starting the operator with minikube using the run_operator_locally script. It applies the acid-minimal-cluster. manifest.

./run_operator_locally.sh

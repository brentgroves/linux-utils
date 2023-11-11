https://stackoverflow.com/questions/47128586/how-to-delete-all-resources-from-kubernetes-one-time
This option is best according to the article
kubectl delete namespace {namespace}
kubectl create namespace {namespace}

Method 1: To delete everything from the current namespace (which is normally the default namespace) using kubectl delete:

kubectl delete all --all
all refers to all resource types such as pods, deployments, services, etc. --all is used to delete every object of that resource type instead of specifying it using its name or label.

To delete everything from a certain namespace you use the -n flag:

kubectl delete all --all -n {namespace}
Method 2: You can also delete a namespace and re-create it. This will delete everything that belongs to it:

kubectl delete namespace {namespace}
kubectl create namespace {namespace}

Kubernetes Namespace would be the perfect options for you. You can easily create namespace resource.

kubectl create -f custom-namespace.yaml

$  apiVersion: v1
    kind: Namespace
    metadata:
      name:custom-namespace
Now you can deploy all of the other resources(Deployment,ReplicaSet,Services etc) in that custom namespaces.

If you want to delete all of these resources, you just need to delete custom namespace. by deleting custom namespace, all of the other resources would be deleted. Without it, ReplicaSet might create new pods when existing pods are deleted.

To work with Namespace, you need to add --namespace flag to k8s commands.

For example:

kubectl create -f deployment.yaml --namespace=custom-namespace

you can list all the pods in custom-namespace.

kubectl get pods --namespace=custom-namespace
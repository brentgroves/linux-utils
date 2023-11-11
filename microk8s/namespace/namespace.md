https://www.aquasec.com/cloud-native-academy/kubernetes-101/kubernetes-namespace/

Specify a namespace in the YAML specification of the resource. Here is what it looks like in a pod specification:
apiVersion: v1
kind: Pod
metadata:
  name: mypod
  namespace: mynamespace
  labels:
    name: mypod
    
https://cloud.google.com/blog/products/containers-kubernetes/kubernetes-best-practices-organizing-with-namespaces
Creating a Namespace can be done with a single command. If you wanted to create a Namespace called ‘test’ you would run:

kubectl create namespace test
Or you can create a YAML file and apply it just like any other Kubernetes resource.

test.yaml:

​
kind: Namespace
apiVersion: v1
metadata:
  name: test
  labels:
    name: test
kubectl apply -f test.yaml



https://assistanz.com/steps-to-create-custom-namespace-in-the-kubernetes/
kubectl apply -f namespace.yml

CREATE A NEW POD IN CUSTOM NAMESPACE
 
Use the kubectl command to create a POD
Syntax: kubectl run --image= --port= --generator=run-pod/v1 -n

Example: kubectl run ns-pod --image=nginx --port=80 --generator=run-pod/v1 -n aznamespace

Verify the pod details using the below command.
Syntax: kubecl get pods --namespace

Example: kubectl get pods --namespace aznamespace

DELETING THE NAMESPACE
 
To delete all the pods in a namespace.
Syntax: kubectl delete pods --all --namespace

Example: kubectl delete pods --all --namespace aznamespace

To delete a namespace.
Syntax: kubectl delete namespace

Example: kubectl delete namespace aznamespace


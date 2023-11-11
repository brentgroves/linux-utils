https://cloud.google.com/blog/products/containers-kubernetes/kubernetes-best-practices-organizing-with-namespaces
Creating Resources in the Namespace

One way is to set the “namespace” flag when creating the resource:

kubectl apply -f pod.yaml --namespace=test

You can also specify a Namespace in the YAML declaration.

​
apiVersion: v1
kind: Pod
metadata:
  name: mypod
  namespace: test
  labels:
    name: mypod
spec:
  containers:
  - name: mypod
    image: nginx
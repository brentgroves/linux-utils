https://learnk8s.io/templating-yaml-with-code

Templating with yq
yq takes a YAML file as input and can:

read values from the file
add new values
updated existing values
generate new YAML files
covert YAML into JSON
merge two or more YAML files
Let's have a look at the same Pod definition:

pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
  - name: test-container
    image: k8s.gcr.io/busybox
    env:
    - name: DB_URL
      value: postgres://db_url:5432

You could read the value for the environment variable ENV with:

bash
yq r pod.yaml "spec.containers[0].env[0].value"
postgres://db_url:5432

You can use the following command:

bash
yq w pod.yaml "spec.containers[0].env[0].value" "postgres://prod:5432"
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
  - name: test-container
    image: k8s.gcr.io/busybox
    env:
    - name: DB_URL
      value: postgres://prod:5432

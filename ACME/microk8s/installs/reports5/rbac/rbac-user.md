<https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md>

Creating sample user
In this guide, we will find out how to create a new user using the Service Account mechanism of Kubernetes, grant this user admin permissions and login to Dashboard using a bearer token tied to this user.

IMPORTANT: Make sure that you know what you are doing before proceeding. Granting admin privileges to Dashboard's Service Account might be a security risk.

For each of the following snippets for ServiceAccount and ClusterRoleBinding, you should copy them to new manifest files like dashboard-adminuser.yaml and use kubectl apply -f dashboard-adminuser.yaml to create them.

Creating a Service Account
We are creating Service Account with the name admin-user in namespace kubernetes-dashboard first.

apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard

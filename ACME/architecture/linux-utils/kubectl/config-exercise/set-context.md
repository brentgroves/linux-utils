https://www.containiq.com/post/kubectl-config-set-context-tutorial-and-best-practices
kubectl config set-context --current --namespace=mysql

kubectl config view

kubectl config set-context --help

Set a context entry in kubeconfig.

Specifying a name that already exists will merge new fields on top of existing values for those fields.

Examples:
  # Set the user field on the gce context entry without touching other values
  kubectl config set-context gce --user=cluster-admin

What this says is that you can create or modify contexts in your kubeconfig file with the command kubectl config set-context. This command also accepts the name of the context to be changed (or --current if you want to change the current context), as well as --user, --cluster, and --namespace options. If the specified context already exists in the kubeconfig, this command is going to modify that entry with the parameters that are passed.


Basic Usage of kubectl config set-context
Before you start modifying your kubeconfig, it’s helpful to know how to display its content. To do this, you can to use the following command:


kubectl config view


he template to create or modify a context is as follows:


kubectl config set-context \
<CONTEXT_NAME> \
--namespace=<NAMESPACE_NAME> \
--cluster=<CLUSTER_NAME> \
--user=<USER_NAME>

# Shows which is the active context
kubectl config current-context

# Allows you to switch between contexts using their name
kubectl config use-context <CONTEXT_NAME>

Advanced Usage of kubectl config set-context
In this section, you’ll look at how to configure access to other clusters in a more complex situation. There are scenarios where you can leverage the kubectl config set-context command to simplify your workflow.

As you may have already noticed, kubectl config set-context is only one of many commands that help you work with the kubeconfig file. Specifically, kubectl config set-context only modifies the section of kubeconfig corresponding to the context.


The following commands are the commands that allow you to add or modify cluster access and user credentials in your kubeconfig. You might notice some similarity to kubectl config set-context in its structure.

To add or modify a cluster, you can use the following template:


# Add or modify a cluster
kubectl config set-cluster \
<CLUSTER_NAME> \
--server=<SERVER_ADDRESS> \
--certificate-authority=<CLUSTER_CERTIFICATE>



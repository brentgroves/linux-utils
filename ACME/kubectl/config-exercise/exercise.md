https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/
https://kubernetes.io/docs/tasks/administer-cluster/namespaces-walkthrough/
# Set the current context:
# kubectl config --kubeconfig=config-demo use-context dev-frontend
# Add context details to your configuration file:
# kubectl config --kubeconfig=reports3.yaml set-context mayastor --cluster=microk8s-cluster --namespace=mayastor --user=admin

A configuration file describes clusters, users, and contexts. Your config-demo file has the framework to describe two clusters, two users, and three contexts.

Go to your config-exercise directory. Enter these commands to add cluster details to your configuration file:
pushd ~/src/linux-utils/kubectl/config-exercise
kubectl config --kubeconfig=config-demo set-cluster development --server=https://1.2.3.4 --certificate-authority=fake-ca-file
kubectl config --kubeconfig=config-demo set-cluster scratch --server=https://5.6.7.8 --insecure-skip-tls-verify
kubectl config view
Add user details to your configuration file:

Caution: Storing passwords in Kubernetes client config is risky. A better alternative would be to use a credential plugin and store them separately. See: client-go credential plugins
kubectl config --kubeconfig=config-demo set-credentials developer --client-certificate=fake-cert-file --client-key=fake-key-seefile
kubectl config --kubeconfig=config-demo set-credentials experimenter --username=exp --password=some-password

To delete a user you can run kubectl --kubeconfig=config-demo config unset users.<name>
To remove a cluster, you can run kubectl --kubeconfig=config-demo config unset clusters.<name>
To remove a context, you can run kubectl --kubeconfig=config-demo config unset contexts.<name>

Add context details to your configuration file:

kubectl config --kubeconfig=config-demo set-context dev-frontend --cluster=development --namespace=frontend --user=developer
kubectl config --kubeconfig=config-demo set-context dev-storage --cluster=development --namespace=storage --user=developer
kubectl config --kubeconfig=config-demo set-context exp-scratch --cluster=scratch --namespace=default --user=experimenter

Open your config-demo file to see the added details. As an alternative to opening the config-demo file, you can use the config view command.

    # Documentation note (this comment is NOT part of the command output).
    # Storing passwords in Kubernetes client config is risky.
    # A better alternative would be to use a credential plugin
    # and store the credentials separately.
    # See https://kubernetes.io/docs/reference/access-authn-authz/authentication/#client-go-credential-plugins

kubectl config --kubeconfig=config-demo view

The fake-ca-file, fake-cert-file and fake-key-file above are the placeholders for the pathnames of the certificate files. You need to change these to the actual pathnames of certificate files in your environment.

Sometimes you may want to use Base64-encoded data embedded here instead of separate certificate files; in that case you need to add the suffix -data to the keys, for example, certificate-authority-data, client-certificate-data, client-key-data.

Each context is a triple (cluster, user, namespace). For example, the dev-frontend context says, "Use the credentials of the developer user to access the frontend namespace of the development cluster".

Set the current context:
kubectl config --kubeconfig=config-demo use-context dev-frontend

https://kubernetes.io/docs/tasks/access-application-cluster/configure-access-multiple-clusters/


Create a second configuration file
In your config-exercise directory, create a file named config-demo-2 with this content:

apiVersion: v1
kind: Config
preferences: {}

contexts:
- context:
    cluster: development
    namespace: ramp
    user: developer
  name: dev-ramp-up


The preceding configuration file defines a new context named dev-ramp-up.

Set the KUBECONFIG environment variable
See whether you have an environment variable named KUBECONFIG. If so, save the current value of your KUBECONFIG environment variable, so you can restore it later. For example:

Linux
export KUBECONFIG_SAVED="$KUBECONFIG"  
export $KUBECONFIG_SAVED="$KUBECONFIG"  

The KUBECONFIG environment variable is a list of paths to configuration files. The list is colon-delimited for Linux and Mac, and semicolon-delimited for Windows. If you have a KUBECONFIG environment variable, familiarize yourself with the configuration files in the list.

Temporarily append two paths to your KUBECONFIG environment variable. For example:

Linux
export KUBECONFIG="${KUBECONFIG}:config-demo:config-demo-2"
export KUBECONFIG="/home/brent/.kube/config:config-demo:config-demo-2"
export KUBECONFIG="/home/brent/.kube/config"

In your config-exercise directory, enter this command:
kubectl config view

The output shows merged information from all the files listed in your KUBECONFIG environment variable. In particular, notice that the merged information has the dev-ramp-up context from the config-demo-2 file and the three contexts from the config-demo file:

Explore the $HOME/.kube directory
If you already have a cluster, and you can use kubectl to interact with the cluster, then you probably have a file named config in the $HOME/.kube directory.

Go to $HOME/.kube, and see what files are there. Typically, there is a file named config. There might also be other configuration files in this directory. Briefly familiarize yourself with the contents of these files.

Append $HOME/.kube/config to your KUBECONFIG environment variable 
If you have a $HOME/.kube/config file, and it's not already listed in your KUBECONFIG environment variable, append it to your KUBECONFIG environment variable now. For example:

Linux
export KUBECONFIG="${KUBECONFIG}:${HOME}/.kube/config"

Organizing Cluster Access Using kubeconfig Files
Use kubeconfig files to organize information about clusters, users, namespaces, and authentication mechanisms. The kubectl command-line tool uses kubeconfig files to find the information it needs to choose a cluster and communicate with the API server of a cluster.

By default, kubectl looks for a file named config in the $HOME/.kube directory. You can specify other kubeconfig files by setting the KUBECONFIG environment variable or by setting the --kubeconfig flag.

Supporting multiple clusters, users, and authentication mechanisms 
Suppose you have several clusters, and your users and components authenticate in a variety of ways. For example:

A running kubelet might authenticate using certificates.
A user might authenticate using tokens.
Administrators might have sets of certificates that they provide to individual users.
With kubeconfig files, you can organize your clusters, users, and namespaces. You can also define contexts to quickly and easily switch between clusters and namespaces.

Context
A context element in a kubeconfig file is used to group access parameters under a convenient name. Each context has three parameters: cluster, namespace, and user. By default, the kubectl command-line tool uses parameters from the current context to communicate with the cluster.

To choose the current context:
kubectl config use-context

The KUBECONFIG environment variable 
The KUBECONFIG environment variable holds a list of kubeconfig files. For Linux and Mac, the list is colon-delimited. For Windows, the list is semicolon-delimited. The KUBECONFIG environment variable is not required. If the KUBECONFIG environment variable doesn't exist, kubectl uses the default kubeconfig file, $HOME/.kube/config.

If the KUBECONFIG environment variable does exist, kubectl uses an effective configuration that is the result of merging the files listed in the KUBECONFIG environment variable.


Merging kubeconfig files
To see your configuration, enter this command:

kubectl config view
As described previously, the output might be from a single kubeconfig file, or it might be the result of merging several kubeconfig files.

Here are the rules that kubectl uses when it merges kubeconfig files:

If the --kubeconfig flag is set, use only the specified file. Do not merge. Only one instance of this flag is allowed.

Otherwise, if the KUBECONFIG environment variable is set, use it as a list of files that should be merged. Merge the files listed in the KUBECONFIG environment variable according to these rules:

Ignore empty filenames.
Produce errors for files with content that cannot be deserialized.
The first file to set a particular value or map key wins.
Never change the value or map key. Example: Preserve the context of the first file to set current-context. Example: If two files specify a red-user, use only values from the first file's red-user. Even if the second file has non-conflicting entries under red-user, discard them.

For an example of setting the KUBECONFIG environment variable, see Setting the KUBECONFIG environment variable.

Otherwise, use the default kubeconfig file, $HOME/.kube/config, with no merging.

Determine the context to use based on the first hit in this chain:

Use the --context command-line flag if it exists.
Use the current-context from the merged kubeconfig files.
An empty context is allowed at this point.

~/.kube/config
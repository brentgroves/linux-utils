https://mayastor.gitbook.io/introduction/reference/kubectl-plugin
https://kubernetes.io/docs/tasks/extend-kubectl/kubectl-plugins/
download a version with the binary in assets at  
https://github.com/openebs/mayastor-control-plane/releases

lftp brent@moto
get /home/brent/Downloads/kubectl-mayastor 
sudo chmod +x ./kubectl-mayastor
# move the plugin into your $PATH
sudo mv ./kubectl-mayastor /usr/local/bin
# check that kubectl recognizes your plugin
kubectl plugin list

# You can now invoke your plugin via kubectl:
kubectl mayastor

kubectl mayastor get volumes

Mayastor Kubectl Plugin
The ‘Mayastor kubectl plugin’ can be used to view and manage Mayastor resources such as nodes, pools and volumes. It is also used for operations such as scaling the replica count of volumes.
Prerequisites
Ensure that port 30011 is open. This port will be needed by Mayastor kubectl plugin to communicate to REST servers from outside the cluster.
The plugin requires access to the Mayastor REST server for execution. It usually obtains the correct endpoint from the kube-config file on its own. However, if the plugin is unable to access the endpoint, the master nodes's IP needs to be specified manually using the --rest or -r flag.
kubectl mayastor [OPTIONS] --rest=http://:30011
Installation
The Mayastor kubectl plugin is available for the Linux platform. The binary for the plugin can be found .
Add the downloaded Mayastor kubectl plugin under $PATH.
To verify the installation, execute:
kubectl mayastor -V
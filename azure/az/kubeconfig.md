Using the parameter -v allows you to bind a local directory. -v or --volume allows you to mount local directories and files to your container. For example, you can start a MySQL database and mount the data directory to store the actual data in your mounted directory.
-w is for the working directory
docker run -it --rm -v ${PWD}:/work -w /work --entrypoint /bin/sh mcr.microsoft.com/azure-cli:2.6.0


az aks get-credentials -n aks-getting-started \
--resource-group $RESOURCEGROUP

#grab the config if you want it
cp ~/.kube/config .
exit
cd kubernetes/cloud/azure
cp ./config ~/.kube/aks-getting-started.yaml
ls ~/.kube

scc.sh aks-getting-started.yaml aks-getting-started

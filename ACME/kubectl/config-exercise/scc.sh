#!/bin/bash
# ./scc.sh reports3.yaml mayastor

cluster=$1
context=$2

printf "\nset-cluster-context cluster: $cluster" 
printf "\nset-cluster-context cluster: $context\n" 

rm ~/.kube/config
cp ~/.kube/$cluster ~/.kube/config
kubectl config use-context $context

# Set the current context:
# kubectl config --kubeconfig=config-demo use-context dev-frontend
# Add context details to your configuration file:
# kubectl config --kubeconfig=reports3.yaml set-context mayastor --cluster=microk8s-cluster --namespace=mayastor --user=admin
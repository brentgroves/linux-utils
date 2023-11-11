#!/bin/bash
export ACRNAME=mobexcr
export AKSCLUSTER=reports-aks
export RESOURCEGROUP=reports-aks
export NODERESOURCEGROUP=MC_reports-aks_reports-aks_centralus
export STATIC_IP=23.101.116.170
export PUBLICIPID="/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/mc_reports-aks_reports-aks_centralus/providers/Microsoft.Network/publicIPAddresses/ingressAKSPublicIP"
export NAMESPACE="ingress-nginx"
export DNS_LABEL="reports-ingress"

# for helm chart image import command
export REGISTRY_NAME=mobexcr
export SOURCE_REGISTRY=k8s.gcr.io
export CONTROLLER_IMAGE=ingress-nginx/controller
export CONTROLLER_TAG=v1.2.1
export PATCH_IMAGE=ingress-nginx/kube-webhook-certgen
export PATCH_TAG=v1.1.1
export DEFAULTBACKEND_IMAGE=defaultbackend-amd64
export DEFAULTBACKEND_TAG=1.5

# for cert manager install 
export REGISTRY_NAME=mobexcr
export CERT_MANAGER_REGISTRY=quay.io
export CERT_MANAGER_TAG=v1.8.0
export CERT_MANAGER_IMAGE_CONTROLLER=jetstack/cert-manager-controller
export CERT_MANAGER_IMAGE_WEBHOOK=jetstack/cert-manager-webhook
export CERT_MANAGER_IMAGE_CAINJECTOR=jetstack/cert-manager-cainjector

export ACR_URL=mobexcr.azurecr.io

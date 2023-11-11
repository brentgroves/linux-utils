https://stackoverflow.com/questions/65993187/whats-the-index-url-for-helm-charts-added-to-acr

ACR location to use for pulling images

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo list
NAME         	URL                                       
ingress-nginx	https://kubernetes.github.io/ingress-nginx
jetstack     	https://charts.jetstack.io                
nginx-stable 	https://helm.nginx.com/stable 


https://github.com/Azure/acr/issues/653
What is the problem you're trying to solve
Right now, if you use Helm 3, you cannot add ACR as a native helm repo with "helm repo add my-acr-repo https://my-acr-repo.azurecr.io" as the URL is not exposed as a valid helm repo URL.
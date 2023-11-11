# remove microk8s
snap info microk8s
microk8s stop
sudo snap remove microk8s --purge
reboot

https://microk8s.io/docs/addon-mayastor

HugePages must be enabled. Mayastor requires at least 1024 4MB HugePages.
sudo sysctl vm.nr_hugepages=1048
echo 'vm.nr_hugepages=1048' | sudo tee -a /etc/sysctl.conf
cat /etc/sysctl.conf
brent@reports32:~$ grep HugePages /proc/meminfo
AnonHugePages:     12288 kB
ShmemHugePages:        0 kB
FileHugePages:         0 kB
HugePages_Total:    1048
HugePages_Free:     1048
HugePages_Rsvd:        0
HugePages_Surp:        0

brent@reports32:~$ egrep "MemTotal|MemFree|Cached" /proc/meminfo
MemTotal:        8024644 kB
MemFree:         2834144 kB
Cached:          2090252 kB
SwapCached:            0 kB


sudo apt install linux-modules-extra-$(uname -r)

sudo modprobe nvme_tcp
echo 'nvme-tcp' | sudo tee -a /etc/modules-load.d/microk8s-mayastor.conf
cat /etc/modules-load.d/microk8s-mayastor.conf

https://microk8s.io/docs/nfs

10.1.0.117/22
10.1.0.0/22
sudo mkdir -p /srv/nfs
sudo chmod 0777 /srv/nfs
echo '/srv/nfs 10.1.0.0/22(rw,sync,no_subtree_check)' | sudo tee /etc/exports
sudo systemctl restart nfs-kernel-server
kubectl get pod -n kube-system

sudo snap install microk8s --classic --channel=1.26/stable  
sudo snap install microk8s --classic --channel=1.26/edge
sudo usermod -a -G microk8s $USER  
sudo chown -f -R $USER ~/.kube  
newgrp microk8s  
sudo reboot  




https://microk8s.io/docs/setting-snap-channel
sudo snap install microk8s --classic --channel=1.26/stable
sudo snap install microk8s --classic --channel=1.26/edge

https://microk8s.io/#install-microk8s
sudo snap install microk8s --classic --channel=1.21
https://ubuntu.com/blog/kubernetes-storage-microk8s-mayastor
microk8s.kubectl logs -n mayastor daemonset/mayastor
sudo snap install microk8s --classic --channel latest/edge
latest/edge
sudo snap install microk8s --classic --channel=1.24
sudo snap install microk8s --classic --channel=1.25
sudo snap install microk8s --classic --channel=1.26 // did not work
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
newgrp microk8s

I believe this is in the dotfiles
alias kubectl='microk8s kubectl'

# verify everything is ok
microk8s status
microk8s inspect
Do what inspect tells you to do.m

{
    "insecure-registries" : ["localhost:32000"] 
}

ping all the ip addresses in cluster

# Add nodes to cluster
https://microk8s.io/docs/clustering

microk8s add-node
microk8s join 10.1.0.116:25000/b31163fe46638a311c24571384003ab4/b65150307875


cd ~/ftp
nvim copy.txt
copy/paste join command into copy.txt
# This command takes one file from local directory and uploads it to server. We will upload file test1.
lftp brent@reports32:~> put copy.txt


# verify everything is ok
kubectl get no
microk8s status

Verify nodes have been added
kubectl get node -o wide
All nodes are shown as master nodes with microk8s status.

# Enable the necessary MicroK8s Add ons: 
microk8s enable dns 
microk8s enable helm3
microk8s enable rbac 

This addon adds an NGINX Ingress Controller for MicroK8s. It is enabled by running the command:
https://microk8s.io/docs/addon-ingress
# enables primary NGINX ingress controller
microk8s enable ingress
# wait for microk8s to be ready, ingress now enabled
microk8s status --wait-ready | head -n9


# Configure Load Balancer and Ingress Controlers.
https://fabianlee.org/2021/07/29/kubernetes-microk8s-with-multiple-metallb-endpoints-and-nginx-ingress-controllers/
The ingress microk8s add-on provides a convenient way to setup a primary NGINX ingress controller.

Setting up a MetalLB/Ingress service
For load balancing in a MicroK8s cluster, MetalLB can make use of Ingress to properly balance across the cluster ( make sure you have also enabled ingress in MicroK8s first, with microk8s enable ingress). To do this, it requires a service. 

The MetalB is lv 4 and the ingress is lv 7 of the osi model
so the traffic is first seen by the metalb loadbalancer which then sends it to one of the ingress controllers through the service you define to decide which pod to send it to using an ingress object.

# What I have found
That the ingress controller is assigned to only one external IP address. If you run the following command you can see the IP address: 
kubectl get all --namespace ingress
So you need only 1 MetalB load balancer IP for each ingress controller.  By default microk8s allows you to enable 1 nginx ingress controller, so you would only need 1 metallb IP address. If you desire to use another external IP address for ingress routing then you must install a second ingress controller. 


For stand-alone systems:
moto
microk8s enable metallb:10.1.1.83-10.1.1.83

For production clusters:
alb-ubu
microk8s enable metallb:10.1.0.120-10.1.0.120,172.20.88.16-172.20.88.16,172.20.1.190-172.20.1.190

reports0
microk8s enable metallb:10.1.0.116-10.1.0.116,10.1.0.117-10.1.0.117,10.1.0.118-10.1.0.118
sleep 15
reports1
microk8s enable metallb:10.1.0.110-10.1.0.110,10.1.0.111-10.1.0.111,10.1.0.112-10.1.0.112
sleep 15
reports2
microk8s enable metallb:10.1.0.113-10.1.0.113,10.1.0.114-10.1.0.114,10.1.0.115-10.1.0.115
sleep 15
reports3
microk8s enable metallb:172.20.88.61-172.20.88.63
sleep 15


# wait for microk8s to be ready, metallb now enabled
microk8s status --wait-ready | head -n16

# view MetalLB objects
kubectl get all -n metallb-system

# show MetalLB configmap with IP used
kubectl get configmap/config -n metallb-system -o yaml

# Enable Secondary Ingress
To create a secondary ingress, we must go beyond using the microk8s ‘ingress’ add-on.  Fabian has put a DaemonSet definition into github as nginx-ingress-secondary-micro8s-controller.yaml, which you can apply like below.

# apply DaemonSet that creates secondary and third ingress controllers
What we have learned:
We can have at least 3 ingress controllers running if we each ingress daemonset yaml has a name to link to the ingress service and unique ingress-class defined in the args section. We must also specify that ingress-class in the applications ingress obect yaml.
<!-- https://kubernetes.github.io/ingress-nginx/user-guide/multiple-ingress/#multiple-ingress-nginx-controllers -->
<!-- https://www.bmc.com/blogs/kubernetes-daemonset/ -->
<!-- https://github.com/canonical/microk8s/issues/2035 -->
wget https://raw.githubusercontent.com/fabianlee/microk8s-nginx-istio/main/roles/add_secondary_ingress/templates/nginx-ingress-secondary-microk8s-controller.yaml.j2
https://docs.ansible.com/ansible/latest/user_guide/playbooks_templating.html
Ansible uses Jinja2 templating to enable dynamic expressions and access to variables and facts. You can use templating with the template module.

pushd ~/src/linux-utils/microk8s/nginx/controller
kubectl apply -f nginx-ingress-secondary-microk8s-controller.yaml

kubectl apply -f nginx-ingress-third-microk8s-controller.yaml

# you should now see both:
# 'nginx-ingress-microk8s-controller' and 
# 'nginx-ingress-private-microk8s-controller'
kubectl get all --namespace ingress

# Create Ingress Services
  ## If multiple ingress services do this:
You need to create two Services, one for the primary ingress using the first MetalLB IP address and another for the secondary using the second MetalLB IP address. I could not choose the exact MetalLB IP address for the service but microK8s choose one for both services.

I just removed the IP address because I could not get this to work if I manually specified the IP addresses.

pushd ~/src/linux-utils/microk8s/nginx/service
# If only 1 ingress controller.
kubectl apply -f nginx-ingress-service-primary.yaml
# if 2 ingress controllers.
kubectl apply -f nginx-ingress-service-primary-and-secondary.yaml
# if 3 ingress controllers.
kubectl apply -f nginx-ingress-service-primary-secondary-third.yaml

## shows 'ingress' and 'ingress-secondary' Services
## both ClusterIP as well as MetalLB IP addresses
kubectl get services --namespace ingress

pushd ~/src/linux-utils/microk8s/golang-hello-world/deployment
# test deployment of ingress
# apply first deployment
kubectl apply -f golang-hello-world-web.yaml

# apply second deployment for secondary ingress controller.
kubectl apply -f golang-hello-world-web2.yaml

# apply third deployment for third ingress controller.
kubectl apply -f golang-hello-world-web3.yaml


# show deployment(s) and then pod(s)
kubectl describe deployment golang-hello-world-web
kubectl describe deployment golang-hello-world-web2
kubectl describe deployment golang-hello-world-web3
kubectl get deployments 
kubectl get pods -o wide
kubectl get services 
These apps are now available at their internal pod IP address.

# internal ip of primary pod
export primaryPodIP=$(microk8s kubectl get pods -l app=golang-hello-world-web -o=jsonpath="{.items[0].status.podIPs[0].ip}")

# internal IP of secondary pod
export secondaryPodIP=$(microk8s kubectl get pods -l app=golang-hello-world-web2 -o=jsonpath="{.items[0].status.podIPs[0].ip}")

# third IP of third pod
export thirdPodIP=$(microk8s kubectl get pods -l app=golang-hello-world-web3 -o=jsonpath="{.items[0].status.podIPs[0].ip}")

# check pod using internal IP
curl http://${primaryPodIP}:8080/myhello/
curl http://${secondaryPodIP}:8080/myhello2/
curl http://${thirdPodIP}:8080/myhello3/

With internal pod IP proven out, move up to the IP at the  Service level.

# IP of primary service
export primaryServiceIP=$(microk8s kubectl get service/golang-hello-world-web-service -o=jsonpath="{.spec.clusterIP}")

# IP of secondary service
export secondaryServiceIP=$(microk8s kubectl get service/golang-hello-world-web-service2 -o=jsonpath="{.spec.clusterIP}")

# IP of third service
export thirdServiceIP=$(microk8s kubectl get service/golang-hello-world-web-service3 -o=jsonpath="{.spec.clusterIP}")

# check primary service
curl http://${primaryServiceIP}:8080/myhello/

# check secondary service
curl http://${secondaryServiceIP}:8080/myhello2/

# check third service
curl http://${thirdServiceIP}:8080/myhello3/

These validations proved out the pod and service independent of the NGINX ingress controller.  Notice all these were using insecure HTTP on port 8080, because the Ingress controller step in the following step is where TLS is layered on.

# generate addition certificates from reports01:
To generate additional certificates for the root certificate
stored on reports01 at 10.1.0.116 follow the instruction in the 
certificates directory of the
git@github.com:brentgroves/linux-utils.git repository.

# shows tls secrets:
kubectl get secrets --namespace default

# determine which certificate you need:
Choose the certificate whose name has the IP address of the external IP of the ingress service
kubectl get services --namespace ingress

# Install the certificates onto the cluster:
cd ~/src
git clone git@github.com:brentgroves/linux-utils.git
pushd ~/src/linux-utils/certificates

kubectl create -n default secret tls tls-credential --key=reports01-key.pem --cert=reports01.pem
kubectl create -n default secret tls tls-secondary-credential --key=reports02-key.pem --cert=reports02.pem
kubectl create -n default secret tls tls-third-credential --key=reports03-key.pem --cert=reports03.pem

kubectl create -n default secret tls tls-credential --key=reports11-key.pem --cert=reports11.pem
kubectl create -n default secret tls tls-secondary-credential --key=reports12-key.pem --cert=reports12.pem
kubectl create -n default secret tls tls-third-credential --key=reports13-key.pem --cert=reports13.pem

kubectl create -n default secret tls tls-credential --key=reports31-key.pem --cert=reports31.pem
kubectl create -n default secret tls tls-secondary-credential --key=reports32-key.pem --cert=reports32.pem
kubectl create -n default secret tls tls-third-credential --key=reports33-key.pem --cert=reports33.pem


kubectl create -n default secret tls tls-credential --key=moto-key.pem --cert=moto.pem

kubectl create -n default secret tls tls-credential --key=alb-ubu-key.pem --cert=alb-ubu.pem
kubectl create -n default secret tls tls-secondary-credential --key=avi-ubu-key.pem --cert=avi-ubu.pem
kubectl create -n default secret tls tls-third-credential --key=frt-ubu-key.pem --cert=frt-ubu.pem

shows tls secrets:
kubectl get secrets --namespace default
kubectl describe secret tls-credential
kubectl describe secret tls-secondary-credential
kubectl describe secret tls-third-credential

# verify certificates
# https://curl.se/docs/sslcerts.html
<!-- https://www.baeldung.com/linux/curl-https-connection -->
openssl s_client -showcerts -connect reports01:443
openssl s_client -showcerts -connect reports02:443
openssl s_client -showcerts -connect reports03:443
openssl s_client -showcerts -connect reports11:443
openssl s_client -showcerts -connect reports12:443
openssl s_client -showcerts -connect reports13:443
openssl s_client -showcerts -connect reports31:443
openssl s_client -showcerts -connect reports32:443
openssl s_client -showcerts -connect moto:443
openssl s_client -showcerts -connect alb-ubu:443
openssl s_client -showcerts -connect avi-ubu:443
openssl s_client -showcerts -connect frt-ubu:443
mkcert_development_CA_303095335489122417061412993970225104069.crt was generated from openssl I think.

# Deploy the ingress
Thank you Father, for being with me always and teaching me how to live in peace and have much joy!
To make these services available to the outside world, we need to expose them via the NGINX Ingress and MetalLB addresses.
NGINX = engineX

# show all the Ingress objects
kubectl get ingress --namespace default

pushd ~/src/linux-utils/microk8s/golang-hello-world/ingress/<cluster>
depending on the k8s cluster you are deploying to change to the appropriate cluster sub directory:

determine which certificate you need:
Choose the certificate whose name has the IP address of the external IP of the ingress service
kubectl get services --namespace ingress

verify the correct host name are set in golang-hello-world-web-on-nginx.yaml,
and golang-hello-world-web-on-nginx2.yaml
for the primary, secondary, and third ingress controller services for applying to the cluster.

kubectl apply -f golang-hello-world-web-on-nginx.yaml
kubectl apply -f golang-hello-world-web-on-nginx2.yaml
kubectl apply -f golang-hello-world-web-on-nginx3.yaml

# show all the Ingress objects
kubectl get ingress --namespace default

# Validate URL endpoints
The Ingress requires that the proper FQDN headers be sent by your browser, so it is not sufficient to do a GET against the MetalLB IP addresses. 

# check primary ingress
curl -k https://reports01/myhello/
curl -k https://reports11/myhello/
curl -k https://reports31/myhello/
curl -k https://alb-ubu/myhello/
curl -k https://moto/myhello/

fails without a -k
curl https://reports01/myhello/
For windows do this:
curl https://reports01/myhello/ --ssl-no-revoke 
For Ubuntu do this:
use generated certificate
curl https://reports01/myhello/ --cacert /usr/local/share/ca-certificates/mkcert_development_CA_303095335489122417061412993970225104069.crt 
curl https://reports01/myhello/ --cacert ~/src/linux-utils/certificates/ubuntu-ca-certificate/mkcert_development_CA_303095335489122417061412993970225104069.crt 

# check secondary ingress
curl -k https://reports02/myhello2/
curl -k https://reports12/myhello2/
curl -k https://reports32/myhello2/
curl -k https://avi-ubu/myhello2/

# check third ingress
curl -k https://reports03/myhello3/
curl -k https://reports13/myhello3/
curl -k https://reports33/myhello3/
curl -k https://frt-ubu/myhello3/


# clean up golang-hello-world
kubectl get all --namespace ingress

secrets:
kubectl delete -n default secret tls tls-credential 
kubectl delete -n default secret tls tls-secondary-credential kubectl delete -n default secret tls tls-third-credential 


DaemonSets
kubectl delete daemonset nginx-ingress-secondary-microk8s-controller --namespace=ingress
kubectl delete daemonset nginx-ingress-third-microk8s-controller --namespace=ingress

ingress services:
kubectl delete service ingress-secondary --namespace=ingress
kubectl delete service ingress-third --namespace=ingress

Deployments:
kubectl delete deployment golang-hello-world-web
kubectl delete deployment golang-hello-world-web2
kubectl delete deployment golang-hello-world-web3

services:
kubectl delete service golang-hello-world-web-service
kubectl delete service golang-hello-world-web-service2
kubectl delete service golang-hello-world-web-service3

ingress:
kubectl delete ingress golang-hello-world-web-service
kubectl delete ingress golang-hello-world-web-service2
kubectl delete ingress golang-hello-world-web-service3

# install mysql
look at ./mysql/mysql.md
























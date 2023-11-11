IP Address
reports1 = 10.1.0.116
reports2 = 10.1.0.117
reports3 = 10.1.0.118

ip-range 10.1.0.116-118,10.1.0.120
netmask:255.255.252.0
dns: 10.1.2.69, 10.1.2.70, 172.10.0.39, 10.30.1.27
gw:10.1.1.205
dev1: 10.1.0.125 - vm from develop-template -hostname is reports - dist upgrade to ubuntu 22.04 
mcp1: 10.1.0.121 - 22.04 fresh install
reports3: 10.1.0.118 - made a mysql backup to 10.1.1.83 ~/backups/db/
cluster1
reports01: 10.1.0.116 - change to 10.1.0.116 Thank you Abba for this work.
reports02: 10.1.0.117
reports03: 10.1.0.118
cluster2
reports11: 10.1.0.110 
reports12: 10.1.0.111 
reports13: 10.1.0.112 

make a reports13 and use 10.1.0.112 from a dell 9020 if Abba provides.
I hope it is ok with you Father to use Holly's old computer.
cluster3
moto = 10.1.1.83
frt-ubu = 172.20.1.190
avi-ubu = 172.20.88.16
Jared said it was ok to use:110-113

sudo hostnamectl set-hostname reports01

https://zero-to-jupyterhub.readthedocs.io/en/latest/
sudo snap remove microk8s

sudo apt install open-iscsi
open-iscsi is already the newest version (2.0.874-7.1ubuntu6.2).
Once the package is installed you will find the following files:

I did not change these 2 files.
/etc/iscsi/iscsid.conf
/etc/iscsi/initiatorname.iscsi

https://microk8s.io/#install-microk8s
sudo snap install microk8s --classic --channel=1.21
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube

I believe this is in the dotfiles
alias kubectl='microk8s kubectl'


microk8s will continue to run until you stop it.
microk8s stop
microk8s start

https://microk8s.io/docs/clustering

microk8s add-node
microk8s join 172.20.88.16:25000/552672885f4fcf007e153eb1ee425c2d/6bf7e3972626
kubectl get no
microk8s status


Access Kubernetes

MicroK8s bundles its own version of kubectl for accessing Kubernetes. Use it to run commands to monitor and control your Kubernetes. For example, to view your node:

microk8s kubectl get nodes

…or to see the running services:

microk8s kubectl get services

MicroK8s uses a namespaced kubectl command to prevent conflicts with any existing installs of kubectl. If you don’t have an existing install, it is easier to add an alias (append to ~/.bash_aliases) like this:


Verify nodes have been added
kubectl get node -o wide
All nodes are shown as master nodes with microk8s status.

Enable the necessary MicroK8s Add ons: 
Doing this on each node in cluster does not seem to be necessary for dns. I ran this command on AVI-UBU 
and the other nodes showed the dns add-ons as enabled. 
microk8s enable dns 

I don't think it is necessary to enable helm3 on each node, I did and it did not hurt.
Try enabling on 1 node only and then run microk8s status from another node to see if it is enabled 
microk8s enable helm3


This only has to be done on one node. I ran it on the master node.
This addon adds an NGINX Ingress Controller for MicroK8s. It is enabled by running the command:
https://microk8s.io/docs/addon-ingress
# enables primary NGINX ingress controller
$ microk8s enable ingress
# wait for microk8s to be ready, ingress now enabled
$ microk8s status --wait-ready | head -n9

The dashboard is not enabled but if it was:
If RBAC is not enabled access the dashboard using the default token retrieved with:
token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token
Role-based access control (RBAC) restricts network access based on a person's role within an organization and has become one of the main methods ...


Configure networking.
https://fabianlee.org/2021/07/29/kubernetes-microk8s-with-multiple-metallb-endpoints-and-nginx-ingress-controllers/
The ingress microk8s add-on provides a convenient way to setup a primary NGINX ingress controller.

Setting up a MetalLB/Ingress service
For load balancing in a MicroK8s cluster, MetalLB can make use of Ingress to properly balance across the cluster ( make sure you have also enabled ingress in MicroK8s first, with microk8s enable ingress). To do this, it requires a service. A suitable ingress service is defined here:

The MetalB is lv 4 and the ingress is lv 7 of the osi model
so the traffic is first seen by the metalb loadbalancer which then sends it to one of the ingress controllers through the service you define to decide which pod to 
send it to using an ingress object.

DO THIS FIRST BEFORE ENABLING METALB
This only has to be done on one node. I ran it on the master node.
This addon adds an NGINX Ingress Controller for MicroK8s. It is enabled by running the command:
microk8s enable ingress

microk8s enable metallb:172.20.88.16-172.20.88.16,172.20.1.190-172.20.1.190,10.1.1.83-10.1.1.83
reports01 = 10.1.0.116
reports02 = 10.1.0.117
reports03 = 10.1.0.118
moto = 10.1.1.83
frt-ubu = 172.20.1.190
avi-ubu = 172.20.88.16

# enable MetalLB to use IP range, then allow settle
# tooling.k8s
$ microk8s enable metallb:172.20.88.16-172.20.88.16,172.20.1.190-172.20.1.190,10.1.1.83-10.1.1.83
# reports.k8s
$ microk8s enable metallb:10.1.0.116-10.1.0.116,10.1.0.117-10.1.0.117,10.1.0.118-10.1.0.118
$ sleep 15
# reports-dev.k8s
$ microk8s enable metallb:10.1.0.110-10.1.0.110,10.1.0.111-10.1.0.111,10.1.0.112-10.1.0.112
$ sleep 15

# wait for microk8s to be ready, metallb now enabled
$ microk8s status --wait-ready | head -n8

# view MetalLB objects
$ kubectl get all -n metallb-system

# show MetalLB configmap with IP used
kubectl get configmap/config -n metallb-system -o yaml

Enable Secondary Ingress
To create a secondary ingress, we must go beyond using the microk8s ‘ingress’ add-on.  I have put a DaemonSet definition into github as nginx-ingress-secondary-micro8s-controller.yaml.j2, which you can apply like below.

# apply DaemonSet that creates secondary ingress
wget https://raw.githubusercontent.com/fabianlee/microk8s-nginx-istio/main/roles/add_secondary_ingress/templates/nginx-ingress-secondary-microk8s-controller.yaml.j2
https://docs.ansible.com/ansible/latest/user_guide/playbooks_templating.html
Ansible uses Jinja2 templating to enable dynamic expressions and access to variables and facts. You can use templating with the template module.

kubectl apply -f nginx-ingress-secondary-microk8s-controller.yaml.j2
# you should now see both:
# 'nginx-ingress-microk8s-controller' and 
# 'nginx-ingress-private-microk8s-controller'
kubectl get all --namespace ingress
While kubectl does fetch any remote manifest URL provided, I like to download these manifest so they can be referenced later or changed if necessary.


Create Ingress Services
Then you need to create two Services, one for the primary ingress using the first MetalLB IP address and another for the secondary using the second MetalLB IP address. I could not choose the exact MetalLB IP address for the service but microK8s choose one for both services.

Download the nginx-ingress-service-primary-and-secondary.yaml.j2 template, and do a couple of replacements before applying with kubectl. 
I just removed the IP address because I could not get this to work if I manually specified the IP addresses.

# download template
wget https://raw.githubusercontent.com/fabianlee/microk8s-nginx-istio/main/roles/add_secondary_nginx_ingress/templates/nginx-ingress-service-primary-and-secondary.yaml.j2

# edit file
# Note I left the loadBalancerIP field blank!!! I could not get it to run when I manually specified an IP address.
# replace first 'loadBalancerIP' value with first MetalLB IP. 
# Note I left the loadBalancerIP field blank!!! I could not get it to run when I manually specified an IP address.
# loadBalancerIP is optional. MetalLB will automatically allocate an IP 
# from its pool if not specified. You can also specify one manually.
# loadBalancerIP: "{{ additional_nic[0].netplan.addresses[0] | ipaddr('address') }}"

# replace second 'loadBalancerIP' value with second MetalLB IP 
nvim nginx-ingress-service-primary-and-secondary.yaml.j2

# apply to cluster
kubectl apply -f nginx-ingress-service-primary-and-secondary.yaml.j2

# shows 'ingress' and 'ingress-secondary' Services
# both ClusterIP as well as MetalLB IP addresses
kubectl get services --namespace ingress

Deployment and Services
To facilitate testing, we will deploy two independent Service+Deployment.

Service=golang-hello-world-web-service, Deployment=golang-hello-world-web
Service=golang-hello-world-web-service2, Deployment=golang-hello-world-web2
These both use the same image fabianlee/docker-golang-hello-world-web:1.0.0, however they are completely independent deployments and pods.

# get definition of first deployment
wget https://raw.githubusercontent.com/fabianlee/microk8s-nginx-istio/main/roles/golang-hello-world-web/templates/golang-hello-world-web.yaml.j2

# apply first one
nvim golang-hello-world-web.yaml.j2
kubectl apply -f golang-hello-world-web.yaml.j2

# get definition of second deployment
wget https://raw.githubusercontent.com/fabianlee/microk8s-nginx-istio/main/roles/golang-hello-world-web/templates/golang-hello-world-web2.yaml.j2

# apply second one
kubectl apply -f golang-hello-world-web2.yaml.j2

# show both deployments and then pods
kubectl get deployments 
kubectl get pods -o wide
kubectl get services 


These apps are now available at their internal pod IP address.

# check ClusterIP and port of first and second service
kubectl get services

# internal ip of primary pod
export primaryPodIP=$(microk8s kubectl get pods -l app=golang-hello-world-web -o=jsonpath="{.items[0].status.podIPs[0].ip}")

# internal IP of secondary pod
export secondaryPodIP=$(microk8s kubectl get pods -l app=golang-hello-world-web2 -o=jsonpath="{.items[0].status.podIPs[0].ip}")

# check pod using internal IP
curl http://${primaryPodIP}:8080/healthz/  -- 404 not founc
curl http://${primaryPodIP}:8080/myhello/


# check pod using internal IP
curl http://${secondaryPodIP}:8080/myhello2/


With internal pod IP proven out, move up to the IP at the  Service level.

# IP of primary service
export primaryServiceIP=$(microk8s kubectl get service/golang-hello-world-web-service -o=jsonpath="{.spec.clusterIP}")

# IP of secondary service
export secondaryServiceIP=$(microk8s kubectl get service/golang-hello-world-web-service2 -o=jsonpath="{.spec.clusterIP}")

# check primary service
curl http://${primaryServiceIP}:8080/myhello/

# check secondary service
curl http://${secondaryServiceIP}:8080/myhello2/

These validations proved out the pod and service independent of the NGINX ingress controller.  Notice all these were using insecure HTTP on port 8080, because the Ingress controller step in the following step is where TLS is layered on.

Create TLS key and certificate

Before we expose these services via Ingress, we must create the TLS keys and certificates that will be used when serving traffic.

Primary ingress will use TLS with CN=microk8s.local
Secondary ingress will use TLS with CN=microk8s-secondary.local
The best way to do this is with either a commercial certificate, or creating your own custom CA and SAN certificates.  But this article is striving for simplicity, so we will simply generate self-signed certificates using a simple script I wrote.

# This is the way Fabian suggesting creating certificates but
# go to the certificates directory of the 
# git clone git@github.com:brentgroves/linux-utils.git
# repository to create the tls secrets instead
# mkcerts has the added advantage of creating a root certificate
# that can be deployed on computers or through the AD.

# #############################################
# Start of Fabians method. I don't use this method
# ################################################
# download and change script to executable
wget https://raw.githubusercontent.com/fabianlee/microk8s-nginx-istio/main/roles/cert-with-ca/files/microk8s-self-signed.sh

kubectl get secrets --namespace default
kubectl delete secret tls-credential
kubectl delete secret tls-secondary-credential

chose one of the following:
chmod +x microk8s-self-signed.sh 
chmod +x mobex-k8s-self-signed.sh
chmod +x mobex-dev-k8s-self-signed.sh
chmod +x tooling-self-signed.sh

# run openssl commands that generate our key + certs in /tmp
on ubuntu 22.04 the ssl lib has changed from the time fabian created these scripts:
Package 'libssl1.0.0' has no installation candidate
Package 'libssl1.1' has no installation candidate
So install libssl-dev instead and ignore script error.
sudo apt-get -y install libssl-dev 

chose one of the following:
./microk8s-self-signed.sh
./mobex-k8s-self-signed.sh 
./mobex-dev-k8s-self-signed.sh 
./tooling-self-signed.sh

# change permissions so they can be read by normal user
sudo chmod go+r /tmp/*.{key,crt}

# show key and certs created
ls -l /tmp/microk8s*
ls -l /tmp/mobex*
ls -l /tmp/tooling*

# #############################################
# End of Fabians method
# ################################################
# delete secret 
kubectl delete secret tls-credential
kubectl delete secret tls-secondary-credential

# #############################################
# Start of mkcert method of creating certificates
# ################################################
using mkcert you can add multiple domain names to the certificate, SAN certificate, but I only have one domain specified 
# shows 'ingress' and 'ingress-secondary' Services
# both ClusterIP as well as MetalLB IP addresses
kubectl get services --namespace ingress
# verify the correct host for the MetalLB IP service address
# since I can't specify in ip address for the ingress controller services
# always verify the external ip address of each ingress controller service. 
sudo nvim /etc/hosts
reports.k8s
10.1.0.116      reports01 # primary ingress
10.1.0.117      reports02 # secondary ingress
10.1.0.118      reports03
reports-dev.k8s
10.1.0.110      reports11 # primary ingress
10.1.0.111      reports12 # secondary ingress
10.1.0.112      reports13
10.1.0.113      reports14 # not used yet
tooling.k8s
10.1.1.83       moto
172.20.88.16    avi-ubu # primary ingress service
172.20.1.190    frt-ubu # secondary ingress service

go to the certificates directory of the 
git clone git@github.com:brentgroves/linux-utils.git
repository to create the tls secrets
linux-utils will have these commands to deploy secrets to the 3 k8s clusters:
kubectl create -n default secret tls tls-credential --key=reports01-key.pem --cert=reports01.pem
kubectl create -n default secret tls tls-secondary-credential --key=reports02-key.pem --cert=reports02.pem
kubectl create -n default secret tls tls-credential --key=reports11-key.pem --cert=reports11.pem
kubectl create -n default secret tls tls-secondary-credential --key=reports12-key.pem --cert=reports12.pem
kubectl create -n default secret tls tls-credential --key=avi-ubu-key.pem --cert=avi-ubu.pem
kubectl create -n default secret tls tls-secondary-credential --key=frt-ubu-key.pem --cert=frt-ubu.pem

# shows both tls secrets
kubectl get secrets --namespace default
kubectl describe secret tls-credential
kubectl describe secret tls-secondary-credential

Deploy via Ingress
Thank you Father, to make these services available to the outside world, we need to expose them via the NGINX Ingress and MetalLB addresses.
NGINX = engineX
# create primary ingress
wget https://raw.githubusercontent.com/fabianlee/microk8s-nginx-istio/main/roles/golang-hello-world-web/templates/golang-hello-world-web-on-nginx.yaml.j2

update yaml to use the correct domain name.
depending on the k8s cluster you are deploying to change to the appropriate sub directory:
cd reports
cd reports-dev
cd tooling
verify the correct host name are set in golang-hello-world-web-on-nginx.yaml.j2,
and golang-hello-world-web-on-nginx2.yaml.j2
for the primary and secondary ingress controller services for applying to the cluster.

kubectl apply -f golang-hello-world-web-on-nginx.yaml.j2
kubectl apply -f golang-hello-world-web-on-nginx2.yaml.j2

# create secondary ingress 
wget https://raw.githubusercontent.com/fabianlee/microk8s-nginx-istio/main/roles/golang-hello-world-web/templates/golang-hello-world-web-on-nginx2.yaml.j2 

update yaml to use the correct domain name.
kubectl apply -f golang-hello-world-web-on-nginx2.yaml.j2

# show primary and secondary Ingress objects
# substitue actual domain name for microk8s.
# primary available at 'microk8s.local'
# secondary available at 'microk8s-secondary.local'
kubectl get ingress --namespace default

# shows primary and secondary ingress objects tied to MetalLB IP
kubectl get services --namespace ingress

Validate URL endpoints
The Ingress requires that the proper FQDN headers be sent by your browser, so it is not sufficient to do a GET against the MetalLB IP addresses.  You have two options:

add the FQDN, such as ‘microk8s.local’ and ‘microk8s-secondary.local’ entries to your local /etc/hosts file
OR use the curl ‘–resolve’ flag to specify the FQDN to IP mapping which will send the host header correctly
Here is an example of pulling from the primary and secondary Ingress using entries in the /etc/hosts file.

# verify certificates
# https://curl.se/docs/sslcerts.html
<!-- https://www.baeldung.com/linux/curl-https-connection -->
openssl s_client -showcerts -connect reports01:443
openssl s_client -showcerts -connect reports11:443

# check primary ingress
choose 1 of the following:
curl -k https://microk8s.local/myhello/
curl -k https://reports01/myhello/
curl https://reports01/myhello/
For windows do this:
curl https://reports01/myhello/ --ssl-no-revoke 
For Ubuntu do this:
curl https://reports01/myhello/ --cacert /usr/local/share/ca-certificates/mkcert_development_CA_303095335489122417061412993970225104069.crt 
curl -k https://reports02/myhello/
curl -k https://avi-ubu/myhello/


# check secondary ingress
curl -k https://frt-ubu/myhello2/
curl -k https://reports02/myhello2/

apiVersion: v1
kind: Service
metadata:
  name: ingress
  namespace: ingress -- I BELIEVE THIS MUST BE SET TO INGRESS
spec:
  selector:
    name: nginx-ingress-microk8s
  type: LoadBalancer
  # loadBalancerIP is optional. MetalLB will automatically allocate an IP 
  # from its pool if not specified. You can also specify one manually.
  # I could not get this service to run when I manually specified an IP address.
  # loadBalancerIP: 172.20.88.16
  ports:
    - name: http
      protocol: TCP
      port: 80
      targetPort: 80
    - name: https
      protocol: TCP
      port: 443
      targetPort: 443

(base)  ✘ bgroves@avi-ubu  ~  kubectl get services --all-namespaces
NAMESPACE     NAME         TYPE           CLUSTER-IP       EXTERNAL-IP    PORT(S)                      AGE
default       kubernetes   ClusterIP      10.152.183.1     <none>         443/TCP                      50m
kube-system   kube-dns     ClusterIP      10.152.183.10    <none>         53/UDP,53/TCP,9153/TCP       44m
ingress       ingress      LoadBalancer   10.152.183.207   172.20.88.16   80:30022/TCP,443:32183/TCP   35s

Now there is a load-balancer which listens on an arbitrary IP and directs traffic towards one of the listening ingress controllers.
kubectl get all --namespace ingress

in robotics and automation, a control loop is a non-terminating loop that regulates the state of a system.
Here is one example of a control loop: a thermostat in a room.
When you set the temperature, that's telling the thermostat about your desired state. The actual room temperature is the current state. The thermostat acts to bring the current state closer to the desired state, by turning equipment on or off.
In Kubernetes, controllers are control loops that watch the state of your cluster, then make or request changes where needed. Each controller tries to move the current cluster state closer to the desired state.

With the Ingress addon enabled, a HTTP/HTTPS ingress rule can be created with an Ingress resource. For example:

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: http-ingress
spec:
  rules:
  - http:
      paths:
      - path: /
        backend:
          serviceName: some-service
          servicePort: 80

Test if ingress 
Test ingress
# get definition of first service/deployment
wget https://raw.githubusercontent.com/fabianlee/microk8s-nginx-istio/main/roles/golang-hello-world-web/templates/golang-hello-world-web.yaml.j2

# apply first one
microk8s kubectl apply -f golang-hello-world-web.yaml.j2

microk8s kubectl get deployments
microk8s kubectl get pods
get clusterip
microk8s kubectl get services
21
11 + 8 in plant 2
2
1
2

# internal ip of primary pod
kubectl get pods -l app=golang-hello-world-web -o=jsonpath="{.items[0].status.podIPs[0].ip}"
export primaryPodIP=$(microk8s kubectl get pods -l app=golang-hello-world-web -o=jsonpath="{.items[0].status.podIPs[0].ip}")

curl http://${primaryPodIP}:8080/myhello/
curl http://10.1.210.68:8080/myhello/

With internal pod IP proven out, move up to the IP at the  Service level.

# IP of primary service
export primaryServiceIP=$(microk8s kubectl get service/golang-hello-world-web-service -o=jsonpath="{.spec.clusterIP}")

# check primary service
curl http://${primaryServiceIP}:8080/myhello/

# These validations proved out the pod and service independent of the NGINX ingress controller.  Notice all these were using insecure HTTP on port 8080, because the Ingress controller step in the following step is where TLS is layered on.

# Create TLS key and certificate
# Before we expose these services via Ingress, we must create the TLS keys and certificates that will be used when serving traffic.

# Primary ingress will use TLS with CN=microk8s.local
# Secondary ingress will use TLS with CN=microk8s-secondary.local
# The best way to do this is with either a commercial certificate, or creating your own custom CA and SAN certificates.  But this article is  striving for simplicity, so we will simply generate self-signed certificates using a simple script I wrote.

# download and change script to executable
wget https://raw.githubusercontent.com/fabianlee/microk8s-nginx-istio/main/roles/cert-with-ca/files/microk8s-self-signed.sh


  # create self-signed cert
sudo openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
-keyout microk8s.local.key -out microk8s.local.crt \
-subj "/C=US/ST=CA/L=SFO/O=myorg/CN=$FQDN"

https://fabianlee.org/2021/07/29/kubernetes-microk8s-with-multiple-metallb-endpoints-and-nginx-ingress-controllers/

# download and change script to executable
wget https://raw.githubusercontent.com/fabianlee/microk8s-nginx-istio/main/roles/cert-with-ca/files/microk8s-self-signed.sh


  # create self-signed cert
sudo openssl req -x509 -nodes -days 3650 -newkey rsa:2048 \
-keyout microk8s.local.key -out microk8s.local.crt \
-subj "/C=US/ST=CA/L=SFO/O=myorg/CN=$FQDN"

  # create pem which contains key and cert
sudo cat microk8s.local.crt microk8s.local.key | sudo tee -a microk8s.local.pem

  # smoke test, view CN
openssl x509 -noout -subject -in microk8s.local.crt

sudo chown $USER /tmp/microk8s.local.{pem,crt,key}

# create primary tls secret for 'microk8s.local'
microk8s kubectl create -n default secret tls tls-credential --key=/tmp/microk8s.local.key --cert=/tmp/microk8s.local.crt

https://kubernetes.io/docs/concepts/configuration/secret/
# shows both tls secrets
microk8s kubectl get secrets --namespace default

Deploy via Ingress
Finally, to make these services available to the outside world, we need to expose them via the NGINX Ingress and MetalLB addresses.

# create primary ingress
wget https://raw.githubusercontent.com/fabianlee/microk8s-nginx-istio/main/roles/golang-hello-world-web/templates/golang-hello-world-web-on-nginx.yaml.j2

microk8s kubectl apply -f golang-hello-world-web-on-nginx.yaml.j2



curl http://172.20.88.16 -I
curl http://172.20.1.190 -I
curl http://10.1.1.83 -I



set up nfs server
https://microk8s.io/docs/nfs
sudo apt-get install nfs-kernel-server
sudo mkdir -p /srv/nfs
sudo chown nobody:nogroup /srv/nfs
sudo chmod 0777 /srv/nfs

Edit the /etc/exports file. Make sure that the IP addresses of all your MicroK8s nodes are able to mount this share. For example, to allow all IP addresses in the 10.0.0.0/24 subnet:
sudo mv /etc/exports /etc/exports.bak
echo '/srv/nfs 10.0.0.0/24(rw,sync,no_subtree_check)' | sudo tee /etc/exports

# /srv/homes       hostname1(rw,sync,no_subtree_check) hostname2(ro,sync,no_subtree_check)


# cat /etc/exports
/srv/nfs 172.20.88.0/23(rw,sync,no_subtree_check)
/srv/nfs 10.1.0.0/22(rw,sync,no_subtree_check)
/srv/nfs 172.20.0.0/23(rw,sync,no_subtree_check)

sudo systemctl restart nfs-kernel-server

https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-18-04
sudo mkdir -p /nfs/general
sudo mount 172.20.88.16:/srv/nfs /nfs/general

Enable the Helm3 addon (if not already enabled) and add the repository for the NFS CSI driver:
microk8s enable helm3
microk8s helm3 repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
microk8s helm3 repo update

GitHub - kubernetes-csi/csi-driver-nfs: This driver allows Kubernetes to access NFS server on Linux node. ... Install driver on a Kubernetes cluster
Overview. CSI is an open standard API that enables Kubernetes to expose arbitrary storage systems to containerized workloads. Kubernetes volumes are managed by vendor-specific storage drivers, which have historically been compiled into Kubernetes binaries.


Then, install the Helm chart under the kube-system namespace with:
microk8s helm3 install csi-driver-nfs csi-driver-nfs/csi-driver-nfs --namespace kube-system --set kubeletDir=/var/snap/microk8s/common/var/lib/kubelet

hmicrok8s helm3 install csi-driver-nfs csi-driver-nfs/csi-driver-nfs \
    --namespace kube-system \
    --set kubeletDir=/var/snap/microk8s/common/var/lib/kubelet


 At this point, you should also be able to list the available CSI drivers in your Kubernetes cluster …

microk8s kubectl get csidrivers

create a storage class
microk8s kubectl apply -f - < sc-nfs.yaml

Create a new PVC
The final step is to create a new PersistentVolumeClaim using the nfs-csi storage class. This is as simple as specifying storageClassName: nfs-csi in the PVC definition, for example:

# pvc-nfs.yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  storageClassName: nfs-csi
  accessModes: [ReadWriteOnce]
  resources:
    requests:
      storage: 5Gi

microk8s kubectl get sc 
Then create the PVC with:

microk8s kubectl apply -f - < pvc-nfs.yaml

If everything has been configured correctly, you should be able to check the PVC…
microk8s kubectl describe pvc my-pvc

What is OCI Object Storage
https://docs.oracle.com/en-us/iaas/Content/Object/Concepts/objectstorageoverview.htm
OCI Object Storage provides a dedicated (non-shared) storage 'namespace' or container unique to each customer for all stored buckets and objects. This encapsulation provides end-to-end visibility and reduces the risk of exposed buckets.

https://microk8s.io/docs/addon-metallb
microk8s enable metallb:172.20.88.16-172.20.88.19
update its configmap

https://metallb.universe.tf/configuration/
https://github.com/metallb/metallb/issues/308#:~:text=To%20migrate%20an%20IP%20address,within%20the%20metallb%2Dsystem%20namespace.
How to update the IP address range
look at the old metalb config map
kubectl -n metallb-system get cm config
kubectl get configmap config -n metallb-system -o yaml
# note the old IPs allocated to the services
kubectl get svc --all-namespaces
k8s-namespace-frt   proxy-public           LoadBalancer   10.152.183.155   172.20.88.16   80:30622/TCP             47h
# delete the old configmap
kubectl -n metallb-system delete cm config
# apply the new configmap
kubectl apply -f metalb.yaml

https://microk8s.io/docs/addon-metallb
Setting up a MetalLB/Ingress service
For load balancing in a MicroK8s cluster, MetalLB can make use of Ingress to properly balance across the cluster ( make sure you have also enabled ingress in MicroK8s first, with microk8s enable ingress). To do this, it requires a service. A suitable ingress service is defined here:

microk8s enable ingress


microk8s enable openebs

sudo mkdir -p /srv/k8s
sudo chown nobody:nogroup /srv/k8s
sudo chmod 0777 /srv/k8s


kubectl get pods -n openebs
kubectl describe pods -n openebs openebs-apiserver-bc6bc5986-cmzbg


microk8s.kubectl apply -f local-storage-dir.yaml
kubectl get sc --all-namespaces

microk8s.kubectl apply -f local-storage-dir.yaml

create the persistant volume claim
kubectl apply -f local-storage-dir-pvc.yaml

Look at the PersistentVolumeClaim:
kubectl get pvc local-storage-dir-pvc

The output shows that the STATUS is Pending. This means PVC has not yet been used by an application pod. The next step is to create a Pod that uses your PersistentVolumeClaim as a volume.

NAME                 STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS       AGE
local-hostpath-pvc   Pending                                      openebs-hostpath   3m7s


kubectl apply -f local-storage-dir-pod.yaml

Look at the PersistentVolumeClaim:
kubectl get pvc local-storage-dir-pvc

kubectl exec hello-local-storage-dir-pod -- cat /mnt/store/greet.txt

https://openebs.io/docs/user-guides/localpv-hostpath#create-storageclass
kubectl delete pod hello-local-storage-dir-pod
kubectl delete pvc local-storage-dir-pvc


Remember to append microk8s to all commands
microk8s.kubectl config view --raw > ~/.kube/config

helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

helm upgrade --cleanup-on-fail \
  --install helm-release-frt jupyterhub/jupyterhub \
  --namespace k8s-namespace-frt \
  --create-namespace \
  --version=1.2.0 \
  --values config.yaml

how to change
modify config.yaml
then run 

helm upgrade --cleanup-on-fail \
    helm-release-frt jupyterhub/jupyterhub \
  --namespace k8s-namespace-frt \
  --version=1.2.0 \
  --values config.yaml

Thank you for installing JupyterHub!
Your release is named "helm-release-frt" and installed into the namespace "k8s-namespace-frt".
You can check whether the hub and proxy are ready by running:
 kubectl --namespace=k8s-namespace-frt get pod

and watching for both those pods to be in status 'Running'.

You can find the public (load-balancer) IP of JupyterHub by running:

  kubectl -n k8s-namespace-frt get svc proxy-public -o jsonpath='{.status.loadBalancer.ingress[].ip}'

It might take a few minutes for it to appear!

To get full information about the JupyterHub proxy service run:

  kubectl --namespace=k8s-namespace-frt get svc proxy-public
#to remain sane set namespace default
microk8s.kubectl config set-context $(microk8s.kubectl config current-context) --namespace k8s-namespace-frt

If you have questions, please:

  1. Read the guide at https://z2jh.jupyter.org
  2. Ask for help or chat to us on https://discourse.jupyter.org/
  3. If you find a bug please report it at https://github.com/jupyterhub/zero-to-jupyterhub-k8s/issues




OPEN ISSUE
https://kubernetes.slack.com
OPENEBS IS CRASHING



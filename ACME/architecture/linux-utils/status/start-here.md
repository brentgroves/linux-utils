# Start here
Start by asking for help.
I love you my son and would like you to stay close to me for your directions.
I believe you want me test laravel sails deploy script using the devcontainer querystring parameter.
If time then find a tutorial maybe chirper to work with a mysql database using laravel.
DEVCON1
A VSCode devcontainer development environment is geared towards docker compose which runs all the services needed by an application on one computer. This way is fine but requires more memory so spend time creating a development VM with lots, 32 GB, of memory.
devcontainer for lavavel

curl -s "https://laravel.build/example-app?with=mysql,redis&devcontainer" | bash

https://blog.devsense.com/2022/laravel-on-docker
curl -s "https://laravel.build/example-app?with=mysql,redis&devcontainer" | bash 

search on devcontainer for lavavel
https://laravel.com/docs/8.x/sail
Using Devcontainers
If you would like to develop within a Devcontainer, you may provide the --devcontainer option to the sail:install command. The --devcontainer option will instruct the sail:install command to publish a default .devcontainer/devcontainer.json  file to the root of your application:

php artisan sail:install --devcontainer
Choosing Your Sail Services
When creating a new Laravel application via Sail, you may use the with query string variable to choose which services should be configured in your new application's docker-compose.yml file. Available services include mysql, pgsql, mariadb, redis, memcached, meilisearch, minio, selenium, and mailhog:

curl -s "https://laravel.build/example-app?with=mysql,redis" | bash

https://dev.to/manuelojeda/create-a-proper-debug-setup-in-vs-code-with-laravel-sail-57kn
https://www.youtube.com/watch?v=iHad9TH9mOA
- learn to debug php from vscode
- try to run unit php from docker
- https://unit.nginx.org/howto/laravel/ do this from linux-utils/nginx-unit/ubuntu/howto/laravel and not the chirper project.
- try to run unit from k8s
- try to connect to mysql from php
https://stackify.com/php-debugging-guide/

https://paiza.io/projects/8WFzDA_9grobzvSEM3y27g
run-unit-php.md
how to use --unix-socket and curl to upload a config file
https://www.youtube.com/watch?v=L7uvDF1EruI
work with nginx-unit to support docker.
https://www.tothenew.com/blog/dockerizing-nginx-and-ssh-using-supervisord/
https://hub.docker.com/_/php
https://perishablepress.com/roll-your-own-whats-my-ip/
https://docs.nginx.com/nginx/admin-guide/web-server/web-server/
study location directive more and reloadngix.sh put in site directories so you can run it.
# run nginx with no default.conf in conf.d
try /home/brent/src/linux-utils/nginx/docker/run-docker with config file
https://hub.docker.com/_/nginx
https://codefaster.substack.com/p/mastering-jq-xml-and-any-other-data

change nginx.conf to be something like:
server {
    listen 80;
    listen [::]:80;
    listen <set-your-IP>:11371;
    listen [set-your-IPv6-IP]:11371;
    server_name <set-your-hostname>;
    server_name pool.sks-keyservers.net;
    server_name *.pool.sks-keyservers.net;
    server_name pgp.ipfire.org;
    server_name keys.gnupg.net;
    root /var/www/html;
    error_page 404 /404.html;

    location ~ (.git|LICENSE|readme.md) {
        deny all;
        return 404;
    }

    location /pks {
        proxy_pass         http://127.0.0.1:11371;
        proxy_pass_header  Server;
        add_header         Via "1.1 <set-your-hostname>:11371 (nginx)";
    }
}

https://dev.to/danielkun/nginx-everything-about-proxypass-2ona
https://github.com/mattrude/pgpkeyserver-lite
https://github.com/mattrude/pgpkeyserver-lite/wiki
Should I try to run the stand-alone Hockeypuck server using the certbot or modify the dev docker-compose.yml to include an nginx service?

csr.md.
https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/#sign-the-certificate-signing-request
After reviewing how kubernetes handles certificates then continue with
https://medium.com/@michal.bock/deploy-certificate-authority-service-on-kubernetes-21853c152ade

cfssl, linux utility, python, or golang program to encode document using certificate.
https://medium.com/@michal.bock/deploy-certificate-authority-service-on-kubernetes-21853c152ade
start at end and create cfssl namespace and change yaml to use that namespace

To create the secrets used in the manifests you can run the following commands.

kubectl create secret generic ca-certs --from-file=ca.pem --from-file=ca-key.pem
kubectl create secret generic ca-auth-key --from-literal=auth.key=$(hexdump -n 16 -e '4/4 "%08X" 1 "\n"' /dev/random)
https://medium.com/@michal.bock/deploy-certificate-authority-service-on-kubernetes-21853c152ade

https://medium.com/@michal.bock/deploy-certificate-authority-service-on-kubernetes-21853c152ade
Try to create a CFSSL CA server to use internally accessible from reports5
https://github.com/SpeedyCoder/kubernetes-manifests/tree/master/certificate-authority
https://phoenixnap.com/kb/kubernetes-ssl-certificates
https://medium.com/@michal.bock/deploy-certificate-authority-service-on-kubernetes-21853c152ade

Install Nginx IC on reports5
create CFSSL CA server called Mobex CA on reports5 K8s
generate TLS certificate for reports5 ingress controller,

-- All k8s are down maybe because of qnap or mayastor 
https://benbrougher.tech/posts/microk8s-ingress/
git clone git@github.com:brentgroves/cfssl-test.git
https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/#sign-the-certificate-signing-request
# https://cert-manager.io/docs/tutorials/acme/nginx-ingress/#step-6---configure-a-lets-encrypt-issuer
https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli#create-a-ca-cluster-issuer
# install cert manager section of ~/src/linux-utils/aks/ingress-setup.md and ~/src/linux-utils/nginx-ic/nginx-ic-aks-install.md 
# test golang TLS program
https://gist.github.com/denji/12b3a568f092ab951456

https://docs.nginx.com/nginx-ingress-controller/intro/how-nginx-ingress-controller-works/
https://kulkarniamit.github.io/whatwhyhow/howto/verify-ssl-tls-certificate-signature.html
goto Use issuer’s public key (Remember the issuer signed the server certificate using the corresponding private key) to decrypt the signature.

goto Obtain Issuer’s public key in crypto/book/signatures/"how-to-verify-signatures.md"
Study "Let's Encrypt" https://letsencrypt.org/how-it-works/
Install cert-manager https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli#set-the-dns-label-using-azure-cli-or-azure-powershell
GOTO "START HERE" IN AKS/ingress-controller/ingress-setup.md 



for testing and https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli#set-the-dns-label-using-azure-cli-or-azure-powershell

.

https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli#install-cert-manager
Continue the process of setting up an ingress TLS.
https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli
https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli

https://learn.microsoft.com/en-us/microsoftteams/platform/tabs/how-to/create-tab-pages/content-page?tabs=teamsjs-v2
# open source BI
https://www.helicalinsight.com/open-source-bi-tool-for-mongodb/

# add tls
https://learn.microsoft.com/en-us/azure/aks/ingress-tls?tabs=azure-cli
aks/ingress-controller/lets-encrypt/setup-tls.md

# create an ingress controller to handle ssl using reports.busche-cnc.com and it's cert.
**Install Helm**
https://learn.microsoft.com/en-us/azure/aks/quickstart-helm?tabs=azure-cli
https://medium.com/@GeoffreyDV/how-to-set-up-ssl-certificates-for-free-on-azure-kubernetes-service-with-lets-encrypt-c7daca4e9385

Open linux-utils/aks/ingress-controller.md 

get DNS and SSL
Domain name: reports.busche-cnc.com, but it can be anything
SSL certificate: Can't be self signed or teams app wont work.

bgtest.any
one page per report dataset run request.
Generate report dataset teams tab. Returns a dataset id.
TB Report tab add dataset id to start and end period parameters. 

maybe select report then show params.
report id returned
ETL pipeline runs
user notified when ready.
goto specific Power BI report page.
enter report id
and params.



https://learn.microsoft.com/en-us/azure/application-gateway/ingress-controller-expose-service-over-http-https#expose-services-over-https
https://learn.microsoft.com/en-us/azure/iot-hub/iot-hub-x509ca-overview#get-an-x509-ca-certificate
https://aboutssl.org/cheap-ssl-certificate-providers/

Azure:
https://learn.microsoft.com/en-us/microsoftteams/platform/tabs/how-to/create-personal-tab?pivots=node-java-script
Azure/Teams App

Attempt to run the tunnelling service on aks pod on developer account.
To build a team app you must have a HTTPS url not one that is locally signed.
A reports service principal and resource group.
Deploy a web app and load balancer in AKS.
Generate client id for web app.
Add web app external ip to Teams tab.

https://community.powerbi.com/t5/Desktop/Incrimental-Refresh-for-MongoDB-ODBC-Connector/td-p/1820266
How to refresh the data?
https://www.cdata.com/kb/tech/mongodb-powerbi-gateway.rst#:~:text=2.-,Connect%20to%20MongoDB%20Data%20from%20PowerBI.com,Apply%20to%20save%20your%20changes.
Maybe I need to do the other type of report


Was able to connect to mongodb local using the secret connection string
So change the mongodbsqld.conf connection string to this local value.
work on deploy-mongobi and look at notes in mongobi-install.md 
just deployed statefulset to AKS
look at log file
tail -f -n 25 /logs/mongosqld.log
This looks good
deploy the load balancer
get IP address
13.86.101.2
problem no headless service
reports-mongodb-svc   ClusterIP      None          <none>           27017/TCP         7d4h
Create an ODBC connection using the IP address
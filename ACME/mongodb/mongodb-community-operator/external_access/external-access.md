https://github.com/mongodb/mongodb-kubernetes-operator/blob/master/docs/external_access.md

# Install cert-manager
kubectl create namespace cert-manager
ssh brent@reports51
microk8s helm repo add jetstack https://charts.jetstack.io
microk8s helm repo update
microk8s helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.3.1 \
  --set installCRDs=true

# Install mkcert and generate CA
#for Linux / Windows systems look at https://github.com/FiloSottile/mkcert
sudo apt install libnss3-tools
Then you can install using Homebrew on Linux
brew install mkcert
# generate CA
mkcert -install
Created a new local CA 💥
The local CA is now installed in the system trust store! ⚡️
Warning: "keytool" is not available, so the CA can't be automatically installed in Java's trust store! ⚠️

Execute mkcert --CAROOT to note the location of the generated root CA key and cert.
/home/brent/.local/share/mkcert

# Retrieve the CA and create configmaps and secrets
Use the files that you found in the previous step. Replace <your-namespace> with your chosen namespace
kubectl create configmap ca-config-map --from-file=ca.crt=/home/brent/.local/share/mkcert/rootCA.pem --namespace mongo
kubectl create secret tls ca-key-pair  --cert=/home/brent/.local/share/mkcert/rootCA.pem  --key=/home/brent/.local/share/mkcert/rootCA-key.pem --namespace mongo
kubectl create configmap ca-config-map --from-file=ca.crt=<path-to-ca.crt> --namespace <your-namespace>
rootCA-key.pem
kubectl create secret tls ca-key-pair  --cert=<path-to-ca.crt>  --key=<path-to-ca.key> --namespace <your-namespace>


# Create the Cert Manager issuer and secret
Edit the file cert-manager-certificate.yaml to replace <mongodb-name> with your MongoDB deployment name. Also replace <domain-rs-1>, <domain-rs-2>, and <domain-rs-3> with the external FQDNs of the MongoDB replicaset members. Please remember that you will have to add an equal number of entries for each member of the replicaset, for example:

...
spec:
  members: 3
  type: ReplicaSet
  replicaSetHorizons:
  - horizon1: <domain1-rs-1>:31181
    horizon2: <domain2-rs-1>:31181
  - horizon1: <domain1-rs-2>:31182
    horizon2: <domain2-rs-2>:31182
  - horizon1: <domain1-rs-3>:31183
    horizon2: <domain2-rs-3>:31183
...
Apply the manifests. Replace <your-namespace> with the namespace you are using for the deployment.

kubectl apply -f cert-manager-issuer.yaml --namespace mongo
kubectl apply -f cert-manager-certificate.yaml --namespace mongo

# Create the MongoDB deployment
Edit mongodb.com_v1_mongodbcommunity_cr.yaml. Replace with the desired MongoDB deployment name -- this should be the same as in the previous step. Replace <domain-rs-1>, <domain-rs-2>, and <domain-rs-3> with the external FQDNs of the MongoDB replicaset members. Please remember that you should have the same number of entries in this section as the number of your replicaset members. You can also edit the ports for external access to your preferred numbers in this section -- you will have to remember to change them in the next step too. Change <your-admin-password> to your desired admin password for MongoDB.

Apply the manifest.

kubectl apply -f test-deploy.yaml --namespace mongo
Wait for the replicaset to be available.

# verify
kubectl get mongodbcommunity --namespace mongo
kubectl get pods -n mongo
kubectl get pvc -n mongo

# Create the external NodePort services for accessing the MongoDB deployment from outside the Kubernetes cluster
Edit external_services.yaml and replace <mongodb-name> with the MongoDB deployment name that you have used in the preceeding steps. You can change the nodePort and port to reflect the changes (if any) you have made in the previous steps.

Apply the manifest.

kubectl apply -f external_services.yaml --namespace mongo
kubectl get svc
Retrieve the certificates from a MongoDB replicaset member
kubectl exec --namespace mongo  -it reports-mongodb-0 -c mongod -- bash
Once inside the container cat and copy the contents of the .pem file in /var/lib/tls/server into a file on your local system.
cat /var/lib/tls/server/47e043df48f4d4ac8b9a478a1191c8251d0204efd414f91a93c80751d9415f91.pem

# Connect to the MongoDB deployment from outside the Kubernetes cluster
This is an example to connect to the MongoDB cluster with Mongo shell. Use the CA from mkcert and the certificate from the previous step. Replace the values in the command from the preceeding steps.

get /home/brent/.local/share/mkcert/rootCA.pem

mongosh --tls --tlsCAFile rootCA.pem --tlsCertificateKeyFile cert.pem --username my-user --password JesusLives1! mongodb://reports51:30351,reports52:30352,reports53:30353,reports54:30354

mongosh --tls --tlsCAFile ca.crt --tlsCertificateKeyFile key.pem --username my-user --password <your-admin-password> mongodb://<domain-rs-1>:31181,<domain-rs-2>:31182,<domain-rs-3>:31183


# get connection string
kubectl get secret reports-mongodb-admin-my-user -n mongo \
-o json | jq -r '.data | with_entries(.value |= @base64d)'

{
  "connectionString.standard": "mongodb://my-user:JesusLives1%21@reports-mongodb-0.reports-mongodb-svc.mongo.svc.cluster.local:27017,reports-mongodb-1.reports-mongodb-svc.mongo.svc.cluster.local:27017,reports-mongodb-2.reports-mongodb-svc.mongo.svc.cluster.local:27017,reports-mongodb-3.reports-mongodb-svc.mongo.svc.cluster.local:27017/admin?replicaSet=reports-mongodb&ssl=true",
  "connectionString.standardSrv": "mongodb+srv://my-user:JesusLives1%21@reports-mongodb-svc.mongo.svc.cluster.local/admin?replicaSet=reports-mongodb&ssl=true",
  "password": "JesusLives1!",
  "username": "my-user"
}
# try to connect to pod
kubectl -n mongo exec --stdin --tty reports-mongodb-0 -- /bin/bash
mongo -u my-user

use admin
db.createUser({user: "adminuser" , pwd: "password123", roles: [  "userAdminAnyDatabase","readWriteAnyDatabase" ]})
https://www.mongodb.com/docs/manual/reference/method/db.grantRolesToUser/
db.createUser({user: "adminuser" , pwd: "password123", 
roles:
[{
  "role" : "clusterAdmin",
  "db" : "admin"
},
{
  "role" : "dbAdminAnyDatabase",
  "db" : "admin"
},
{
  "role" : "readWriteAnyDatabase",
  "db" : "admin"
}]
);

db.getUsers({ showCredentials: true })

db.auth("adminuser", "password123");
use test
db.movies.insertOne(
  {
    title: "The Favourite 5",
    genres: [ "Drama", "History" ],
    runtime: 121,
    rated: "R",
    year: 2018,
    directors: [ "Yorgos Lanthimos" ],
    cast: [ "Olivia Colman", "Emma Stone", "Rachel Weisz" ],
    type: "movie"
  }
);
db.movies.find( { } );
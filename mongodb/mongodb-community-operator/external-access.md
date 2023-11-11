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


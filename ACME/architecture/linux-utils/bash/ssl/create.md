# download and change script to executable
wget https://raw.githubusercontent.com/fabianlee/microk8s-nginx-istio/main/roles/cert-with-ca/files/microk8s-self-signed.sh

chmod +x microk8s-self-signed.sh

# run openssl commands that generate our key + certs in /tmp
./microk8s-self-signed.sh

# change permissions so they can be read by normal user
sudo chmod go+r /tmp/*.{key,crt}

# show key and certs created
ls -l /tmp/microk8s*

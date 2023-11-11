# Install kubectl

## References

<https://microk8s.io/docs/working-with-kubectl>

## Kubectl install

```bash
sudo snap install kubectl  --classic

# generate microk8s config file from any k8s node
ssh brent@reports11
cd ~
mkdir .kube
cd .kube
microk8s config > reports5.yaml
exit
# Add the new config file to source control
# From development system
pushd ~/src/reports/k8s/kubectl/all-config-files
git pull
lftp brent@reports11
get /home/brent/.kube/reports1.yaml
# add contexts to reports1.yaml
code ~/src/linux-utils/kubectl/all-config-files
- context:
    cluster: microk8s-cluster
    namespace: mayastor
    user: admin
  name: mayastor
- context:
    cluster: microk8s-cluster
    namespace: mysql
    user: admin
  name: mysql
- context:
    cluster: microk8s-cluster
    namespace: mongo
    user: admin
  name: mongo
- context:
    cluster: microk8s-cluster
    namespace: mosquitto
    user: admin
  name: mosquitto
- context:
    cluster: microk8s-cluster
    namespace: test
    user: admin
  name: test
# commit changes to source control

# git@ssh.dev.azure.com:v3/MobexGlobal/MobexCloudPlatform/kube
# Repeat the next section from everywhere you want to use kubectl.
ssh brent@reports11
cd ~/src
git clone git@github.com:brentgroves/linux-utils.git
pushd ~/src/linux-utils/kubectl/all-config-files
mkdir -p ~/.kube
cp ./*.yaml ~/.kube/
cd ..
cp ./scc.sh ~/.kube/
sudo cp ./scc.sh /usr/local/bin
# test config with scc
scc.sh reports1.yaml microk8s
kubectl get node -o wide
```

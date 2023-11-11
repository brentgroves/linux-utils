# Install Krew

## References

<https://krew.sigs.k8s.io/docs/user-guide/setup/install/>

## Run Krew install script

Run this command to download and install krew:

```bash
./k
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
```

Run kubectl krew to check the installation.

Make sure to add it to your path

export PATH="${PATH}:${HOME}/.krew/bin"
Then run the following command to install the MinIO Operator and Plugin:

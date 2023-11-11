https://www.containiq.com/post/kubectl-config-set-context-tutorial-and-best-practices
https://github.com/kubernetes-sigs/krew/
Krew is a tool that makes it easy to use kubectl plugins. Krew helps you discover plugins, install and manage them on your machine. It is similar to tools like apt, dnf or brew. Today, over 200 kubectl plugins are available on Krew.

For kubectl users: Krew helps you find, install and manage kubectl plugins in a consistent way.
For plugin developers: Krew helps you package and distribute your plugins on multiple platforms and makes them discoverable.
https://krew.sigs.k8s.io/docs/user-guide/setup/install/
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)

https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/#known-issues
https://kubernetes.io/docs/tasks/administer-cluster/dns-custom-nameservers/

Some Linux distributions (e.g. Ubuntu) use a local DNS resolver by default (systemd-resolved). Systemd-resolved moves and replaces /etc/resolv.conf with a stub file that can cause a fatal forwarding loop when resolving names in upstream servers. This can be fixed manually by using kubelet's --resolv-conf flag to point to the correct resolv.conf (With systemd-resolved, this is /run/systemd/resolve/resolv.conf). kubeadm automatically detects systemd-resolved, and adjusts the kubelet flags accordingly.

ubuntu uses /run/systemd/resolve/resolv.conf but k8s uses /etc/resolv.conf to resolve dns names

copy /run/systemd/resolve/resolv.conf to install/resolve/resolv.conf and then add the following copy command to the dockerfile.
COPY ./install/resolve/resolv.conf /etc/resolv.conf
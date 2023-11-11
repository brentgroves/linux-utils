kubectl run curl --image=radial/busyboxplus:curl -i --tty

To access the pods with ClusterIP, you can run a BusyBox curl container, then run nslookup for the internal service. If the service is discoverable, this confirms that the pods are available from inside the cluster:
console@bash:~$ kubectl run curl --image=radial/busyboxplus:curl -i --tty --rm
You can then run nslookup internal-service, and you’ll see the following output:


[ root@curl:/ ]$nslookup demo
Server:    10.0.0.10
Address 1: 10.0.0.10 kube-dns.kube-system.svc.cluster.local

Name:      demo
Address 1: 10.0.178.16 demo.ingress-nginx.svc.cluster.local

You can exit the pod using Ctrl+D, or by running exit in the console.


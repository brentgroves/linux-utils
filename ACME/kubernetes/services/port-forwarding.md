
# port forward

<https://www.server-world.info/en/note?os=Debian_12&p=microk8s&f=8>

```bash
# set port-forwarding to enable external access if you need
# Prometheus UI
root@dlp:~# microk8s kubectl port-forward -n observability service/prometheus-operated --address 0.0.0.0 9090:9090
Forwarding from 0.0.0.0:9090 -> 9090
# Grafana UI
root@dlp:~# microk8s kubectl port-forward -n observability service/kube-prom-stack-grafana --address 0.0.0.0 3000:80
Forwarding from 0.0.0.0:3000 -> 3000

http://localhost:9090/
http://localhost:3000/
```

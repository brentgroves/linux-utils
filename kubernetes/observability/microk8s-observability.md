# MicroK8s Observability

**[microK8s Observability](https://betterprogramming.pub/observability-with-microk8s-14c1f0ff5183)**

Microk8s has an observability stack built-in. But it still requires some set-up and finessing, which I will review in this article.

To follow along, you should have microk8s installed, and I will use k9s for cluster visibility. You can use Lens, but I like k9s for its simplicity. In my Kubernetes cluster, I have a few microservices and databases running. Going on k9s, I see this:

To install the observability stack, you can run this command:

microk8s enable observability
Infer repository core for addon observability
Addon core/dns is already enabled
Addon core/helm3 is already enabled
Enabling default storage class.
WARNING: Hostpath storage is not suitable for production environments.
         A hostpath volume can grow beyond the size limit set in the volume claim manifest.

deployment.apps/hostpath-provisioner created
storageclass.storage.k8s.io/microk8s-hostpath created
serviceaccount/microk8s-hostpath created
clusterrole.rbac.authorization.k8s.io/microk8s-hostpath created
clusterrolebinding.rbac.authorization.k8s.io/microk8s-hostpath created
Storage will be available soon.
Enabling observability
Release "kube-prom-stack" does not exist. Installing it now.
NAME: kube-prom-stack
LAST DEPLOYED: Wed Oct 11 20:04:47 2023
NAMESPACE: observability
STATUS: deployed
REVISION: 1
NOTES:
kube-prometheus-stack has been installed. Check its status by running:
  kubectl --namespace observability get pods -l "release=kube-prom-stack"

NAME                                                   READY   STATUS    RESTARTS   AGE
kube-prom-stack-kube-prome-operator-7744b7b479-657nk   1/1     Running   0          10m
kube-prom-stack-prometheus-node-exporter-dfh69         1/1     Running   0          10m
kube-prom-stack-kube-state-metrics-548b48db88-plqs6    1/1     Running   0          10m
kube-prom-stack-prometheus-node-exporter-sr9m9         1/1     Running   0          10m
kube-prom-stack-prometheus-node-exporter-wrct7         1/1     Running   0          10m
kube-prom-stack-prometheus-node-exporter-fqt49         1/1     Running   0          10m

Visit <https://github.com/prometheus-operator/kube-prometheus> for instructions on how to create & configure Alertmanager and Prometheus instances using the Operator.
Release "loki" does not exist. Installing it now.
NAME: loki
LAST DEPLOYED: Wed Oct 11 20:05:43 2023
NAMESPACE: observability
STATUS: deployed
REVISION: 1
NOTES:
The Loki stack has been deployed to your cluster. Loki can now be added as a datasource in Grafana.

See <http://docs.grafana.org/features/datasources/loki/> for more detail.
Release "tempo" does not exist. Installing it now.
NAME: tempo
LAST DEPLOYED: Wed Oct 11 20:05:46 2023
NAMESPACE: observability
STATUS: deployed
REVISION: 1
TEST SUITE: None
Adding argument --authentication-kubeconfig to nodes.
Adding argument --authorization-kubeconfig to nodes.
Restarting nodes.
Adding argument --authentication-kubeconfig to nodes.
Adding argument --authorization-kubeconfig to nodes.
Restarting nodes.
Adding argument --metrics-bind-address to nodes.
Restarting nodes.

Note: the observability stack is setup to monitor only the current nodes of the MicroK8s cluster.
For any nodes joining the cluster at a later stage this addon will need to be set up again.

Observability has been enabled (user/pass: admin/prom-operator)

 kubectl --namespace observability get pods
 kubectl --namespace observability get svc
For a quick tutorial:
<https://betterprogramming.pub/observability-with-microk8s-14c1f0ff5183>

## port forward

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

## How to configure install

<https://github.com/canonical/microk8s-core-addons/issues/125>

Yes can use microk8s enable observability -f values.yaml command to deploy your own custom config.
For values.yaml file, you can read more detail on this.

I assume you familiar with helm chart and values file.

I ended up abandoning the addon and just installing its constituent parts myself. Ultimately it ended up being better for me.

Yep, cause without documentation there's no point.

Visit <https://github.com/prometheus-operator/kube-prometheus> for instructions on how to create & configure Alertmanager and Prometheus instances using the Operator.

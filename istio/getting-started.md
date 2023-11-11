# istio getting started

<https://istio.io/latest/docs/setup/getting-started/>

```bash
microk8s.enable istio
istio-1.18.2/bin/
istio-1.18.2/bin/istioctl
Infer repository core for addon dns
Addon core/dns is already enabled
✔ Istio core installed                                                             ✔ Istiod installed                                                             ✔ Ingress gateways installed                                                             ✔ Egress gateways installed                                                             ✔ Installation complete                                                              Making this installation the default for injection and validation.
Istio is starting 
To configure mutual TLS authentication consult the Istio documentation.
```

Believe it or not we are done, Istio v1.0 services are being set up, you can check the deployment progress with:

watch microk8s.kubectl get all --all-namespaces
microk8s.istioctl get all --all-namespaces

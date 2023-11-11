https://www.bogotobogo.com/DevOps/Docker/Docker_Kubernetes_Headless_Service.php

Discovering pods through DNS
Now that our pods are ready, we can now try DNS lookup to see if we get the actual pod IPs or not.

We'll need to perform the lookup from inside one of the pods. However, beause our container image doesn't include the nslookup (or the dig) binary, we can't use it for the DNS lookup.

All we're trying to do is perform a DNS lookup from inside a pod running in the cluster. Why not run a new pod based on an image that contains the binaries you need? To perform DNS-related actions, you can use the tutum/dnsutils container image, which is available on Docker Hub and contains both the nslookup and the dig binaries. To run the pod, you can go through the whole process of creating a YAML manifest for it and passing it to kubectl create, but that’s too much work, right? Luckily, there’s a faster way.

kubectl run -it dnsutils --image=tutum/dnsutils --rm -- /bin/bash 
kubectl run -it dnsutils --image=tutum/dnsutils --rm -- /bin/bash 
nslookup mongo
Server:		10.152.183.10
Address:	10.152.183.10#53
Name:	mongo.mongo.svc.cluster.local
Address: 10.1.75.147

Let's do the DNS lookup from the newly created pod:

root@dnsutils:/# nslookup mongo
Server:		10.152.183.10
Address:	10.152.183.10#53

Name:	mongo.mongo.svc.cluster.local
Address: 10.1.75.147

The DNS server returns three different IPs for the bogo-headless.default.svc.cluster.local FQDN.

This is different from what DNS returns for regular (non-headless) services, such as for our bogo service, where the returned IP is the service's cluster IP:

$ kubectl exec dnsutils -- nslookup bogo-nodeport
Server:		10.96.0.10
Address:	10.96.0.10#53

Name:	bogo-nodeport.default.svc.cluster.local
Address: 10.109.23.2
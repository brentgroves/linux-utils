https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/
Manage TLS Certificates in a Cluster
Kubernetes provides a certificates.k8s.io API, which lets you provision TLS certificates signed by a Certificate Authority (CA) that you control. These CA and certificates can be used by your workloads to establish trust.

certificates.k8s.io API uses a protocol that is similar to the ACME draft.

Note: Certificates created using the certificates.k8s.io API are signed by a dedicated CA. It is possible to configure your cluster to use the cluster root CA for this purpose, but you should never rely on this. Do not assume that these certificates will validate against the cluster root CA.

https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/

https://blog.cloudflare.com/introducing-cfssl/